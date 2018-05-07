<?php

/**
 * Class Validation
 *
 * @property DB db
 *
 */
final class Validation
{
    public function __construct()
    {
        $this->db = Registry::get('db');
    }

    function checkLetterOnly($string)
    {
        return (preg_match("/^[a-zA-Z]+$/", $string)) ?  true : false;
    }

    function isId($string)
    {
        return (preg_match ("/^[a-zA-Z0-9]+$/", $string)) ?  true : false;
    }

    function checkLetterNunberOnly($string)
    {
        return (preg_match("/^[a-zA-Z0-9 ]+$/", $string)) ? true : false;
    }

    function checkTextOnly($string)
    {
        return (preg_match("/^[a-zA-Z0-9_* ]+$/", $string)) ? true : false;
    }

    function checkEmail($string)
    {
        return (preg_match("/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/", $string)) ? true : false;
    }

    function checkNumberOnly($string)
    {
        return (preg_match("/^[_0-9-]+$/", $string)) ? true : false;
    }
    public function isMySqlDate($stringdate){
        return (preg_match("/([0-9]{4})-([0-9]{2})-([0-9]{2})/", $stringdate)) ? true : false;
    }
    function checkEmty($string)
    {
        return empty($string);
    }

    function isExistURLAlias($keyword)
    {
        $sql = "SELECT * FROM url_alias WHERE keyword = '" . $keyword . "'";
        $query = $this->db->query($sql);
        return count($query->rows) > 0;
    }
}
