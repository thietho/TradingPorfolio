<?php

/**
 * Class User
 *
 * @property Session session
 * @property DB db
 *
 */
final class User
{
    private $userid;
    private $username;
    private $fullname;
    private $siteid;
    private $usertypeid;
    public  $card;
    public  $store = array();
    public  $permission = array();
    //private $Control = array();
    private $session;

    public function __construct()
    {
        $this->session = Registry::get('session');
        $this->db = Registry::get('db');
        $this->request = Registry::get('request');
        $this->session = Registry::get('session');
        $this->json = Registry::get('json');
        $this->string = Registry::get('string');


        /*
        if ($this->request->get['lang']) {
            $this->session->set('siteid', $this->request->get['lang']);
        } else {
            if (!isset($this->session->data['siteid'])) {
                $this->session->set('siteid', SITEID);
            }
        }
        */
        if (!isset($this->session->data['siteid'])) {
            $this->session->set('siteid', SITEID);
        }
        $this->siteid = $this->session->data['siteid'];
        if (isset($this->session->data['userid'])) {
            $query = $this->db->query("SELECT * FROM user WHERE userid = '" . $this->db->escape($this->session->data['userid']) . "'");

            if ($query->num_rows) {
                $this->usertypeid = $query->row['usertypeid'];
                $this->userid = $query->row['userid'];
                $this->username = $query->row['username'];
                $this->fullname = $query->row['fullname'];
                $this->permission = json_decode($query->row['permission'],true);
                $sql = "SELECT *
                        FROM  `card`
                        WHERE  `account` LIKE  '".$this->username."'";
                $query = $this->db->query($sql);
                $this->card = $query->row;
                $this->store = $this->session->data['store'];

            } elseif (isset($this->session->data['safemode'])) {
                $this->usertypeid = $this->session->data['usertypeid'];
                $this->userid = $this->session->data['userid'];
                $this->username = $this->session->data['username'];
                $this->fullname = $this->session->data['fullname'];
            } else {
                $this->logout();
            }
        }

    }


    public function isLogged()
    {
        if ($this->session->data['userid']) {
            $this->usertypeid = $this->session->data['usertypeid'];
            $this->userid = $this->session->data['userid'];
            $this->username = $this->session->data['username'];
            $this->fullname = $this->session->data['fullname'];
            $this->permission = json_decode($this->session->data['permission'],true);
            return true;
        } elseif ($this->session->data['safemode']) {
            $this->usertypeid = $this->session->data['usertypeid'];
            $this->userid = $this->session->data['userid'];
            $this->username = $this->session->data['username'];
            $this->fullname = $this->session->data['fullname'];
            $this->siteid = $this->session->data['siteid'];
            return true;
        }

        return false;
    }

    public function getSession(){
        return $this->session->data['cash']['session'];
    }
    public function login($username, $password)
    {
        if ($username == "" || $password == "") {
            return false;
        }
        $sql = "SELECT * FROM user WHERE username = '" . $this->db->escape($username) . "' AND password = '" . $this->db->escape(md5($password)) . "' AND status = 'active'";
        $query = $this->db->query($sql);



        if ($query->num_rows) {
            $this->session->set('usertypeid', $query->row['usertypeid']);
            $this->session->set('userid', $query->row['userid']);
            $this->session->set('username', $query->row['username']);
            $this->session->set('fullname', $query->row['fullname']);
            $this->session->set('permission', $query->row['permission']);
            $this->session->set('token', md5(SKINID . TOKE));

            $this->usertypeid = $query->row['usertypeid'];
            $this->userid = $query->row['userid'];
            $this->username = $query->row['username'];
            $this->fullname = $query->row['fullname'];
            $this->permission = json_decode($query->row['permission'],true);
            $query = $this->db->query("Select * from site where siteid = 'default'");
            $this->session->set('sitename', $query->row['sitename']);


            $sql = "SELECT *
                        FROM  `card`
                        WHERE  `account` LIKE  '".$this->username."'";
            $query = $this->db->query($sql);
            $this->card = $query->row;
            $this->store = $this->session->data['store'];

            //$query = $this->db->query("SELECT DISTINCT ug.permission FROM user u LEFT JOIN usertype ug ON u.usertypeid = ug.usertypeid WHERE u.userid = '" . (int)$this->session->data['userid'] . "'");
            //$this->setPermission($query->row['permission']);
            return TRUE;
        } else {
            return FALSE;
        }
    }


    public function loginToken($token, $password)
    {
        if ($token == "" || $password == "")
            return false;

        $sql = "SELECT * FROM user WHERE md5(userid) = '" . $this->db->escape($token) . "' AND password = '" . $this->db->escape($password) . "' AND status = 'active' ";
        $query = $this->db->query($sql);


        if ($query->num_rows) {
            $this->session->set('userid', $query->row['userid']);

            $this->usertypeid = $query->row['usertypeid'];
            $this->userid = $query->row['userid'];
            $this->username = $query->row['username'];
            $this->fullname = $query->row['fullname'];

            $sql = "SELECT *
                        FROM  `card`
                        WHERE  `account` LIKE  '".$this->username."'";
            $query = $this->db->query($sql);
            $this->card = $query->row;
            $this->store = $this->session->data['store'];

            $this->db->query("UPDATE user SET `userip` = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE userid = '" . (int)$this->session->data['userid'] . "'");

            return TRUE;
        } else {
            return FALSE;
        }
    }


    public function logout()
    {
        unset($_SESSION['safemode']);
        unset($_SESSION['userid']);
        unset($_SESSION['store']);

        unset($_COOKIE['user_token']);
        unset($_COOKIE['user_password']);

        unset($this->session->data['userid']);

        setcookie("user_token", null, -1, '/');
        setcookie("user_password", null, -1, '/');


        $this->userid = '';
        $this->username = '';
        $this->fullname = '';
    }


    public function getId()
    {
        return $this->userid;
    }

    public function getUserTypeId()
    {
        return $this->usertypeid;
    }

    public function getSiteId()
    {
        return $this->siteid;
    }

    public function getUserName()
    {
        return $this->username;
    }

    public function getFullName()
    {
        return $this->fullname;
    }
    public function setStore($store)
    {
        $this->session->set('store', $store);
        $this->store = $store;
    }
    public function checkPermission($module)
    {
        if($this->usertypeid == 'admin')
            return true;
        if(in_array($module,$this->permission))
        {
            return true;
        }
        return false;
    }
    
    public function writeLog($accessmodule,$accessaction,$accessdata){
        $cols = array(
            'username',
            'userip',
            'accessdate',
            'accessmodule',
            'accessaction',
            'accessdata'
        );
        $vals = array(
            $this->username,
            $this->request->server['REMOTE_ADDR'],
            date("Y-m-d H:i:s"),
            $accessmodule,
            $accessaction,
            $accessdata
        );
        return $this->db->insertData("user_log",$cols,$vals);
    }
}