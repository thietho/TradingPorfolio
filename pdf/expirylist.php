<?php
require('tfpdf.php');
require('config.php');
require('include/tcpdf_static.php');
require('include/tcpdf_fonts.php');

class PDF extends tFPDF
{
    private function readCache($cachefile)
    {
        $handle = fopen($cachefile, 'r');
        $cache  = fread($handle, filesize($cachefile));
        fclose($handle);
        return json_decode($cache,true);
    }
    // Page header
    function Header()
    {

        // Logo
        $this->Image('logo.jpg',12,9,68);


        $this->SetFont('DejaVu','',10);
        $this->SetTextColor(98, 98, 98);
        $this->SetXY(90, 9);
        $this->Cell(60,5,"B6, Khu Biệt Thự Thanh Đa, P.27, Q.Bình Thạnh",0,1);
        $this->SetXY(90, 14);
        $this->Cell(60,5,'Điện thoại: 08 6258 9247 - 48',0,1);
        $this->SetXY(90, 19);
        $this->Cell(60,5,'Email: hotro_khohoso@vinamoves.com',0,1);
        $this->SetDrawColor(245,10,9);
        $this->Line(12,25,200,25);

        // Line break
        $this->Ln(5);
    }

    // Page footer
    function Footer()
    {
        // Position at 1.5 cm from bottom
        $this->SetY(-15);
        // Arial italic 8
        $this->SetFont('Arial','I',8);
        // Page number
        $this->Cell(0,10,'Trang '.$this->PageNo().'/{nb}',0,0,'C');
    }

    function createtemplate()
    {

        $this->SetFont('DejaVu','',10);
        $this->SetTextColor(0, 0, 0);
        $this->SetXY(12, 49);
        $this->Cell(30,5,"Khách hàng:",0,1);










    }

    function filldata($data)
    {
        $catch = @$_GET["data"];
        $data = $this->readCache("../file/vinamoves/cache/".$catch.".cache");
        //print_r($data);

        $this->SetXY(150,55);
        $this->SetFont('DejaVu','',10);
        $this->Cell(50,5,"Tổng cộng: ".count($data["items"])." thùng",0,1,"R");

        $this->SetFont('DejaVu','',10);
        $this->SetTextColor(0, 0, 0);
        $this->SetXY(36, 49);
        $this->Cell(30,5,html_entity_decode($data["name"]),0,1);

        $this->createTableHeader();
        $this->SetTextColor(0, 0, 0);
        $this->SetFont('DejaVu','',8);
        $X = 12;
        $Y = 69;
        $H = 4;

        $rowcount = 0;
        for($i=0;$i<count($data["items"]);$i++)
        {
            $items = $data["items"][$i];
            $tableheader = array("stt" => 20, "barcode" =>30, "itemcode" =>30, "ngaynhapkho" =>45, "ngayhuy" =>45,"songay"=>18);

            $intdestroydate = strtotime($items['destroydate']);
            $today = date('Y-m-d',time());
            $inttoday = strtotime($today);
            $intnumday = $intdestroydate - $inttoday;
            $numdateexpiry = (int)$intnumday / (24*60*60);

            $rowdata = array(
                "stt" => $i+1,
                "barcode" => $items["barcode"],
                "itemcode" => $items["itemcode"],
                "ngaynhapkho" => $this->getMYSQLDate($items["importdate"]),
                "ngayhuy" => $this->getMYSQLDate($items["destroydate"]),
                "songay" => $numdateexpiry." ngày"
            );
            foreach($tableheader as $key => $width)
            {
                $this->SetXY($X, $Y);
                $this->MultiCell($width,$H,$rowdata[$key],1,"C");
                $X = $X + $width;
            }
            $rowcount += 1;
            $X=12;
            $Y=$Y+$H;
            $H = 4;
            if(($i == 30 || $rowcount == 52) && $i<(count($data["items"])-1))
            {
                $this->setFooter($Y+5);

                $this->addPage();
                $rowcount = 0;
                $Y=30;
                $this->createTableHeader($Y);
                $Y=$Y+$H;
            }
        }
        $this->setFooter($Y+5);
    }

    function createTableHeader($Y = 65)
    {
        $this->SetTextColor(255, 255, 255);
        $this->SetFillColor(60,60,60);

        $this->SetFont('DejaVuB','',8);
        $tableheader = array("STT" => 20, "Barcode" =>30, "Mã thùng" =>30, "Ngày nhập kho" =>45, "Ngày hủy" =>45,"Số ngày hết hạn"=>18);
        $X = 12;
        $H = 4;
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

    function setFooter($Y){

    }



    function createPage()
    {
        $this->AddPage();

        $this->SetFont('DejaVu','',10);
        $this->SetTextColor(98, 98, 98);
        $this->SetXY(12, 30);
        $this->Cell(60,5,"Dịch vụ lưu trữ & Quản lý hồ sơ",0,1);

        $this->SetFont('DejaVuB','',15);
        $this->SetTextColor(0, 0, 0);
        $this->SetXY(12, 38);
        $this->Cell(60,5,"CÁC THÙNG HÀNG SẮP ĐẾN HẠN HỦY",0,1);



        $this->createtemplate();
        $data = array();
        $this->filldata($data);

    }

    function getMYSQLDate($datestring)
    {
        if($datestring == "")
        {
            return "";
        }
        $date = strtotime($datestring);
        if($date == "")
        {
            return "";
        }
        $return = date("d/m/Y",$date);
        if($return == "30/11/-0001")
        {
            return "";
        }
        return $return;
    }
}

// Instanciation of inherited class


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
$pdf->Output("temp/exprity.pdf","I");
?>