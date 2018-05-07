<?php
$getcode = "code39";
$getThickness = 30;
$getResolution = 1;
$getText = $_GET["code"];
$getFontSize = 3;
$getOutput = 1;
$getA1 = "";
$getA2 = "";

if(isset($getcode) && isset($getThickness) && isset($getResolution) && isset($getText) && isset($getFontSize) && isset($getOutput) && isset($getA1) && isset($getA2)){

	define('IN_CB',true);
	require('../class/index.php');
	require('../class/FColor.php');
	require('../class/BarCode.php');
	require('../class/FDrawing.php');
	if(include('../class/'.$getcode.'.barcode.php')){
		$color_black = new FColor(0,0,0);
		$color_white = new FColor(255,255,255);
		
		$code = $getText;
		if(!empty($getA2))
		$code_generated = new $getcode($getThickness,$color_black,$color_white,$getResolution,$code,$getFontSize,$getA1,$getA2);
		elseif(!empty($getA1))
			$code_generated = new $getcode($getThickness,$color_black,$color_white,$getResolution,$code,$getFontSize,$getA1);
		else
			$code_generated = new $getcode($getThickness,$color_black,$color_white,$getResolution,$code,$getFontSize);
		
		$drawing = new FDrawing(1024,1024,"../../files/voucher/".$getText.'.png',$color_white);
		$drawing->init();
		$drawing->add_barcode($code_generated);
		$drawing->draw_all();
		$im = $drawing->get_im();
		$im2 = imagecreate($code_generated->lastX,$code_generated->lastY);
		imagecopyresized($im2, $im, 0, 0, 0, 0, $code_generated->lastX, $code_generated->lastY, $code_generated->lastX, $code_generated->lastY);
		$drawing->set_im($im2);
		//header('Content-Type: image/png');
		$drawing->finish($getOutput);
		
		//echo "barcode/image/".$_GET["text"].'.png';
	}
	else{
		header('Content: image/png');
		readfile('error.png');
	}
}
else{
	header('Content: image/png');
	readfile('error.png');
}
?>