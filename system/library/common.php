<?php

final class Common
{
    public static $maxtrixTranslate;

    function __construct()
    {
        Common::$maxtrixTranslate = $this->buildMaxtrixTranslateUnicode();
    }

    //sort array
    static function array_sort($records, $field, $reverse = false)
    {
        $hash = array();

        foreach ($records as $record) {
            $hash[$record[$field]] = $record;
        }

        ($reverse) ? krsort($hash) : ksort($hash);

        $records = array();

        foreach ($hash as $record) {
            $records[] = $record;
        }

        return $records;
    }

    static function array_object_sort($records, $field, $reverse = false)
    {
        $hash = array();

        foreach ($records as $record) {
            $hash[$record->$field] = $record;
        }

        ($reverse) ? krsort($hash) : ksort($hash);

        $records = array();

        foreach ($hash as $record) {
            $records[] = $record;
        }


        return $records;
    }

    static function array_sort_byvalue($records, $field, $reverse = false)
    {
        $hash = array();

        $index = 0;
        foreach ($records as $record) {
            $hash[$index] = $record[$field];
            $index++;
        }

        ($reverse) ? arsort($hash) : asort($hash);


        $results = array();


        foreach ($hash as $key => $value) {
            $results[] = $records[$key];
        }

        return $results;
    }

    static function search_array($array, $key, $value)
    {
        $results = array();

        if (isset ($array[$key]) && $array[$key] == $value) {
            $results[] = $array;
        }

        foreach ($array as $subarray) {
            if (is_array($subarray)) {
                $results = array_merge($results, Common::search_array($subarray, $key, $value));
            }
        }

        return $results;
    }

    static function getCurrentPageURL()
    {
        $pageURL = 'http';
        if ($_SERVER["HTTPS"] == "on") {
            $pageURL .= "s";
        }
        $pageURL .= "://";
        if ($_SERVER["SERVER_PORT"] != "80") {
            $pageURL .= $_SERVER["SERVER_NAME"] . ":" . $_SERVER["SERVER_PORT"] . $_SERVER["REQUEST_URI"];
        } else {
            $pageURL .= $_SERVER["SERVER_NAME"] . $_SERVER["REQUEST_URI"];
        }
        return $pageURL;
    }


    static function combobox($data = array (), $displaymember = "", $valuemember = "", $selectedvalue = "", $firstdisplay = "", $firstvalue = "") {
        $result = "";
        if ($firstdisplay != "" || $firstvalue != "") {
            $result .= "<option value='" . $firstvalue . "'>" . $firstdisplay . "</option>";
        }
        if ($valuemember == "" && $displaymember == "") {
            foreach ($data as $value => $display) {
                $selected = "";
                if ($value == $selectedvalue)
                    $selected = "selected='selected'";
                $result .= "<option value='" . $value . "' " . $selected . ">" . $display . "</option>";
            }
        } else {
            foreach ($data as $item) {
                $selected = "";
                if ($item[$valuemember] == $selectedvalue)
                    $selected = "selected='selected'";
                $result .= "<option value='" . $item[$valuemember] . "' " . $selected . ">" . $item[$displaymember] . "</option>";
            }
        }
        return $result;
    }

    static function checkbox($labeltext, $inputname, $inputvalue, $selectedvalue = "") {
        $result = "";
        $checked = "";
        if ($inputvalue . "" == $selectedvalue)
            $checked = 'checked = "checked"';
        $result .= '<span>';
        $result .= '<input type="checkbox" id="' . $inputname . '" name="' . $inputname . '" value="' . $inputvalue . '" ' . $checked . '/>&nbsp;';
        $result .= '<label class="control-label" for="' . $inputname . '">' . $labeltext . '</label>';
        $result .= '</span>';
        return $result;
    }

    static public function radiobutton($data = array (), $inputname, $selectedvalue = "") {
        $result = "";
        foreach ($data as $value => $text) {
            $checked = "";
            if ($value . "" == $selectedvalue)
                $checked = "checked";
            $result .= '<span>';
            $result .= '<input style="vertical-align: middle" type="radio" name="' . $inputname . '" id="' . $inputname . $value . '" value="' . $value . '" ' . $checked . '>&nbsp;<label class="control-label" for="' . $inputname . $value . '">' . $text . '</label>&nbsp;&nbsp;';
            $result .= '</span>';
        }
        return $result;
    }

    static function utf8_to_ascii($str) {
        if (!isset ($str))
            return "";

        $str = strtr($str, Common::$maxtrixTranslate);
        return $str;
    }


    private function buildMaxtrixTranslateUnicode() {
        $array_A = array (
            'Á' => 'A',
            'À' => 'A',
            'Ả' => 'A',
            'Ã' => 'A',
            'Ạ' => 'A',
            'Ă' => 'A',
            'Ắ' => 'A',
            'Ằ' => 'A',
            'Ẳ' => 'A',
            'Ẵ' => 'A',
            'Ặ' => 'A',
            'Â' => 'A',
            'Ấ' => 'A',
            'Ầ' => 'A',
            'Ẩ' => 'A',
            'Ẫ' => 'A',
            'Ậ' => 'A'
        );
        $array_a = array (
            'á' => 'a',
            'à' => 'a',
            'ả' => 'a',
            'ã' => 'a',
            'ạ' => 'a',
            'ă' => 'a',
            'ắ' => 'a',
            'ằ' => 'a',
            'ẳ' => 'a',
            'ẵ' => 'a',
            'ặ' => 'a',
            'â' => 'a',
            'ấ' => 'a',
            'ầ' => 'a',
            'ẩ' => 'a',
            'ẫ' => 'a',
            'ậ' => 'a'
        );
        $array_D = array (
            'Đ' => 'D'
        );
        $array_d = array (
            'đ' => 'd'
        );
        $array_E = array (
            'É' => 'E',
            'È' => 'E',
            'Ẻ' => 'E',
            'Ẽ' => 'E',
            'Ẹ' => 'E',
            'Ê' => 'E',
            'Ế' => 'E',
            'Ề' => 'E',
            'Ể' => 'E',
            'Ễ' => 'E',
            'Ệ' => 'E'
        );
        $array_e = array (
            'é' => 'e',
            'è' => 'e',
            'ẻ' => 'e',
            'ẽ' => 'e',
            'ẹ' => 'e',
            'ê' => 'e',
            'ế' => 'e',
            'ề' => 'e',
            'ể' => 'e',
            'ễ' => 'e',
            'ệ' => 'e'
        );
        $array_I = array (
            'Í' => 'I',
            'Ì' => 'I',
            'Ỉ' => 'I',
            'Ĩ' => 'I',
            'Ị' => 'I'
        );
        $array_i = array (
            'í' => 'i',
            'ì' => 'i',
            'ỉ' => 'i',
            'ĩ' => 'i',
            'ị' => 'i'
        );
        $array_O = array (
            'Ó' => 'O',
            'Ò' => 'O',
            'Ỏ' => 'O',
            'Õ' => 'O',
            'Ọ' => 'O',
            'Ô' => 'O',
            'Ố' => 'O',
            'Ồ' => 'O',
            'Ổ' => 'O',
            'Ỗ' => 'O',
            'Ộ' => 'O',
            'Ơ' => 'O',
            'Ớ' => 'O',
            'Ờ' => 'O',
            'Ở' => 'O',
            'Ỡ' => 'O',
            'Ợ' => 'O'
        );
        $array_o = array (
            'ó' => 'o',
            'ò' => 'o',
            'ỏ' => 'o',
            'õ' => 'o',
            'ọ' => 'o',
            'ô' => 'o',
            'ố' => 'o',
            'ồ' => 'o',
            'ổ' => 'o',
            'ỗ' => 'o',
            'ộ' => 'o',
            'ơ' => 'o',
            'ớ' => 'o',
            'ờ' => 'o',
            'ở' => 'o',
            'ỡ' => 'o',
            'ợ' => 'o'
        );
        $array_U = array (
            'Ú' => 'U',
            'Ù' => 'U',
            'Ủ' => 'U',
            'Ũ' => 'U',
            'Ụ' => 'U',
            'Ư' => 'U',
            'Ứ' => 'U',
            'Ừ' => 'U',
            'Ử' => 'U',
            'Ữ' => 'U',
            'Ự' => 'U'
        );
        $array_u = array (
            'ú' => 'u',
            'ù' => 'u',
            'ủ' => 'u',
            'ũ' => 'u',
            'ụ' => 'u',
            'ư' => 'u',
            'ứ' => 'u',
            'ừ' => 'u',
            'ử' => 'u',
            'ữ' => 'u',
            'ự' => 'u'
        );
        $array_Y = array (
            'Ý' => 'Y',
            'Ỳ' => 'Y',
            'Ỷ' => 'Y',
            'Ỹ' => 'Y',
            'Ỵ' => 'Y'
        );
        $array_y = array (
            'ý' => 'y',
            'ỳ' => 'y',
            'ỷ' => 'y',
            'ỹ' => 'y',
            'ỵ' => 'y'
        );

        $array_translate = array_merge($array_A, $array_a, $array_D, $array_d, $array_E, $array_e, $array_I, $array_i, $array_O, $array_o, $array_U, $array_u, $array_Y, $array_y);
        unset ($array_A);
        unset ($array_a);
        unset ($array_D);
        unset ($array_d);
        unset ($array_E);
        unset ($array_e);
        unset ($array_I);
        unset ($array_i);
        unset ($array_O);
        unset ($array_o);
        unset ($array_U);
        unset ($array_u);
        unset ($array_Y);
        unset ($array_y);

        return $array_translate;
    }


    function getAdvanceSearchInfo($content) {

        //require_once(DIR_SERVERROOT.'simple_html_dom.php');
        $result = array('img'=>'', 'title'=>'');

        $content = htmlspecialchars_decode($content);

        //load html dom
        $html = str_get_html($content);
        if ($html == false) {
            return "";
        }

        //find title
        foreach($html->find('title') as $title) {
            if ($title->plaintext != '') {
                $result['title'] .= $title->plaintext."##";
            }
        }

        foreach($html->find('img') as $image) {
            if ($image->alt != '') {
                $result['img'] .= $image->alt."##";
            }
        }

        return $result;
    }
    function rrmdir($dir)
    {
        if (is_dir($dir))
        {
            $objects = scandir($dir);
            foreach ($objects as $object)
            {
                if(@$object != "." && $object != "..")
                {
                    if (filetype($dir."/".$object) == "dir")
                        @$this->rrmdir($dir."/".$object);
                    else
                        unlink($dir."/".$object);
                }
            }
            reset($objects);
            rmdir($dir);
        }
    }
}
