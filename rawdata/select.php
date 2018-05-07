<?php
require_once "dbconfig.php";
require_once "class/mysqli.php";
$hostname = DB_HOSTNAME;

$username = DB_USERNAME;
$password = DB_PASSWORD;
$database = DB_DATABASE;
$catch = $_POST['catch'];
$post = $_POST;
$sql = base64_decode($_POST['sql']);
if($catch){
    $dir = "catch";
    if(!is_dir($dir))
        mkdir($dir,0777);
    $dir .= "/".$database;
    if(!is_dir($dir))
        mkdir($dir,0777);
    $path = $dir."/".md5($sql).".json";
    if(file_exists($path))
    {
        if($catch){
            $filename = $path;
            $handle = fopen($filename, "rb");
            echo $contents = fread($handle, filesize($filename));
            fclose($handle);
        }
        else
        {
            loadData($hostname, $username, $password, $database, $sql, $path);
            //echo "No catch";
        }

    }
    else
    {
        loadData($hostname, $username, $password, $database, $sql, $path);
    }
}else{
    loadData($hostname, $username, $password, $database, $sql);
}


function loadData($hostname, $username, $password, $database, $sql, $path='')
{
    $db = new DataBase($hostname, $username, $password, $database);
    $db->open();
    $query = $db->query($sql);
    $data = $query->rows;
    echo $str = json_encode($data);
    if($path!=''){
        //Luu ket qua
        $fp = fopen($path, 'w');
        fwrite($fp, $str);
        fclose($fp);
    }

}