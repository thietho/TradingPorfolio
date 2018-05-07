<?php
require('tfpdf.php');
require('config.php');
require('include/tcpdf_static.php');
require('include/tcpdf_fonts.php');
require "date.php";
require "string.php";

class PDF extends tFPDF
{
    // Page header
    public $data = array();
    function Header()
    {

        // Logo
        if($this->data['setting']['logo'])
            $this->Image($this->data['setting']['logo'],$this->papdingleft,3,40);
        else
            $this->Image("logo.png",$this->papdingleft,3,40);
        $this->SetFont('DejaVu','',8);
        $this->SetTextColor(98, 98, 98);
        $this->SetXY($this->papdingleft + 44, 3);
        $this->Cell(0,3,$this->data['setting']['companylongname'],0,1);
        $this->SetFont('Arial','B',12);
        $this->SetXY($this->papdingleft + 44, 3);
        $this->Cell(0,11,$this->data['setting']['companyname'],0,1);

        $this->SetFont('Arial','',7);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,3,$this->data['setting']['addressline1'],0,1);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,10,$this->data['setting']['addressline2'],0,1);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,17,"Phone: ".$this->data['setting']['phone'],0,1);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,24,"Fax: ".$this->data['setting']['fax'],0,1);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,31,"Email: ".$this->data['setting']['email'],0,1);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,38,"Website: ".$this->data['setting']['website'],0,1);
    }

    // Page footer
    function Footer()
    {

    }
    private $papdingleft = 6;
    private $papdingright = 204;
    function createtemplate()
    {
        $date = new Date();
        $string = new ObjString();
        $this->SetFont('DejaVuB','',10);
        $this->SetTextColor(0, 0, 0);
        $this->SetXY(160, 30);
        $this->Cell(0,5,"No.:",0,1);
        $this->SetXY(172, 30);
        $this->Cell(0,5,$this->data['invoiceid'],0,1);
        $this->SetDrawColor(98,98,98);
        $this->Line(172,34,$this->papdingright,34);

        $this->SetXY(160, 30);
        $this->Cell(0,18,"Date:",0,1);
        $this->SetXY(172, 30);
        $this->Cell(0,18, $date->formatMySQLDate($this->data['invoicedate']),0,1);
        $this->SetDrawColor(98,98,98);
        $this->Line(172,40,$this->papdingright,40);


        $this->SetFont('DejaVuB','',10);
        $this->SetTextColor(0, 0, 0);
        $this->SetXY($this->papdingleft, 49);
        $this->Cell(30,5,"Payor:",0,1);
        $this->SetXY($this->papdingleft+19, 49);
        $this->Cell(30,5,$this->data['cardname'],0,1);
        $this->SetDrawColor(98,98,98);
        $this->Line($this->papdingleft+19,53,$this->papdingright,53);

        $this->SetXY($this->papdingleft, 49);
        $this->Cell(30,25,"Address:",0,1);
        $this->SetXY($this->papdingleft+19, 49);
        $this->Cell(30,25,$this->data['addressline1']." ".$this->data['addressline2'],0,1);
        $this->SetDrawColor(98,98,98);
        $this->Line($this->papdingleft+19,63,$this->papdingright,63);

        $this->SetXY($this->papdingleft, 49);
        $this->Cell(30,45,"For:",0,1);
        $this->SetXY($this->papdingleft+19, 49);
        $this->Cell(30,45,$this->data['billnumber'].$this->data['orderid'],0,1);
        $this->SetDrawColor(98,98,98);
        $this->Line($this->papdingleft+19,73,$this->papdingright,73);

        $this->SetXY($this->papdingleft, 49);
        $this->Cell(30,65,"Amount:",0,1);
        $this->SetXY($this->papdingleft+19, 49);
        $this->Cell(30,65,$this->data['setting']['currencyprefix'].$string->numberFormate($this->data['amount']*-1).$this->data['setting']['currencysubfix'],0,1);
        $this->SetDrawColor(98,98,98);
        $this->Line($this->papdingleft+19,83,80,83);
        if($this->data['tax']){
            $this->SetXY(83, 49);
            $this->Cell(30,65,"(Tax ".$this->data['tax']."% inlucsive)",0,1);
        }

        $this->SetXY($this->papdingleft+19, 49);
        $this->Cell(30,75,"(In words:".$string->doc_so($this->data['amount']*-1).")",0,1);
        $this->setFooter(100);
    }

    private $footer = array(
        "Director",
        "Payee",
        "Recever",
        "Cashier Manager"
    );
    function setFooter($Y){
        $this->SetFillColor(100);
        $this->SetFont('DejaVuB','',10);

        $widthpage = $this->papdingright - $this->papdingleft;
        $widthcell = $widthpage / count($this->footer);
        foreach ($this->footer as $key => $text)
        {
            $this->SetXY($this->papdingleft+($key*$widthcell), $Y);
            $this->Cell($widthcell,5,$text,0,1,"C");

            $this->SetDrawColor(98,98,98);
            $this->Line($this->papdingleft+($key*$widthcell)+2,$Y+30,$this->papdingleft+(($key+1)*$widthcell)-2,$Y+30);
        }

        $this->SetFont('DejaVu','',8);
        $this->SetTextColor(120, 120, 120);

        $this->SetXY($this->papdingleft, $Y-6);
        $this->Cell(60,5,'Please give us your signature and fullname');

    }



    function createPage()
    {
        $datafile = $_GET['data'];
        $handle = fopen($datafile, "r");
        $contents = fread($handle, filesize($datafile));
        fclose($handle);
        $this->data = json_decode($contents,true);
        //print_r($this->data);
        $this->AddPage();

        $this->SetFont('DejaVuB','',35);
        $this->SetTextColor(0, 0, 0);
        $this->SetXY(6, 30);
        $this->Cell(0,5,"Payment Voucher",0,1);

        $this->createtemplate();
    }
}

// Instanciation of inherited class

//print_r($_POST);
$pdf = new PDF();
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

$pdf->SetMargins(6,6,6);
$pdf->AliasNbPages();
$pdf->createPage();




//for($i=1;$i<=40;$i++)
//    $pdf->Cell(0,10,'Printing line number '.$i,0,1);
$pdf->Output("temp/bbb.pdf","I");
?>