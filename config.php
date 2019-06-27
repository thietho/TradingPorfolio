<?php
// CONFIG DOMAIN
$base_domain = 'localhost:81'; //ex: google.com
$domain = 'localhost:81'; //ex: www.google.com
$main_http_server = "http://$domain/TradingPorfolio/";
$root_http_server = "http://$domain/TradingPorfolio/";
$root_https_server = "https://$domain/TradingPorfolio/";
$file_server = "http://$domain/TradingPorfolio/fileserver/";
$image_server = "http://$domain/TradingPorfolio/fileserver/";
$upload_server = "http://$domain/TradingPorfolio/fileserver/";

//Set language for website
if (!isset($_GET['lang']) || $_GET['lang'] == "") {
    $langs = (!isset($_SESSION['lang_session']) || $_SESSION['lang_session'] == "") ? "vn" : $_SESSION['lang_session'];
} else {
    $langs = $_GET['lang'];
}
$_SESSION['lang_session'] = $langs == "vi" ? "vn" : $langs;

if (!isset($_GET['countrycode']) || $_GET['countrycode'] == "") {
    $countryCode = (!isset($_SESSION['country_session']) || $_SESSION['country_session'] == "") ? "uk" : $_SESSION['country_session'];
} else {
    $countryCode = $_GET['countrycode'];
}
$_SESSION['country_session'] = $countryCode;


//COMMON URL
define('MAIN_HTTP_SERVER', $main_http_server);
define('ROOT_HTTP_SERVER', $root_http_server);
define('HTTP_SERVER', $root_http_server . $langs . '-' . $countryCode . '/');
define('HTTPS_SERVER', $root_https_server . $langs . '-' . $countryCode . '/');
define('FILE_SERVER', $file_server);
define('IMAGE_SERVER', $image_server);
define('UPLOAD_SERVER', $upload_server);
define('HTTP_WEB', $root_http_server . $langs . '-' . $countryCode . '/');
define('HTTP_COMPONENT', MAIN_HTTP_SERVER . 'component/');
define('HTTP_CLIENT', 'http://'.$domain.'/client/');
define('HTTP_RAW','http://localhost/choxom/rawdata/');
//CONFIG DIRECTORY
define('DIR_SERVERROOT', str_replace('\\', '/', realpath(dirname(__FILE__))) . '/');
//define('DIR_SERVERROOT_PARENT', str_replace('\\', '/', realpath(dirname(__FILE__) . '/..')) . '/');
define('DIR_APPLICATION', DIR_SERVERROOT . 'smartcore/');
define('DIR_CONTROLLER', DIR_SERVERROOT . 'smartcore/controller/');
define('DIR_MODEL', DIR_SERVERROOT . 'smartcore/model/');
define('DIR_VIEW', DIR_SERVERROOT . 'smartcore/template/default/view/');
define('DIR_LANGUAGE', DIR_SERVERROOT . 'smartcore/language/');
define('DIR_COMMON', FILE_SERVER . 'common/');
define('DIR_COMPONENT', DIR_SERVERROOT . 'component/');
define('DIR_SYSTEM', DIR_SERVERROOT . 'system/');
define('DIR_DATABASE', DIR_SYSTEM . 'database/');
define('DIR_CONFIG', DIR_SYSTEM . 'config/');
define('TOKE', '20485');


//ADDITIONAL DIRECTORY
define('DIR_MODIFICATION_SYSTEM', DIR_SERVERROOT . 'system_setting/');
define('DIR_LOGS', DIR_SERVERROOT . 'logs/');
define('DIR_FILE','../fileserver/file_default/file/');
