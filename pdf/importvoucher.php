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
		return unserialize($cache);
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
		$this->SetXY(12, 58);
		$this->Cell(30,5,"Yêu cầu bởi:",0,1);
		$this->SetXY(100, 58);
		$this->Cell(30,5,"Ngày duyệt:",0,1);
		
		$this->SetDrawColor(98,98,98);
		$this->Line(36,54,150,54);
		$this->Line(36,63,98,63);
		$this->Line(122,63,150,63);
		
		$this->SetDrawColor(180,180,180);
		
		$this->Rect(12,70,92,35);
		$this->SetFont('DejaVuB','',10);
		$this->SetXY(14, 72);
		$this->Cell(30,5,"Thông tin liên hệ",0,1);
		
		
		$this->Rect(108,70,92,35);
		$this->SetFont('DejaVuB','',10);
		$this->SetXY(110, 72);
		$this->Cell(30,5,"Địa chỉ giao/nhận hàng",0,1);
		
		$this->SetXY(12, 108);
		$this->Cell(30,5,"Danh sách hàng hóa",0,1);
		
		
		
		
	}
	
	
	
	function filldata($data)
	{
		$requestcode = @$_GET["requestcode"];
		$data = $this->readCache("../file/vinamoves/cache/pdf".$requestcode.".cache");
		
		$this->SetDrawColor(180,180,180);
		$this->Rect(155,44,45,20);
		
		$barcodefile = 'files/voucher/'.$data["requestcode"].'.png';
		if(!file_exists($barcodefile))
		{
				
			file_get_contents(HTTP_SERVER."pdf/barcode/html/maphieu.php?code=".$data["requestcode"]);
		}
		
		$this->Image($barcodefile,160,31,30);
		
		$this->SetFont('DejaVu','',9);
		$this->SetTextColor(0, 0, 0);
		$this->SetXY(156, 46);
		$this->Cell(48,5,"Mã phiếu: ".$data["requestcode"],0,1,"L");
		$this->SetXY(156, 51);
		$this->Cell(48,5,"Ngày lập: ".$this->getMYSQLDate($data["createdate"]),0,1,"L");
		$this->SetXY(156, 56);
		$this->Cell(48,5,"Hình thức: ".$data["requesttype"],0,1,"L");
		
		
		$this->SetXY(150,108);
		$this->SetFont('DejaVu','',10);
		$this->Cell(50,5,"Tổng cộng: ".$data["itemcount"]." thùng",0,1,"R");
		
		$this->SetFont('DejaVu','',10);
		$this->SetTextColor(0, 0, 0);
		$this->SetXY(36, 49);
		$this->Cell(30,5,html_entity_decode($data["customername"]),0,1);
		$this->SetXY(36, 58);
		$this->Cell(30,5,$data["accountname"],0,1);
		$this->SetXY(122, 58);
		$this->Cell(30,5,$data["approvedate"],0,1);
		
		$this->SetFont('DejaVu','',10);
		$this->SetXY(14, 77);
		$this->Cell(30,5,$data["shippingfullname"],0,1);
		$this->SetXY(14, 82);
		$this->Cell(30,5,"Bộ phận: ".html_entity_decode($data["shippingdepartment"]),0,1);
		$this->SetXY(14, 87);
		$this->Cell(30,5,"Điện thoại: ".$data["shippingphone"],0,1);
		$this->SetXY(14, 92);
		$this->Cell(30,5,"Email: ".$data["shippingemail"],0,1);
		
		$this->SetFont('DejaVu','',10);
		$this->SetXY(110, 77);
		$this->MultiCell(88,5,$data["shippingaddress"]);
		$this->SetXY(110, 88);
		$this->SetFont('DejaVuB','',10);
		$this->Cell(30,5,"Nhân viên giao nhận:",0,1);
		$this->SetXY(110, 93);
		$this->SetFont('DejaVu','',10);
		$delivername = $data["deliverystaffname"];
		if($data["deliveryphone"] != "")
		{
			$delivername .= " (".$data["deliveryphone"].")";
		}
		$this->MultiCell(88,5,$delivername,0,"L");
		$this->SetXY(110, 98);
		$this->MultiCell(88,5,"Biển số xe: ".$data["carnumber"],0,"L");
		
		
		$this->createTableHeader();
		
		
		$this->SetTextColor(0, 0, 0);
		$this->SetFont('DejaVu','',8);
		$X = 12;
		$Y = 119;
		$H = 4;
		
		$rowcount = 0;
		for($i=0;$i<$data["itemcount"];$i++)
		{
			$items = $data["items"][$i];
			$tableheader = array("stt" => 20, "barcode" =>39, "itemcode" =>39, "quanlyboi" =>60, "ngayluukho" =>30);
			$rowdata = array(
				"stt" => $i+1,
				"barcode" => $items["barcode"],
				"itemcode" => $items["itemcode"],
				"quanlyboi" => $data["accountname"],
				"ngayluukho" => $this->getMYSQLDate($data["createdate"])
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
			if(($i == 30 || $rowcount == 52) && $i<($data["itemcount"]-1))
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
	
	function createTableHeader($Y = 115)
	{
		$this->SetTextColor(255, 255, 255);
		$this->SetFillColor(60,60,60);
		
		$this->SetFont('DejaVuB','',8);
		$tableheader = array("STT" => 20, "Barcode" =>39, "Mã thùng" =>39, "Quản lý bởi" =>60, "Ngày lưu kho" =>30);
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
		$this->SetXY(12, $Y);
		$this->SetFont('DejaVuB','',10);
		$this->Cell(60,5,'Đại diện khách hàng',0,1,"C");
		
		$this->SetXY(76, $Y);
		$this->Cell(60,5,'Người lập phiếu',0,1,"C");
		
		$this->SetXY(140, $Y);
		$this->Cell(60,5,'Xác nhận của Vinamoves',0,1,"C");
		
		
		$this->SetFont('DejaVu','',8);
		$this->SetTextColor(120, 120, 120);
		
		$this->SetXY(12, $Y+5);
		$this->MultiCell(60,5,'(Ký tên, ghi rõ họ tên, chức vụ, đóng dấu)',0,"C");
		
		$this->SetXY(76, $Y+5);
		$this->MultiCell(60,5,'(Ký tên, ghi rõ họ tên, chức vụ)',0,"C");
		
		$this->SetXY(140, $Y+5);
		$this->MultiCell(60,5,'(Ký tên, ghi rõ họ tên, chức vụ, đóng dấu)',0,"C");
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
		$this->Cell(60,5,"PHIẾU YÊU CẦU DỊCH VỤ",0,1);
		
		
		
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
$pdf->Output("temp/bbb.pdf","I");
?>