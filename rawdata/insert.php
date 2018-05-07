<?php
require_once "dbconfig.php";
require_once "class/mysqli.php";
$hostname = "localhost";
$post = $_POST;

$db = new DataBase(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$db->open();
$table = $post['table'];
$field = $post['field'];
$value = $post['value'];
echo $db->insertData($table, $field, $value);