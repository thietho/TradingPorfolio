<?php
/**
 * Created by PhpStorm.
 * User: phqdung
 * Date: 10/12/14
 * Time: 10:47 PM
 */

//min html
require_once('../../system/library/jsmin.php');
require_once('../../system/library/cssmin.php');

/*
$dir_minify = "minify/";
$dir_css = "css/";
$dir_js = "js/";

//minify css
$css_file_list = $_POST['css'];
$layout = $_POST['layout'];
$css_all = "";
if(!file_exists($dir_minify . $layout . ".css")) {
    foreach($css_file_list as $filename) {
        if((strpos($filename,".min")) === FALSE) {
            $csscontent = file_get_contents($dir_css . $filename);
            $cssmin = new CssMin();
            $mincsscontent = $cssmin->run($csscontent);
            $css_all .= $mincsscontent;
        } else {
            $css_all .= file_get_contents($dir_css . $filename);
        }
    }
    if($css_all != "") {
        file_put_contents($dir_minify . $layout . ".css", $css_all);
    }
}





//minify js
$js_file_list = $_POST['js'];
$js_all = "";
if(!file_exists($dir_minify . $layout . ".js")) {
    foreach($js_file_list as $filename) {
        if((strpos($filename,".min")) === FALSE) {
            $jscontent = file_get_contents($dir_js . $filename);
            $minjscontent = JsMin::minify($jscontent);
            $js_all .= $minjscontent;
        } else {
            $js_all .= file_get_contents($dir_js . $filename);
        }
    }
    if($js_all != "") {
        file_put_contents($dir_minify . $layout . ".js", $js_all);
    }
}
*/

$dir_version = "";
if(isset($_POST['version'])) {
    $dir_version = $_POST['version'] . "/";
}

$dir_minify = "minify-" . $dir_version . "/";
$dir_css = "css/";
$dir_js = "js/";


$layout = $_POST['layout'];

if(!is_dir($dir_minify)) {
    mkdir($dir_minify, 0777);
}

//minify css
$css_file_list = $_POST['css'];
$css_all = "";
if(!file_exists($dir_minify . $layout . ".css")) {
    foreach($css_file_list as $filename) {
        if((strpos($filename,".min")) === FALSE) {
            $csscontent = file_get_contents($dir_css . $filename);
            $cssmin = new CssMin();
            $mincsscontent = $cssmin->run($csscontent);
            $css_all .= $mincsscontent;
        } else {
            $css_all .= file_get_contents($dir_css . $filename);
        }
    }
    if($css_all != "") {
        file_put_contents($dir_minify . $layout . ".css", $css_all);
    }
}




//minify js
$js_file_list = $_POST['js'];
$js_all = "";
if(!file_exists($dir_minify . $layout . ".js")) {
    foreach($js_file_list as $filename) {
        if((strpos($filename,".min")) === FALSE) {
            $jscontent = file_get_contents($dir_js . $filename);
            $minjscontent = JsMin::minify($jscontent);
            $js_all .= $minjscontent;
        } else {
            $js_all .= file_get_contents($dir_js . $filename);
        }
    }
    if($js_all != "") {
        file_put_contents($dir_minify . $layout . ".js", $js_all);
    }
}