<?php
//error_reporting(0);
require_once('../dbconfig.php');
include("config.php");

// Modification Override
function modification($filename)
{
    $file = "";
    if (substr($filename, 0, strlen(DIR_SYSTEM)) == DIR_SYSTEM) {
        $file = DIR_MODIFICATION_SYSTEM . substr($filename, strlen(DIR_SYSTEM));
    }

    if ($file != "" && is_file($file)) {
        return $file;
    }

    return $filename;
}

// Autoloader
function library($class)
{
    $file = DIR_SYSTEM . 'library/' . str_replace('\\', '/', strtolower($class)) . '.php';

    if (is_file($file)) {
        include_once(modification($file));

        return true;
    } else {
        return false;
    }
}

spl_autoload_register('library');


//engine
require_once(modification(DIR_SYSTEM . 'engine/registry.php'));


//Config
$config = new Config();
$config->load('constant');
Registry::set('config', $config);

// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PREFIX);
//load config with siteid
$query = $db->query("SELECT * FROM site WHERE siteid = 'default' LIMIT 1");
if ($query->num_rows) {
    define('SKINID', $query->row["skinid"]);
}



$path = $_GET['path'];
$width = $_GET['width'];
$height = $_GET['height'];
$resizetype = $_GET['type'];
switch ($resizetype) {
    case "root":
        header('Location: ' . IMAGE_SERVER . 'images/smartweb_' . SKINID . '/root/' . $path);
        break;
    default:
        header('Location: ' . IMAGE_SERVER . 'images/smartweb_' . SKINID . '/' . $resizetype . '-' . $width . 'x' . $height . '/' . $path);
        break;
}

