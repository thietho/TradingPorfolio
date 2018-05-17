<?php
final class String
{
    public function getTextLength($str, $from, $len)
    {
        $str = strip_tags($str);
        $words = explode(' ', $str);
        $result = implode(' ', array_slice($words, $from, $len));
        if(count($words) > $len) {
            $result .= "...";
        }
		return $result;
    }

    public function numberFormate($num,$n=0)
    {
        /** @var Config $config */
        $config = Registry::get('config');
        if($n==0){
            $n = $config->get('config_number_decimal');
            if($n == 0){
                $arr = explode('.',$num);
                $str = number_format($arr[0]);
                $str.= isset($arr[1])?'.'.$arr[1]:'';
                return $str;
            }
        }


        $dec_point = $config->get('config_dec_point');
        $thousands_sep = $config->get('config_thousands_sep');
        return number_format($num, $n, $dec_point, $thousands_sep);
    }

    public function toNumber($str)
    {
        return str_replace(",", "", $str);
    }

    public function numberToString($num, $leng)
    {
        $str = "" . $num;
        $arr = array();
        for ($i = strlen($str) - 1; $i >= 0; $i--) {
            array_push($arr, $str[$i]);
        }

        while (count($arr) < $leng) {
            array_push($arr, 0);
        }
        $s = "";
        while (count($arr)) {
            $s .= array_pop($arr);
        }
        return $s;
    }
    public function toUrlPara($data)
    {
        $str = '';
        foreach($data as $key => $val)
        {
            $str.="&$key=$val";
        }
        return $str;
    }
    public function matrixToArray($data,$col)
    {
        $arr = array();
        if(count($data))
            foreach($data as $item)
                $arr[]=$item[$col];
        return $arr;
    }

    public function array_Filter($data,$col,$value)
    {
        $arr = array();
        foreach($data as $item)
        {
            if($item[$col] == $value)
                $arr[]=$item;
        }
        return $arr;
    }

    function generateRandStr($length)
    {
        $randstr = "";
        for ($i = 0; $i < $length; $i++) {
            $randnum = mt_rand(0, 61);
            if ($randnum < 10) {
                $randstr .= chr($randnum + 48);
            } else {
                if ($randnum < 36) {
                    $randstr .= chr($randnum + 55);
                } else {
                    $randstr .= chr($randnum + 61);
                }
            }
        }
        return $randstr;
    }
    function setLoopStr($str,$numlop)
    {
        $strresult = "";
        for($i=0;$i<$numlop;$i++)
        {
            $strresult .= $str;
        }
        return $strresult;
    }
    public function printDataTable($data)
    {
        $header = "<tr>";
        foreach ($data[0] as $key => $val)
            $header .= "<th>$key</th>";
        $header.="</tr>";
        $body = "";
        foreach ($data as $item)
        {
            $body .= "<tr>";
            foreach ($item as $val)
            {
                if(!is_array($val))
                    $body .= "<td>$val</td>";
                else
                {
                    $body .= "<td>".print_r($val,true)."</td>";
                }
            }

            $body .= "</tr>";
        }
        $table = "<table>$header$body</table>";
        return $table;
    }
    public function groupCol($data,$col)
    {
        $datacol = array();
        foreach ($data as $item)
        {
            $datacol[$item[$col]][] = $item;
        }
        return $datacol;
    }
}
?>
