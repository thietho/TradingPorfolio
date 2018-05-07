<?php
$data = $_POST;
$str = json_encode($data);
$expire = 84600;
$datapath = "data";
if(!is_dir($datapath))
    mkdir($datapath,777);
$files = glob($datapath . '*');
if(count($files))
{
    foreach ($files as $file)
    {

        $time = fileatime($file);
        if (time()- $time > $expire)
        {
            //unlink($file);
        }

    }
}
$file = 'data/'.time().'.json';
$fp = fopen($file, 'w');
fwrite($fp, $str);
fclose($fp);
echo $file;