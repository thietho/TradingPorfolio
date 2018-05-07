<?php
class Raw
{
    private $catch;
    public function __construct()
    {
        $this->catch = false;
    }
    public function setCatch($catch)
    {
        $this->catch = $catch;
    }
    public function setDataBase($database)
    {
        $this->database = $database;
    }
    private function select($sql)
    {
        $url = HTTP_RAW . 'select.php';
        $data = array(
            'catch' => $this->catch,
            'token' => md5('abc'),
            'sql' => base64_encode($sql)
        );
        $str = $this->httppost($url, $data);
        $tb = json_decode($str, true);
        return $tb;
    }

    public function query($sql)
    {
        $data = $this->select($sql);

        $result = new \stdClass();
        $result->num_rows = count($data);
        $result->row = isset($data[0]) ? $data[0] : array();
        $result->rows = $data;
        return $result;
    }

    public function escape($value)
    {
        return Raw::mysql_escape_mimic($value);
    }

    private static function mysql_escape_mimic($inp) {
        if(is_array($inp))
            return array_map(__METHOD__, $inp);

        if(!empty($inp) && is_string($inp)) {
            return str_replace(array('\\', "\0", "\n", "\r", "'", '"', "\x1a"), array('\\\\', '\\0', '\\n', '\\r', "\\'", '\\"', '\\Z'), $inp);
        }

        return $inp;
    }

    public function getLastId()
    {
        $url = HTTP_RAW . '?route=core/db/getLastId';
        $insert_id = $this->httppost($url, array());
        return $insert_id;
    }


    public function getNextId($tablename, $tableid)
    {
        $sql = "SELECT max(" . $tableid . ") as max FROM `$tablename`";
        $query = $this->query($sql);
        return $query->rows[0]['max'] + 1;
    }


    function getNextIdVarChar($tablename, $tableid, $prefix)
    {
        $sql = "SELECT $tableid FROM `$tablename` WHERE $tableid LIKE '" . $prefix . "%'";
        $query = $this->query($sql);
        $mid = $query->rows;
        if (count($mid) == 0) return $prefix . "1";
        $mnum = array();
        for ($i = 0; $i < count($mid); $i++) {
            array_push($mnum, substr($mid[$i][$tableid], strlen($prefix)));
        }
        $max = 0;
        for ($i = 0; $i < count($mnum); $i++) if ($max < intval($mnum[$i])) $max = intval($mnum[$i]);
        $nextid = $max + 1;
        return $prefix . $nextid;
    }

    public function getNextIdVarCharNumber($tablename, $tableid, $prefix)
    {
        $sql = "SELECT $tableid FROM `$tablename` WHERE $tableid LIKE '%" . $prefix . "%'";
        $query = $this->query($sql);
        $mid = $query->rows;
        if (count($mid) == 0) return 1;
        $mnum = array();
        for ($i = 0; $i < count($mid); $i++) {

            array_push($mnum, str_replace($prefix, "", $mid[$i][$tableid]));
        }

        $max = 0;
        for ($i = 0; $i < count($mnum); $i++) if ($max < intval($mnum[$i])) $max = intval($mnum[$i]);
        $nextid = $max + 1;
        return $nextid;
    }

    function insertData($tablename = NULL, $fields = NULL, $values = NULL)
    {
        $url = HTTP_RAW . 'insert.php';
        $da = array(
            'table' => $tablename,
            'field' => $fields,
            'value' => $values
        );
        $id = $this->httppost($url, $da);
        return $id;

    }

    function updateData($tablename = NULL, $fields = NULL, $values = NULL, $where = NULL)
    {
        $url = HTTP_RAW . 'update.php';
        $da = array(
            'table' => $tablename,
            'field' => $fields,
            'value' => $values,
            'where' => base64_encode($where)
        );

        $id = $this->httppost($url, $da);
    }

    function deleteData($tablename = NULL, $where = NULL)
    {
        $url = HTTP_RAW . 'delete.php';
        $da = array(
            'table' => $tablename,
            'where' => base64_encode($where)
        );

        $id = $this->httppost($url, $da);
    }

    private function httppost($url, $data)
    {
        if(isset($data['value'])) {
            foreach($data['value'] as $key => $val) {
                if(is_null($val)) {
                    $data['value'][$key] = '';
                }
            }
        }
        $curl = curl_init();
        // Set some options - we are passing in a useragent too here
        curl_setopt_array($curl, array(
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_URL => $url,
            CURLOPT_USERAGENT => 'Codular Sample cURL Request',
            CURLOPT_POST => 1,
            CURLOPT_POSTFIELDS => http_build_query($data)));
        // Send the request & save response to $resp\
        $result = curl_exec($curl);
        // Close request to clear up some resources
        curl_close($curl);
        return $result;
    }
}