<?php

// Error Reporting
error_reporting(E_ALL ^ E_NOTICE);
//error_reporting(0);

// Check Version
if (version_compare(phpversion(), '5.3.0', '<') == true) {
    exit('PHP5.3+ Required');
}

// Magic Quotes Fix
if (ini_get('magic_quotes_gpc')) {
    function clean($data)
    {
        if (is_array($data)) {
            foreach ($data as $key => $value) {
                $data[clean($key)] = clean($value);
            }
        } else {
            $data = stripslashes($data);
        }

        return $data;
    }

    $_GET = clean($_GET);
    $_POST = clean($_POST);
    $_COOKIE = clean($_COOKIE);
}

if (!ini_get('date.timezone')) {
    date_default_timezone_set('UTC');
}

// Windows IIS Compatibility
if (!isset($_SERVER['DOCUMENT_ROOT'])) {
    if (isset($_SERVER['SCRIPT_FILENAME'])) {
        $_SERVER['DOCUMENT_ROOT'] = str_replace('\\', '/', substr($_SERVER['SCRIPT_FILENAME'], 0, 0 - strlen($_SERVER['PHP_SELF'])));
    }
}

if (!isset($_SERVER['DOCUMENT_ROOT'])) {
    if (isset($_SERVER['PATH_TRANSLATED'])) {
        $_SERVER['DOCUMENT_ROOT'] = str_replace('\\', '/', substr(str_replace('\\\\', '\\', $_SERVER['PATH_TRANSLATED']), 0, 0 - strlen($_SERVER['PHP_SELF'])));
    }
}

if (!isset($_SERVER['REQUEST_URI'])) {
    $_SERVER['REQUEST_URI'] = substr($_SERVER['PHP_SELF'], 1);

    if (isset($_SERVER['QUERY_STRING'])) {
        $_SERVER['REQUEST_URI'] .= '?' . $_SERVER['QUERY_STRING'];
    }
}

if (!isset($_SERVER['HTTP_HOST'])) {
    $_SERVER['HTTP_HOST'] = getenv('HTTP_HOST');
}

// Check if SSL
if (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) {
    $_SERVER['HTTPS'] = true;
} elseif (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https' || !empty($_SERVER['HTTP_X_FORWARDED_SSL']) && $_SERVER['HTTP_X_FORWARDED_SSL'] == 'on') {
    $_SERVER['HTTPS'] = true;
} else {
    $_SERVER['HTTPS'] = false;
}





// Autoloader
function library($class)
{
    $file = DIR_SYSTEM . 'library/' . str_replace('\\', '/', strtolower($class)) . '.php';
    if (is_file($file)) {
        include_once($file);

        return true;
    } else {
        return false;
    }
}

function plugin($class)
{
    $file = DIR_SYSTEM . 'plugin/' . str_replace('\\', '/', strtolower($class)) . '.php';
    if (is_file($file)) {
        include_once($file);

        return true;
    } else {
        return false;
    }
}

spl_autoload_register('library');
spl_autoload_register('plugin');


// Engine
/*
require_once(modification(DIR_SYSTEM . 'engine/action.php'));
require_once(modification(DIR_SYSTEM . 'engine/controller.php'));
require_once(modification(DIR_SYSTEM . 'engine/front.php'));
require_once(modification(DIR_SYSTEM . 'engine/loader.php'));
require_once(modification(DIR_SYSTEM . 'engine/model.php'));
require_once(modification(DIR_SYSTEM . 'engine/registry.php'));
*/
require_once(DIR_SYSTEM . 'engine/action.php');
require_once(DIR_SYSTEM . 'engine/controller.php');
require_once(DIR_SYSTEM . 'engine/front.php');
require_once(DIR_SYSTEM . 'engine/loader.php');
require_once(DIR_SYSTEM . 'engine/model.php');
require_once(DIR_SYSTEM . 'engine/registry.php');

// Component
//include(DIR_COMPONENT . "securimage/securimage.php");

//PLUGIN
//require_once(DIR_SYSTEM . 'plugin/simple_html_dom.php');

//EMAIL
require_once(DIR_SYSTEM . 'mail/PHPMailerAutoload.php');
require_once(DIR_SYSTEM . 'helper/phpmailer.php');

//Log
$log = new Log('log.txt');
Registry::set('log', $log);


//Config
$config = new Config();
$config->load('constant');
Registry::set('config', $config);


// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PREFIX);
Registry::set('db', $db);
// Raw
$raw = new Raw();
Registry::set('raw', $raw);


//load config with siteid
$sql = "SELECT * FROM `site` WHERE siteid = '" . $config->get('config_siteid') . "' LIMIT 1";
$query = $db->query($sql);

if ($query->num_rows) {

    foreach ($query->row as $key => $value) {
        $config->set("config_" . $key, $value);
    }
    define('SKINID', $config->get("config_skinid"));
    define('SITEID', $config->get('config_siteid'));

    if ($_SESSION['lang_session'] == null) {
        $arr_language = explode(",", $config->get("config_language"));
        $config->set('config_languageid', $arr_language[0]);
    } else {
        $config->set('config_languageid', $_SESSION['lang_session']);
    }

    if($config->get("config_status") == 'Active') {
        $config->set("config_maintenance", false);
    } else {
        $config->set("config_maintenance", true);
    }
    Registry::set('config', $config);
} else {
    trigger_error('Error: Could not found siteid config');
    exit();
}




//CONFIG CONSTANT
define('DIR_FONT', FILE_SERVER . 'smartweb_' . SKINID . '/' . $config->get('config_theme') . '/fonts/');
define('DIR_IMAGE', FILE_SERVER . 'smartweb_' . SKINID . '/' . $config->get('config_theme') . '/image/');
define('DIR_CSS', FILE_SERVER . 'smartweb_' . SKINID . '/' . $config->get('config_theme') . '/css/');
define('DIR_JS', FILE_SERVER . 'smartweb_' . SKINID . '/' . $config->get('config_theme') . '/js/');
define('DIR_MINIFY', FILE_SERVER . 'smartweb_' . SKINID . '/' . $config->get('config_theme') . '/minify-'. $config->get('config_version') .'/');

define('DIR_USERIMAGE', UPLOAD_SERVER . 'images/smartweb_' . SKINID . '/');
define('DIR_USERDOWNLOAD', IMAGE_SERVER . 'download/smartweb_' . SKINID . '/');

define('DIR_USERAPPLICATION', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/');
define('DIR_USERCONTROLLER', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/controller/');
define('DIR_USERMODEL', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/model/');
define('DIR_USERLANGUAGE', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/language/');


define('DIR_APPCONTROLLER', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/controller_application/');
define('DIR_APPMODEL', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/model_application/');


define('DIR_TEMPLATE', DIR_SERVERROOT . 'smartcore/template/' . $config->get('config_theme') . '/view/');
define('DIR_USERTEMPLATE', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/template/' . $config->get('config_theme') . '/view/');
define('DIR_TEMPLATE_JS', DIR_SERVERROOT . 'smartcore/template/' . $config->get('config_theme') . '/js/');
define('DIR_USERTEMPLATE_JS', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/template/' . $config->get('config_theme') . '/js/');
define('DIR_TEMPLATE_CSS', DIR_SERVERROOT . 'smartcore/template/' . $config->get('config_theme') . '/css/');
define('DIR_USERTEMPLATE_CSS', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/template/' . $config->get('config_theme') . '/css/');



define('DIR_CACHE', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/cachedb/');
define('DIR_SETTING', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/setting/');
define('DIR_CACHEHTML', DIR_SERVERROOT . 'smartcore_setting/' . SKINID . '/cachedb/');


if(defined('DIR_SERVERROOT_PARENT')){
    define('DIR_WEB_CACHE', DIR_SERVERROOT_PARENT . 'smartcore_setting/' . SKINID . '/cachedb/');
}

// Loader
$loader = new Loader();
Registry::set('load', $loader);


function error_handler($code, $message, $file, $line)
{
    global $log, $config;

    // error suppressed with @
    if (error_reporting() === 0) {
        return false;
    }

    switch ($code) {
        case E_NOTICE:
        case E_USER_NOTICE:
            $error = 'Notice';
            break;
        case E_WARNING:
        case E_USER_WARNING:
            $error = 'Warning';
            break;
        case E_ERROR:
        case E_USER_ERROR:
            $error = 'Fatal Error';
            break;
        default:
            $error = 'Unknown';
            break;
    }

    if ($error != 'Notice' && $config->get('config_error_display')) {
        echo '<b>' . $error . '</b>: ' . $message . ' in <b>' . $file . '</b> on line <b>' . $line . '</b>';
    }

    if ($error != 'Notice' && $config->get('config_error_log')) {
        $log->write('PHP ' . $error . ':  ' . $message . ' in ' . $file . ' on line ' . $line);
    }

    return true;
}

// Error Handler
set_error_handler('error_handler');

// Request
$request = new Request();
Registry::set('request', $request);

// Response
$response = new Response();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$response->setCompression($config->get('config_compression'));
Registry::set('response', $response);

// Cache
$cache = new Cache('file');
Registry::set('cache', $cache);

// CacheHTML
$cachehtml = new CacheHTML('html');
Registry::set('cachehtml', $cachehtml);

// Url
Registry::set('url', new Url());

// Session
Registry::set('session', new Session());

// Language
Registry::set('language', new Language($config->get('config_languageid')));

// DateTime
Registry::set('date', new Date());

// Validation
Registry::set('validation', new Validation());

//String
Registry::set('string', new String());

// User
Registry::set('user', new User());

// Member
Registry::set('member', new Member());

// Commmon
Registry::set('common', new Common());

// Smartweb
Registry::set('smartweb', new Smartweb());

// Document
Registry::set('document', new Document());



// Security
//-- crsf
//require_once(DIR_SYSTEM . 'plugin/csrf/csrfprotector.php');
//csrfProtector::init();