<?php
require_once "dbconfig.php";
require_once "class/mysqli.php";
$hostname = "localhost";
$post = $_POST;
$username = $post['username'];
$password = $post['password'];
$database = $post['database'];
$db = new DataBase(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$db->open();
$table = $post['table'];
$where = base64_decode($post['where']);
echo $db->deleteData($table, $where);