<?php
require('tfpdf.php');
require('config.php');
require('include/tcpdf_static.php');
require('include/tcpdf_fonts.php');
require "date.php";
require "string.php";
define('PAGEW',110);
define('WSTAMP',35);
define("HSTAMP",22);
class PDF extends tFPDF
{

    public $data = array();
    private $left = 1;
    private $right =0;
    private $top = 1;
    private $bottom = 0;

    public  $col = 3;
    public  $row = 6;
    // Page header
    function Header()
    {

    }

    // Page footer
    /*function Footer()
    {
        // Go to 1.5 cm from bottom
        $this->SetY(-10);
        // Select Arial italic 8
        $this->SetFont('Arial','I',8);
        // Print current and total page numbers
        $this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');
    }*/
    function createPage()
    {
        $this->right = WSTAMP + $this->left;
        $this->bottom = HSTAMP + $this->top;
        $datafile = $_GET['data'];
        $handle = fopen($datafile, "r");
        $contents = fread($handle, filesize($datafile));
        fclose($handle);
        $this->data = json_decode($contents,true);
        //print_r($this->data);
        $this->AddPage();
        for($i = 0;$i<$this->col;$i++)
            for($j = 0;$j<$this->row;$j++)
                $this->drawCell($i,$j);

    }
    function drawCell($x,$y)
    {
        $date = new Date();
        $string = new ObjString();
        $productname = trim($this->data['model']." ".$this->data['name']." ".$this->data['size']." ".$this->data['color']);
        $this->SetFont('Arial','B',6);
        $this->SetTextColor(0, 0, 0);
        $this->SetFillColor(204,204,204);
        $this->SetXY($this->left +($x*$this->right) ,$this->top +2 + ($this->bottom*$y));
        $this->Cell($this->right - $this->left,3,$productname,0,0,"C");
        $pathbacode = 'files/item/'.$this->data["barcode"].'.png';
        if(!file_exists($pathbacode))
        {
            file_get_contents(HTTP_SERVER."pdf/barcode/html/getbarcode.php?barcode=".$this->data['barcode']);
        }
        $this->Image($pathbacode,$this->left+ 2  +($x*$this->right) ,$this->top+7 + ($this->bottom*$y),$this->right - $this->left - 2*2,4);
        $this->SetFont('Arial','',8);
        $this->SetXY($this->left +($x*$this->right),$this->bottom - 10 + ($this->bottom*$y));
        $this->Cell($this->right - $this->left,3,$this->data['barcode'],0,0,"C");
        $this->Line($this->left+2 +($x*$this->right),$this->bottom -6 + ($this->bottom*$y),$this->right-2+($x*$this->right),$this->bottom - 6+ ($this->bottom*$y));
        $price = $this->data['price'];
        if($this->data['saleoff']>0)
            $price = $this->data['saleoff'];
        $this->SetFont('Arial','B',8);
        $this->SetXY($this->left+($x*$this->right),$this->bottom - 5 + ($this->bottom*$y));
        $this->Cell($this->right - $this->left,3,"Price: ".$this->data['setting']['currencyprefix'].$string->numberFormate($price).$this->data['setting']['currencysubfix'],0,0,"C");

        $this->Line($this->left +($x*$this->right) ,$this->top+ ($this->bottom*$y),$this->left +($x*$this->right),$this->bottom+ ($this->bottom*$y));
        $this->Line($this->left+($x*$this->right),$this->top+ ($this->bottom*$y),$this->right+($x*$this->right),$this->top+ ($this->bottom*$y));
        $this->Line($this->right +($x*$this->right) ,$this->top+ ($this->bottom*$y),$this->right +($x*$this->right),$this->bottom+ ($this->bottom*$y));
        $this->Line($this->left+($x*$this->right),$this->bottom+ ($this->bottom*$y),$this->right+($x*$this->right),$this->bottom+ ($this->bottom*$y));
    }

}
$col = $_GET['col'];
$row = $_GET['row'];
$pagew = WSTAMP * $col + $col + 1;
$pageh = HSTAMP * $row+ 28;
$pdf = new PDF('P','mm',array($pagew,$pageh));
//$pdf->AddFont('Arial','','arial.php');
$pdf->AddFont('DejaVu','','DejaVuSansCondensed.ttf',true);
$pdf->AddFont('DejaVuB','','DejaVuSansCondensed-Bold.ttf',true);
$pdf->AddFont('Arial','','arial.ttf',true);
$pdf->AddFont('ArialBD','','arialbd.ttf',true);
$pdf->SetMargins(0,0,0);
$pdf->SetDisplayMode('fullwidth','single');
//$pdf->AliasNbPages();
// convert TTF font to TCPDF format and store it on the fonts folder
//$fontname = TCPDF_FONTS::addTTFfont('D:/AppServ/www/vinamoves/pdf/arial/arial.ttf', 'TrueTypeUnicode', '', 96);
//echo $fontname;
// use the font
//$pdf->SetFont($fontname, '', 14, '', false);
//$pdf->SetMargins(6,6,6);
//$pdf->AliasNbPages();
$pdf->row = $row;
$pdf->col = $col;
$pdf->createPage();
//for($i=1;$i<=40;$i++)
//    $pdf->Cell(0,10,'Printing line number '.$i,0,1);
$pdf->Output("product".$pdf->data['productcode'].".pdf","I");