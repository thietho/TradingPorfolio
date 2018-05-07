<?php
ini_set('max_execution_time', 300);
include ('dumper.php');
require "dbconfig.php";
$exprit = 60*60*24/4;
$expritdel = $exprit*4*7;

if(!is_dir('data'))
    mkdir('data',777);
$data = array();
//Lay thời điểm cuối cùng tạo backup
$fileList = glob('data/*');
$maxtimespant = 0;
foreach($fileList as $filename){
    //Use the is_file function to make sure that it is not a directory.
    if(is_file($filename)){
        $info = pathinfo($filename);
        //print_r($info);
        $createtime = filemtime($filename);
        if($maxtimespant < $createtime)
            $maxtimespant = $createtime;
        if(time() - $createtime > $expritdel){
            unlink($filename);
        }
    }
}

$timeout = time() - $maxtimespant;
if($timeout > $exprit || $maxtimespant==0){
    try {
        $world_dumper = Shuttle_Dumper::create(array(
            'host' => DB_HOSTNAME,
            'username' => DB_USERNAME,
            'password' => DB_PASSWORD,
            'db_name' => DB_DATABASE,
        ));

        // dump the database to gzipped file
        $path = 'data/'.DB_DATABASE.'_'.time().'.sql.gz';
        $world_dumper->dump($path);
        $data['notes'] = 'Database has been backup';
        $data['path'] = $path;


    } catch(Shuttle_Exception $e) {
        //echo "Couldn't dump database: " . $e->getMessage();
        $data['notes'] = "Couldn't dump database: " . $e->getMessage();
        $data['path'] = '';
    }
}else{
    $data['notes'] = 'Out of time backup';
    $data['path'] = '';
}

echo json_encode($data);