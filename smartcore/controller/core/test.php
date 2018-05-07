<?php

/**
 * Class ControllerCoreTest
 *
 *
 */
class ControllerCoreTest extends Controller
{

    public function index()
    {
        $sql = "SELECT *
                     FROM  `card` ";
        $data = $this->select($sql);
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function httppost($url,$data)
    {
        $curl = curl_init();
        // Set some options - we are passing in a useragent too here

        curl_setopt_array($curl, array(
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_URL => $url,
            CURLOPT_USERAGENT => 'Codular Sample cURL Request',
            CURLOPT_POST => 1,
            CURLOPT_POSTFIELDS => http_build_query($data)));
        // Send the request & save response to $resp
        $result = curl_exec($curl);
        // Close request to clear up some resources
        curl_close($curl);
        return $result;
    }
    public function select($sql)
    {
        $url = HTTP_RAW.'?route=core/db/select';
        $data = array('sql' => base64_encode($sql));
        $str = $this->httppost($url,$data);
        $tb = json_decode($str);

        return $tb;
    }
    public function insertData($table,$field,$value)
    {
        $url = HTTP_RAW.'?route=core/db/insertData';
        $da = array(
            'table'=>$table,
            'field'=>$field,
            'value'=>$value
        );

        $id = $this->httppost($url,$da);
        return $id;
    }
    public function updateData($table,$field,$value,$where)
    {
        $url = HTTP_RAW.'?route=core/db/updateData';
        $da = array(
            'table'=>$table,
            'field'=>$field,
            'value'=>$value,
            'where'=> base64_encode($where)
        );

        $id = $this->httppost($url,$da);
    }
    public function deleteData($table,$where)
    {
        $url = HTTP_RAW.'?route=core/db/deleteData';
        $da = array(
            'table'=>$table,
            'where'=> base64_encode($where)
        );

        $id = $this->httppost($url,$da);
    }
}