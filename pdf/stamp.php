<?php
require('tfpdf.php');
require('config.php');
require('include/tcpdf_static.php');
require('include/tcpdf_fonts.php');

class PDF extends tFPDF
{
	
	
	// Page header
	function Header()
	{
		
	}

	// Page footer
	function Footer()
	{
		
	}
	function createPage($data)
	{
		$this->AddPage();
		
		
		// Logo
        $pathbacode = 'files/item/'.$data["barcode"].'.png';

        if(!file_exists($pathbacode))
        {
            file_get_contents(HTTP_SERVER."pdf/barcode/html/getbarcode.php?barcode=".$data['barcode']);
        }
		$this->Image($pathbacode,9,26,80);
		
		// Arial bold 15
		
		$this->SetFont('DejaVu','',10);
		// Move to the right
		//$this->Cell(1);
		// Title
		//$this->Cell(0,8,'',0,1);
		
		$this->SetFont('DejaVuB','',8);
		//$this->Cell(30,5,$data["customername"],0,1);
		$this->MultiCell(90,4,$data["customername"],0,"L");
		
		$this->SetFont('DejaVu','',12);
		$this->Cell(30,4,$data["accountname"],0,1);
		
		$this->SetXY(5, 18);
		$this->SetFont('DejaVuB','',18);
		$this->Cell(30,4,$data["itemcode"],0,1);
		
		$this->SetFont('DejaVu','',10);
		$this->SetXY(40, 8);
		$this->Cell(0,13,'VINAMOVES',0,1,'R');
		$this->SetXY(40, 14);
		$this->Cell(0,13,''.$data["createdate"],0,1,'R');

		// Line break
		$this->Ln(20);
		
	}
}

// Instanciation of inherited class
$pdf = new PDF('L','mm',array(100,50));
//$pdf->AddFont('Arial','','arial.php');
$pdf->AddFont('DejaVu','','DejaVuSansCondensed.ttf',true);
$pdf->AddFont('DejaVuB','','DejaVuSansCondensed-Bold.ttf',true);
$pdf->AddFont('Arial','','arial.ttf',true);
$pdf->AddFont('ArialBD','','arialbd.ttf',true);

// convert TTF font to TCPDF format and store it on the fonts folder
//$fontname = TCPDF_FONTS::addTTFfont('D:/AppServ/www/vinamoves/pdf/arial/arial.ttf', 'TrueTypeUnicode', '', 96);
//echo $fontname;
// use the font
//$pdf->SetFont($fontname, '', 14, '', false);

$pdf->SetMargins(5,3,6);
$pdf->AliasNbPages();

if(isset($_GET["barcode"]))
{
	$data = readCache("../file/vinamoves/cache/".$_GET["barcode"].".cache");
	$pdf->createPage($data);
}
elseif(isset($_GET["barcodes"]))
{
	$barcodes = $_GET["barcodes"];
	$barcodes = rtrim($barcodes, ',');
	$arr = explode(",", $barcodes);
	$requestid = $_GET["id"];
	foreach($arr as $barcode)
	{
		$filepath = "../file/vinamoves/cache/".$barcode.".cache";
		
		if(!file_exists($filepath))
		{
			file_get_contents(HTTP_SERVER."index.php?route=module/import&id=".$requestid."&type=barcode&barcode=".$barcode);
		}
		$data = readCache($filepath);
		$pdf->createPage($data);	
	}
	
}
else
{
	$request = readCache("../file/vinamoves/cache/pdf.cache");
	$items = readCache("../file/vinamoves/cache/items.cache");
	foreach($items as $data)
	{
		$data["customername"] = $request["customername"];
		$data["accountname"] = $request["accountname"];
		$data["createdate"] = $request["createdate"];
		$pdf->createPage($data);
	}	
}





//for($i=1;$i<=40;$i++)
//    $pdf->Cell(0,10,'Printing line number '.$i,0,1);
$pdf->Output("temp/bbb.pdf","I");


function readCache($cachefile)
{
	$handle = fopen($cachefile, 'r');
	$cache  = fread($handle, filesize($cachefile));	
	fclose($handle);
	return unserialize($cache);
}
?>