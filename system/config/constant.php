<?php
$_['config_version'] = '1.4';

$_['config_siteid'] = 'default';
$_['config_home_intro'] = false;
$_['config_use_cache'] = true;

/***********************************************************
 * PUBLISH WEB AND USE MINIFY
 *************************************************************/
$_['config_web_publish'] = false;
$_['config_web_is_minified'] = false;


$_['config_web_is_atf'] = false;
$_['config_debug'] = false;
$_['config_compression'] = 0;


//error display
$_['config_error_display'] = true;
$_['config_error_log'] = true;


//map config default vietnam
$_['config_map_zoom_default'] = 5;
$_['config_map_lat_default'] = 14.058324;
$_['config_map_lng_default'] = 108.277199;


/***********************************************************
 * USER CONFIG
 *************************************************************/
$_['config_maintenance'] = true;

$_['config_theme'] = "default";

$_['config_visitors_summary'] = false;


/***********************************************************
 * CURRENCY CONFIG
 *************************************************************/
$_['config_number_decimal'] = 0;
$_['config_dec_point'] = ".";
$_['config_thousands_sep'] = ",";




/************************************************************
 * PAYPAL STATUS
 ************************************************************/
$_['config_paypal_pending_status_id'] = '1';
$_['config_paypal_completed_status_id'] = '2';
$_['config_paypal_canceled_reversal_status_id'] = '3';
$_['config_paypal_denied_status_id'] = '4';
$_['config_paypal_failed_status_id'] = '5';
$_['config_paypal_refunded_status_id'] = '6';
$_['config_paypal_reversed_status_id'] = '7';
$_['config_paypal_expired_status_id'] = '8';
$_['config_paypal_processed_status_id'] = '9';
$_['config_paypal_voided_status_id'] = '10';

$_['config_paypal_status'][$_['config_paypal_pending_status_id']] = "Pending";
$_['config_paypal_status'][$_['config_paypal_completed_status_id']] = "Completed";
$_['config_paypal_status'][$_['config_paypal_canceled_reversal_status_id']] = "Canceled";
$_['config_paypal_status'][$_['config_paypal_denied_status_id']] = "Denied";
$_['config_paypal_status'][$_['config_paypal_failed_status_id']] = "Failed";
$_['config_paypal_status'][$_['config_paypal_refunded_status_id']] = "Refunded";
$_['config_paypal_status'][$_['config_paypal_reversed_status_id']] = "Reversed";
$_['config_paypal_status'][$_['config_paypal_expired_status_id']] = "Expired";
$_['config_paypal_status'][$_['config_paypal_processed_status_id']] = "Processed";
$_['config_paypal_status'][$_['config_paypal_voided_status_id']] = "Voided";