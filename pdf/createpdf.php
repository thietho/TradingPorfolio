<?php
require('tfpdf.php');
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
	
	
	
	
	
	function createPage()
	{
		$this->AddPage();
		
		// Logo
		$this->Image('barcode/image/D1000002.png',9,26,80);
		
		// Arial bold 15
		
		$this->SetFont('DejaVu','',10);
		// Move to the right
		//$this->Cell(1);
		// Title
		//$this->Cell(0,8,'',0,1);
		
		$this->SetFont('DejaVuB','',10);
		$this->Cell(30,5,"Trần Hưng Đạo",0,1);
		
		
		
		
		
		
		
		
		
		$this->SetFont('DejaVu','',10);
		$this->Cell(30,4,'Chi nhanh TP HCM',0,1);
		
		$this->SetXY(5, 18);
		$this->SetFont('DejaVu','',14);
		$this->Cell(30,4,'AH-1205-93',0,1);
		
		$this->SetFont('DejaVu','',10);
		$this->SetXY(40, 8);
		$this->Cell(0,13,'VINAMOVES',0,1,'R');
		$this->SetXY(40, 14);
		$this->Cell(0,13,'Package: 25/9/2015',0,1,'R');
		
		
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
for($i=0;$i<1000;$i++){
	$pdf->createPage();
}

$pdf->createPage();




//for($i=1;$i<=40;$i++)
//    $pdf->Cell(0,10,'Printing line number '.$i,0,1);
$pdf->Output("temp/bbb.pdf","I");
?>