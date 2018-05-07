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
        $this->Image('logo.png',$this->papdingleft,3,40);


        $this->SetFont('DejaVu','',8);
        $this->SetTextColor(98, 98, 98);
        $this->SetXY($this->papdingleft + 44, 3);
        $this->Cell(0,3,"CÔNG TY TNHH CUỘC SỐNG ĐIỆN TỬ VÀ ĐỐI TÁC",0,1);
        $this->SetFont('Arial','B',12);
        $this->SetXY($this->papdingleft + 44, 3);
        $this->Cell(0,11,"Elife Partners",0,1);

        $this->SetFont('Arial','',7);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,3,"Tầng 19, Indochina Park Tower",0,1);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,10,"4 Nguyễn Đình Chiểu, P.Đa Kao, Quận 1, HCMC",0,1);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,17,"Phone: +84 30391393",0,1);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,24,"Fax: +84 12312827",0,1);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,31,"Email: info@elifepartners.com",0,1);
        $this->SetXY($this->papdingleft+144, 3);
        $this->Cell(0,38,"Website: elifepartners.com",0,1);
    }

    // Page footer
    function Footer()
    {

    }
    private $papdingleft = 6;
    private $papdingright = 204;
    private $rowh = 5;
    function createtemplate()
    {
        $date = new Date();
        $string = new ObjString();
        $this->SetFont('DejaVuB','',10);
        $this->SetTextColor(0, 0, 0);
        $this->SetXY(160, 30);
        $this->Cell(0,5,"No.:",0,1);
        $this->SetXY(172, 30);
        $this->Cell(0,5,$this->data['orderid'],0,1);
        $this->SetDrawColor(98,98,98);
        $this->Line(172,34,$this->papdingright,34);

        $this->SetXY(160, 30);
        $this->Cell(0,18,"Date:",0,1);
        $this->SetXY(172, 30);
        $this->Cell(0,18, $date->formatMySQLDate($this->data['orderdate']),0,1);
        $this->SetDrawColor(98,98,98);
        $this->Line(172,40,$this->papdingright,40);
        $this->SetXY($this->papdingleft,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,0,"Billling Infomation",0,1,"C");
        $this->SetXY($this->papdingleft+2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,12,$this->data['fullname'],0,1);
        $this->SetXY($this->papdingleft+2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,22,$this->data['addressline1'],0,1);
        $this->SetXY($this->papdingleft+2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,32,$this->data['addressline2'],0,1);
        $this->SetXY($this->papdingleft+2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,42,$this->data['email'],0,1);
        $this->SetXY($this->papdingleft+2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,52,$this->data['phone'],0,1);

        $this->SetXY(($this->papdingright-$this->papdingleft)/2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,0,"Shipping Infomation",0,1,"C");
        $this->SetXY(($this->papdingright-$this->papdingleft)/2 + 2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,12,$this->data['shipment_name'],0,1);
        $this->SetXY(($this->papdingright-$this->papdingleft)/2 + 2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,22,$this->data['shipment_addressline1'],0,1);
        $this->SetXY(($this->papdingright-$this->papdingleft)/2 + 2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,32,$this->data['shipment_addressline2'],0,1);
        $this->SetXY(($this->papdingright-$this->papdingleft)/2 + 2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,42,$this->data['shipment_email'],0,1);
        $this->SetXY(($this->papdingright-$this->papdingleft)/2 + 2,50);
        $this->Cell(($this->papdingright-$this->papdingleft)/2,52,$this->data['shipment_phone'],0,1);

        $this->createTableHeader(80);
        $this->createTableBody(85);
        //$this->setFooter(100);
    }
    function createTableHeader($Y = 80)
    {
        $this->SetTextColor(255, 255, 255);
        $this->SetFillColor(60,60,60);

        $this->SetFont('DejaVuB','',8);
        $tableheader = array("STT" => 10, "Barcode" =>25, "Item" =>70, "Qty" =>10, "Price" =>15,"Discount" => 15);
        $X = $this->papdingleft;
        $H = $this->rowh;
        foreach($tableheader as $key => $width)
        {
            $this->SetXY($X, $Y);
            $this->Rect($X,$Y,$width,$H,"DF");
            $this->MultiCell($width,$H,$key,1,"C");
            $X = $X + $width;
        }

        $this->SetTextColor(0, 0, 0);
        $this->SetFont('DejaVu','',8);
    }

    public function createTableBody($Y = 84)
    {
        $this->SetTextColor(0, 0, 0);
        $this->SetFont('DejaVu','',8);
        $X = $this->papdingleft;
        $H = $this->rowh;
        $string = new ObjString();
        $rowcount = 0;
        foreach ($this->data['orderproducts'] as $i => $orderproduct)
        {
            $tableheader = array("stt" => 10, "barcode" =>25, "item" =>70, "quantity" =>10, "price" =>15,"discount" => 15);
            $tablecelltype = array("stt" => "C", "barcode" =>"L", "item" =>"L", "quantity" =>"R", "price" =>"R","discount"=>"R" );
            $price = $string->toNumber($orderproduct['price']);
            $saleoff = $string->toNumber($orderproduct['saleoff']);
            $discount = ($price - $saleoff)/$price*100 . '%';
            if($saleoff == 0)
                $discount = '';
            $tax = $orderproduct['tax'];
            $taxcode = $orderproduct['taxcode'];
            $rowdata = array(
                "stt" => $i+1,
                "barcode" => $orderproduct["barcode"],
                "item" => $orderproduct["model"] . " " . $orderproduct['name'] . " " . $orderproduct['size']." ".$orderproduct['color'],
                "quantity" => $orderproduct["quantity"],
                "price" => $orderproduct['price'],
                "discount" => $discount
            );
            foreach($tableheader as $key => $width)
            {
                $this->SetXY($X, $Y);
                $this->MultiCell($width,$H,$rowdata[$key],1,$tablecelltype[$key]);
                $X = $X + $width;
            }
            $rowcount += 1;
            $X=$this->papdingleft;
            $Y=$Y+$H;
            $H = $this->rowh;
            if(($i == 30 || $rowcount == 52) && $i<(count($this->data['orderproducts']['id'])-1))
            {
                $this->setFooter($Y+5);

                $this->addPage();
                $rowcount = 0;
                $Y=30;
                $this->createTableHeader($Y);
                $Y=$Y+$H;
            }
        }
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
        $this->Cell(0,5,"Invoice",0,1);

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