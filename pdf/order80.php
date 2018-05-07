<?php
require('tfpdf.php');
require('config.php');
require('include/tcpdf_static.php');
require('include/tcpdf_fonts.php');
require "date.php";
require "string.php";
class PDF extends tFPDF
{

    public $data = array();
    private $papdingleft = 6;
    private $papdingright = 74;
    private $rowh = 4;
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
        $date = new Date();

        $datafile = $_GET['data'];
        $handle = fopen($datafile, "r");
        $contents = fread($handle, filesize($datafile));
        fclose($handle);
        $this->data = json_decode($contents,true);
        //print_r($this->data);
        $this->AddPage();
        $this->SetFont('Arial','',8);
        $this->SetTextColor(0, 0, 0);
        $this->SetXY($this->papdingleft, 3);
        $this->Cell($this->papdingright - $this->papdingleft,3,$this->data['setting']['companylongname'],0,1,"C");
        $this->SetFont('Arial','b',15);
        $this->SetTextColor(0, 0, 0);
        $this->SetXY($this->papdingleft, 3);
        $this->Cell($this->papdingright - $this->papdingleft,12,$this->data['setting']['companyname'],0,1,"C");

        $this->SetFont('Arial','',7);
        $this->SetXY($this->papdingleft, 3);
        $this->Cell($this->papdingright - $this->papdingleft,20,$this->data['setting']['addressline1'],0,1,"C");
        $this->SetXY($this->papdingleft, 3);
        $this->Cell($this->papdingright - $this->papdingleft,26,$this->data['setting']['addressline2'],0,1,"C");
        $this->SetXY($this->papdingleft, 3);
        $this->Cell($this->papdingright - $this->papdingleft,32,"Phone: ".$this->data['setting']['phone'],0,1,"C");
        $this->SetXY($this->papdingleft, 3);
        $this->Cell($this->papdingright - $this->papdingleft,38,"Fax: ".$this->data['setting']['fax'],0,1,"C");
        $this->SetXY($this->papdingleft, 3);
        $this->Cell($this->papdingright - $this->papdingleft,44,"Email: ".$this->data['setting']['email'],0,1,"C");
        $this->SetXY($this->papdingleft, 3);
        $this->Cell($this->papdingright - $this->papdingleft,50,"Website: ".$this->data['setting']['website'],0,1,"C");

        $this->SetFont('Arial','',8);
        $this->SetXY($this->papdingleft, 33);
        $this->Cell($this->papdingright - $this->papdingleft,0,"Date: ".$date->formatMySQLDate($this->data['orderdate']),0,1);
        $this->SetFont('Arial','B',10);
        $this->SetXY($this->papdingleft, 33);
        $this->Cell($this->papdingright - $this->papdingleft,10,"Invoice",0,1,"C");
        $this->SetFont('Arial','',8);
        $this->SetXY($this->papdingleft, 33);
        $this->Cell($this->papdingright - $this->papdingleft,17,$this->data['orderid'],0,1,"C");
        $this->SetXY($this->papdingleft, 33);
        $this->Cell($this->papdingright - $this->papdingleft,28,"Saler: ".$this->data['salebyname'],0,1);
        $ycurent = $this->showDetail(52);
        //$ycurent = 52;
        $ycurent+=6;
        $this->SetFont('Arial','',8);
        $this->SetXY($this->papdingleft, $ycurent);
        $this->Cell($this->papdingright - $this->papdingleft,4,"Thank you",0,1,"C");
        $ycurent+=4;
        $this->SetFont('Arial','',8);
        $this->SetXY($this->papdingleft, $ycurent);
        $this->Cell($this->papdingright - $this->papdingleft,4,"See you again",0,1,"C");

    }
    private function showDetail($y)
    {
        $string = new ObjString();
        $this->SetFont('Arial','B',8);
        $this->SetXY($this->papdingleft+25, $y);
        $this->Cell(15,4,"Price",0,1,"R");
        $this->SetXY($this->papdingleft+35, $y);
        $this->Cell(12,4,"Qty",0,1,"R");
        $this->SetXY($this->papdingleft+40, $y);
        $this->Cell($this->papdingright - $this->papdingleft-40,4,"Sub Total",0,1,"R");
        $this->SetFont('Arial','',8);
        $ycurent = $y;
        $datatable = array();
        if(isset($this->data['orderproducts']))
            foreach ($this->data['orderproducts'] as $i => $orderproduct)
            {
                $price = $orderproduct["price"];
                if($orderproduct["saleoff"]!=0)
                {
                    $price = $orderproduct["saleoff"];
                }
                $row = array(
                    'name' => $orderproduct["model"] . " " . $orderproduct['name'] . " " . $orderproduct['size']." ".$orderproduct['color'],
                    'code' => $orderproduct["barcode"],
                    'price' => $price,
                    'quantity' => $orderproduct['quantity'],
                    'subtotal' => $orderproduct['subtotal']
                );
                $datatable[] = $row;
            }
        if(isset($this->data['orderjobs']))
            foreach ($this->data['orderjobs'] as $i => $orderjob)
            {
                $row = array(
                    'name' => $orderjob['jobname'],
                    'code' => $orderjob["jobcode"],
                    'price' => $orderjob['price'],
                    'quantity' => $orderjob['quantity'],
                    'subtotal' => $orderjob['subtotal']
                );
                $datatable[] = $row;
            }

        foreach ($datatable as $i => $row)
        {
            $this->SetXY($this->papdingleft, $y+5 + ($i)*9);
            $this->Cell($this->papdingleft,4,trim($row['name']),0,1);
            $this->SetXY($this->papdingleft, $y+9 + ($i)*9);
            $this->Cell($this->papdingleft,4,$row['code']);
            $this->SetXY($this->papdingleft+25, $y+9 + ($i)*9);
            $this->Cell(15,4,$string->numberFormate($row['price']),0,0,"R");
            $this->SetXY($this->papdingleft+35, $y+9 + ($i)*9);
            $this->Cell(12,4,$row['quantity'],0,0,"R");
            $this->SetXY($this->papdingleft+40, $y+9 + ($i)*9);
            $this->Cell($this->papdingright - $this->papdingleft-40,4,$this->data['setting']['currencyprefix'].$string->numberFormate($row['subtotal']).$this->data['setting']['currencysubfix'],0,0,"R");
            $this->Line($this->papdingleft,$y+14+($i)*9,$this->papdingright -30,$y+14+($i)*9);
            $ycurent = $y+9+($i)*9;
        }
        $ycurent += 7;
        $this->SetXY($this->papdingleft, $ycurent);
        $this->Cell($this->papdingleft + 35,4,"Total Order",0,1,"R");
        $this->SetXY($this->papdingleft +40, $ycurent);
        $this->Cell($this->papdingright - $this->papdingleft-40,4,$this->data['setting']['currencyprefix'].$string->numberFormate($this->data['total']).$this->data['setting']['currencysubfix'],0,1,"R");
        $paid = 0;
        if(isset($this->data['invoices']))
            foreach ($this->data['invoices'] as $invoice)
            {
                $paid += $invoice['amount'];
            }
        $ycurent += 4;
        $this->SetXY($this->papdingleft, $ycurent);
        $this->Cell($this->papdingleft + 35,4,"Paid",0,1,"R");
        $this->SetXY($this->papdingleft +40, $ycurent);
        $this->Cell($this->papdingright - $this->papdingleft-40,4,$this->data['setting']['currencyprefix'].$string->numberFormate($paid).$this->data['setting']['currencysubfix'],0,1,"R");
        $ycurent += 4;
        $this->SetXY($this->papdingleft, $ycurent);
        $this->Cell($this->papdingleft + 35,4,"Change",0,1,"R");
        $this->SetXY($this->papdingleft +40, $ycurent);
        $this->Cell($this->papdingright - $this->papdingleft-40,4,$this->data['setting']['currencyprefix'].$string->numberFormate( $this->data['total']-$paid).$this->data['setting']['currencysubfix'],0,1,"R");
        return $ycurent;
    }
}
$datafile = $_GET['data'];
$handle = fopen($datafile, "r");
$contents = fread($handle, filesize($datafile));
fclose($handle);
$data = json_decode($contents,true);
$totalrow = count($data['orderproducts']);
if(isset($data['orderjobs']))
    $totalrow+=count($data['orderjobs']);
$h = $totalrow * 12 +17 + 87;
// Instanciation of inherited class
$pdf = new PDF('P','mm',array(80,$h));
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
//$pdf->SetMargins(6,6,6);
//$pdf->AliasNbPages();

$pdf->createPage();
//for($i=1;$i<=40;$i++)
//    $pdf->Cell(0,10,'Printing line number '.$i,0,1);
$pdf->Output("order".$pdf->data['orderid'].".pdf","I");