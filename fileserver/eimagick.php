<?php
$site = isset($_GET['site']) ? $_GET['site'] : "default";
$path = isset($_GET['path']) ? $_GET['path'] : "";
$width = isset($_GET['width']) ? $_GET['width'] : "0";
$height = isset($_GET['height']) ? $_GET['height'] : "0";
$resizetype = isset($_GET['type']) ? $_GET['type'] : "root";

define("DIR_SERVERROOT", '/TradingPorfolio/');
define("DIR_FILE", $_SERVER['DOCUMENT_ROOT'] . DIR_SERVERROOT . "fileserver/" . "file_" . $site . "/file/");
define("DIR_WEBFILE", "");
define("WATERLOGO_POSITION", "BottomRight"); //TopLeft, TopRight, BottomLeft, BottomRight
require_once("system/helper/eimagick.php");
require_once("system/library/eimagick.php");

define('COMPRESSION', true);
$isexits = true;

if(!file_exists(DIR_FILE . $path))
{
    $isexits = false;
}
if ($path == "" || $resizetype == "" || !file_exists(DIR_FILE . $path)) {
    $path = 'default/default.png';
}

if ($path != "" && $resizetype != "" && file_exists(DIR_FILE . $path)) {

    $fileTime = filemtime(DIR_FILE . $path);
    if (isset($_SERVER['HTTP_IF_MODIFIED_SINCE']) && (strtotime($_SERVER['HTTP_IF_MODIFIED_SINCE']) == filemtime(DIR_FILE . $path))) {
        // if the browser has a cached version of this image, send 304
        $offset = 365 * 24 * 60 * 60;
        $expire = 'Expires: ' . gmdate('D, d M Y H:i:s', time() + $offset) . ' GMT';
        header($expire);
        header('Last-Modified: '.gmdate('D, d M Y H:i:s', $fileTime).' GMT', true, 304);
        //header('Content-Length: ' . filesize($file));
        exit;
    } else {
        switch ($resizetype) {
            case "resize":
                $file = DIR_FILE . HelperEimagick::resize($path, $width, $height);
                break;
            case "resizeblack":
                $file = DIR_FILE . HelperEimagick::resize($path, $width, $height, "#090909");
                break;
            case "resizepng":
                $file = DIR_FILE . HelperEimagick::resizePNG($path, $width, $height);
                break;
            case "autosize":
                $file = DIR_FILE . HelperEimagick::resizePNG($path, $width, $height);
                break;
            case "fixsize":
                $file = DIR_FILE . HelperEimagick::fixsize($path, $width, $height);
                break;
            case "fixsizetop":
                $file = DIR_FILE . HelperEimagick::fixsizetop($path, $width, $height);
                break;
            case "root":
                //$file = DIR_FILE . HelperEimagick::getroot($path);
                var_dump($isexits);
                if($isexits){
                    $file = DIR_FILE . HelperEimagick::getroot($path);
                }else{
                    $file = '';
                    exit();
                }
                break;
            default:
                $file = DIR_FILE . HelperEimagick::resize($path, $width, $height);
                break;
        }

        if (file_exists($file)) {
            $info = getimagesize($file);
            $imageinfor = array(
                "width" => $info[0],
                "height" => $info[1],
                "bits" => $info["bits"],
                "mime" => $info["mime"],
                'type' => $info[2]
            );
            $mime = $imageinfor['mime'];

            //header for file's image
            header('Content-Type: ' . $mime);
            //header("Cache-Control: cache, must-revalidate, max-age=604800, pre-check=10800");
            //header("Pragma: private");
            $offset = 365 * 24 * 60 * 60;
            $expire = 'Expires: ' . gmdate('D, d M Y H:i:s', time() + $offset) . ' GMT';
            header($expire);
            header('Last-Modified:' . gmdate('D, d M Y H:i:s', $fileTime) . ' GMT');
            header('Content-Length: ' . filesize($file));
            //ob_end_flush();

            readfile($file);

        } else {
            echo $file;
        }
    }

} else {


    $file = DIR_FILE . 'default/default.png';

    $info = getimagesize($file);
    $imageinfor = array(
        "width" => $info[0],
        "height" => $info[1],
        "bits" => $info["bits"],
        "mime" => $info["mime"],
        'type' => $info[2]
    );
    $mime = $imageinfor['mime'];

    //header for file's image
    header('Content-Type: ' . $mime);
    //header ('Cache-Control: must-revalidate');
    header("Cache-Control: cache, must-revalidate, max-age=604800, pre-check=10800");
    header("Pragma: private");
    $offset = 365 * 24 * 60 * 60;
    $expire = 'Expires: ' . gmdate('D, d M Y H:i:s', time() + $offset) . ' GMT';
    header($expire);
    header('Last-Modified:' . gmdate('D, d M Y H:i:s', time()) . ' GMT');
    if (isset($_SERVER['HTTP_IF_MODIFIED_SINCE'])) {
        // if the browser has a cached version of this image, send 304
        header('Last-Modified: ' . $_SERVER['HTTP_IF_MODIFIED_SINCE'], true, 304);
        exit;
    }
    header('Content-Length: ' . filesize($file));
    ob_clean();
    flush();

    readfile($file);

}
