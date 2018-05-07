<?php
error_reporting(E_ALL & ~E_NOTICE);
date_default_timezone_set('Asia/Ho_Chi_Minh');
require_once('dbconfig.php');
require_once('config.php');

// Startup
require_once(DIR_SYSTEM . 'startup.php');


// Front Controller
$controller = new Front();

// Maintenance Mode
//$controller->addPreAction(new Action('common/maintenance'));

// SEO URL's
//$controller->addPreAction(new Action('common/seo_url'));

// Log out
$controller->addPreAction(new Action('common/logout'));

// Dispatch
$controller->dispatch($action, new Action('error/not_found'));

// Output
$response->output();