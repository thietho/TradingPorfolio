<?php

error_reporting(E_ALL & ~E_NOTICE);
date_default_timezone_set('Asia/Ho_Chi_Minh');
ini_set('max_input_vars', 30000);
ini_set('memory_limit', '512M');
ini_set('max_execution_time', 300); //300 seconds = 5 minutes
ini_set('safe_mode', 0);
require_once('dbconfig.php');
require_once('config.php');

// Startup
require_once(DIR_SYSTEM . 'startup.php');


// Front Controller
$controller = new Front();

// Maintenance Mode
$controller->addPreAction(new Action('common/maintenance'));

// SEO URL's
//$controller->addPreAction(new Action('common/seo_url'));

// Check login
$controller->addPreAction(new Action('page/login/checkLogin'));


// Router
if (isset($request->get['route'])) {
	$action = new Action($request->get['route']);
} else {
	$action = new Action('common/dashboard');
}

// Dispatch
$controller->dispatch($action, new Action('error/not_found'));

// Output
$response->output();