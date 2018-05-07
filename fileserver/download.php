<?php
error_reporting(0);
define("DIR_FILE", "file_" . $_GET['site'] . "/file/");
define("DIR_WEBFILE", "");
define("WATERLOGO_POSITION", "BottomRight"); //TopLeft, TopRight, BottomLeft, BottomRight
require_once("system/library/image.php");
require_once("system/helper/image.php");
$path = $_GET['path'];
$width = $_GET['width'];
$height = $_GET['height'];
$resizetype = $_GET['type'];

if ($path != "" && $resizetype != "" && file_exists(DIR_FILE . $path)) {
    switch ($resizetype) {
        case "resize":
            $file = DIR_FILE . HelperImage::resize($path, $width, $height);
            break;
        case "resizeblack":
            $file = DIR_FILE . HelperImage::resize($path, $width, $height, "#090909");
            break;
        case "resizepng":
            $file = DIR_FILE . HelperImage::resizePNG($path, $width, $height);
            break;
        case "autosize":
            $file = DIR_FILE . HelperImage::autosizePNG($path, $width, $height);
            break;
        case "fixsize":
            $file = DIR_FILE . HelperImage::fixsize($path, $width, $height);
            break;
        case "root":
            $file = DIR_FILE . HelperImage::getroot($path);
            break;
        default:
            $file = DIR_FILE . HelperImage::resize($path, $width, $height);
            break;
    }


    if (file_exists($file)) {
        $extension = '';
        $pos = strripos($file, ".");
        if ($pos !== FALSE) {
            $extension = substr($file, $pos+1);
        }
        switch( $extension )
        {
            case "pdf": $ctype="application/pdf"; break;
            case "exe": $ctype="application/octet-stream"; break;
            case "zip": $ctype="application/zip"; break;
            case "doc": $ctype="application/msword"; break;
            case "xls": $ctype="application/vnd.ms-excel"; break;
            case "ppt": $ctype="application/vnd.ms-powerpoint"; break;
            case "gif": $ctype="image/gif"; break;
            case "png": $ctype="image/png"; break;
            case "jpeg":
            case "jpg": $ctype="image/jpg"; break;
            default: $ctype="application/force-download";
        }
        header("Pragma: public"); // required
        header("Expires: 0");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Cache-Control: private",false); // required for certain browsers
        header("Content-Type: $ctype");
        // change, added quotes to allow spaces in filenames, by Rajkumar Singh
        header("Content-Disposition: attachment; filename=\"". basename($file) ."\";" );
        header("Content-Transfer-Encoding: binary");
        header("Content-Length: ".filesize($file));

        ob_end_flush();
        readfile($file);

    } else {
        echo $file;
    }
}