<?php

/**
 * Class Member
 *
 * @property Session session
 *
 */
final class Member
{
    public $customerid;
    public $account;
    public $image;
    public $firstname;
    public $lastname;
    public $email;
    public $telephone;
    public $mobilephone;
    public $ip;
    public $approved;
    public $address;
    public $birthdate;
    public $gender;
    public $lastlogin;
    public $customertype;
    public $age;
    public $zoneid;


    public function __construct()
    {
        $this->db = Registry::get('db');
        $this->request = Registry::get('request');
        $this->session = Registry::get('session');
        $this->json = Registry::get('json');
        $this->string = Registry::get('string');

        if (isset($this->session->data['customerid'])) {
            $query = $this->db->query("SELECT * FROM customer WHERE customerid = '" . $this->db->escape($this->session->data['customerid']) . "'");

            if ($query->num_rows) {
                $this->setMember($query->row);
                $this->db->query("UPDATE customer SET `ip` = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE customerid = '" . (int)$this->session->data['customerid'] . "'");
            } else {
                $this->logout();
            }
        }
    }


    public function setMember($data)
    {
        $this->customerid = $data['customerid'];
        $this->account = $data['account'];
        $this->image = $data['image'];
        $this->firstname = $data['firstname'];
        $this->lastname = $data['lastname'];
        $this->email = $data['email'];
        $this->telephone = $data['telephone'];
        $this->mobilephone = $data['mobilephone'];
        $this->ip = $data['ip'];
        $this->approved = $data['approved'];
        $this->address = $data['address'];
        $this->birthdate = $data['birthdate'];
        $this->completed_profile = $data['completed_profile'];
        $this->gender = $data['gender'];
        $this->customertype = $data['customertype'];
        $this->age = $data['age'];
        $this->zoneid = $data['zoneid'];
    }


    public function login($email, $password)
    {
        if ("" == $email || "" == $password)
            return false;

        $sql = "SELECT * FROM customer WHERE email = '" . $this->db->escape($email) . "' AND password = '" . $this->db->escape(md5($password)) . "' AND approved = 1 ";
        $query = $this->db->query($sql);

        if ($query->num_rows) {
            $this->session->set('customerid', $query->row['customerid']);
            $this->setMember($query->row);
            $this->db->query("UPDATE customer SET `ip` = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE customerid = '" . (int)$this->session->data['customerid'] . "'");

            return true;
        } else {
            return false;
        }
    }

    public function loginByAccount($account, $password)
    {
        if ("" == $account || "" == $password)
            return false;

        $sql = "SELECT * FROM customer WHERE account = '" . $this->db->escape($account) . "' AND password = '" . $this->db->escape(md5($password)) . "' AND approved = 1 ";
        $query = $this->db->query($sql);

        if ($query->num_rows) {
            $this->session->set('customerid', $query->row['customerid']);
            $this->setMember($query->row);
            $this->db->query("UPDATE customer SET `ip` = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE customerid = '" . (int)$this->session->data['customerid'] . "'");

            return true;
        } else {
            return false;
        }
    }

    public function loginAfterAuthenExternalSystem($email)
    {
        if ("" == $email)
            return false;

        $sql = "SELECT * FROM customer WHERE email = '" . $this->db->escape($email) . "' AND approved = 1 ";
        $query = $this->db->query($sql);

        if ($query->num_rows) {
            $this->session->set('customerid', $query->row['customerid']);
            $this->setMember($query->row);
            $this->db->query("UPDATE customer SET `ip` = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE customerid = '" . (int)$this->session->data['customerid'] . "'");

            return TRUE;
        } else {
            return FALSE;
        }
    }

    public function loginToken($token, $password)
    {
        if ($token == "" || $password == "")
            return false;

        $sql = "SELECT * FROM customer WHERE md5(customerid) = '" . $this->db->escape($token) . "' AND password = '" . $this->db->escape($password) . "' AND approved = 1 ";
        $query = $this->db->query($sql);

        if ($query->num_rows) {
            $this->session->set('customerid', $query->row['customerid']);
            $this->setMember($query->row);
            $this->db->query("UPDATE customer SET `ip` = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE customerid = '" . (int)$this->session->data['customerid'] . "'");

            return TRUE;
        } else {
            return FALSE;
        }
    }


    public function logout()
    {
        $this->session->remove('customerid');

        $this->customerid = "";
        $this->account = "";
        $this->image = "";
        $this->firstname = "";
        $this->lastname = "";
        $this->email = "";
        $this->telephone = "";
        $this->mobilephone = "";
        $this->ip = "";
        $this->approved = "";
        $this->address = "";
        $this->birthdate = "";
        $this->gender = "";
        $this->lastlogin = "";
        $this->customertype = "";
        $this->age = "";
        $this->zoneid = "";


        setcookie("token", '', 1, '/');
        setcookie("password", '', 1, '/');
    }

    public function isLogged()
    {
        if ($this->session->data['customerid']) {
            return true;
        }
        return false;
    }
}