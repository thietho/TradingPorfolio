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
	
	
	
	
	
	function createPage($blockid)
	{
		$this->AddPage();
		
		$pathfile = 'files/block/'.$blockid.'.png';
        if(!file_exists($pathfile))
        {
            file_get_contents(HTTP_SERVER."pdf/barcode/html/mablock.php?blockid=".$blockid);
        }
		// Logo
		$this->Image($pathfile,9,26,80);
		
		// Arial bold 15
		
		$this->SetFont('DejaVu','',10);
		// Move to the right
		//$this->Cell(1);
		// Title
		//$this->Cell(0,8,'',0,1);
		
		$this->SetFont('DejaVuB','',12);
		$this->Cell(30,5,'VINAMOVES',0,1);
		
		$this->SetXY(5, 12);
		$this->SetFont('DejaVuB','',18);
		$this->Cell(30,4,$blockid,0,1);
		
		
		
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

/*if(isset($_GET["barcode"]))
{
	$data = readCache("../file/vinamoves/cache/".$_GET["barcode"].".cache");
	$pdf->createPage($data);
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
}*/


if(isset($_GET["blockid"]))
{
	$blockid = $_GET["blockid"];
	if(!file_exists("files/block/".$blockid.".png"))
	{
		file_get_contents(HTTP_SERVER."pdf/barcode/html/mablock.php?blockid=".$blockid);
	}
	$pdf->createPage($blockid);
}

if(isset($_GET["blocklist"]))
{
	$blocklist = $_GET["blocklist"];
	$arrblock = explode(',', $blocklist);

	foreach($arrblock as $blockid)
	{

		if(!file_exists("files/block/".$blockid.".png"))
		{
			file_get_contents(HTTP_SERVER."pdf/barcode/html/mablock.php?blockid=".$blockid);
		}
		$pdf->createPage($blockid);

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