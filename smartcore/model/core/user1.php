<?php
/**
 * Class ModelCoreUser
 *
 * property Request $request
 *
 *
 *
 */
class ModelCoreUser extends Model
{
    public function countTotal($where = "")
    {
        $sql = "Select count(*) total from `user` WHERE deletedby = '' " . $where;
        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getItem($userid)
    {
        $userid = $this->db->escape($userid);
        $query = $this->db->query("Select * from `user` where userid = '" . $userid . "'");
        return $query->row;
    }

    public function getItemByUserName($username)
    {
        $username = $this->db->escape($username);
        $query = $this->db->query("Select * from `user` where username = '" . $username . "' AND deletedby =''");
        return $query->row;
    }

    public function getItemByEmail($email)
    {
        $email = $this->db->escape($email);
        $query = $this->db->query("Select * from `user` where email = '" . $email . "' AND deletedby =''");
        return $query->row;
    }

    public function getList($where = "", $from = -1, $to = -1)
    {
        $sql = "Select * from `user` WHERE deletedby = '' " . $where;
        if($from >= 0) {
            $sql .= "LIMIT $from, $to";
        }
        $query = $this->db->query($sql);
        return $query->rows;
    }


    public function insertUser($data)
    {
        $userid = $this->db->escape($data['username']);
        $username = $this->db->escape($data['username']);
        $usertypeid = $this->db->escape($data['usertypeid']);
        $password = $this->db->escape($data['password']);
        $fullname = $this->db->escape($data['fullname']);
        $email = $this->db->escape($data['email']);
        $status = "lock";
        $imagepath = $this->db->escape($data['imagepath']);
        $phone = $this->db->escape($data['phone']);
        $activedate = $this->date->getToday();
        $updateddate = $this->date->getToday();
        $deleteddate = "";
        $activeby = $this->user->getId();
        $updatedby = $this->user->getId();
        $deletedby = "";
        $userip = $this->db->escape($this->request->server['REMOTE_ADDR']);

        $field = array(
            '`userid`', '`username`', '`usertypeid`', '`password`', '`fullname`', '`email`', '`status`',
            '`imagepath`', '`phone`', '`activedate`', '`updateddate`', '`deleteddate`', '`activeby`', '`updatedby`', '`deletedby`', '`userip`'
        );
        $value = array(
            $userid, $username, $usertypeid, md5($password), $fullname, $email, $status,
            $imagepath, $phone, $activedate, $updateddate, $deleteddate, $activeby, $updatedby, $deletedby, $userip
        );
        $arr = $this->getItemByUserName($username);
        if (count($arr) == 0) {
            $this->db->insertData("user", $field, $value);
            return $userid;
        } else {
            return $arr['userid'];
        }
    }

    public function updateUser($data)
    {
        $userid = $this->db->escape($data['userid']);
        $usertypeid = $this->db->escape($data['usertypeid']);
        $fullname = $this->db->escape($data['fullname']);
        $email = $this->db->escape($data['email']);
        $imagepath = $this->db->escape($data['imagepath']);
        $phone = $this->db->escape($data['phone']);
        $activedate = $this->date->getToday();
        $updateddate = $this->date->getToday();
        $deleteddate = "";
        $activeby = $this->user->getId();
        $updatedby = $this->user->getId();
        $deletedby = "";
        $userip = $this->db->escape($this->request->server['REMOTE_ADDR']);

        $field = array(
            'usertypeid', 'fullname', 'email',
            'imagepath', 'phone', 'activedate', 'updateddate', 'deleteddate', 'activeby', 'updatedby', 'deletedby', 'userip'
        );
        $value = array(
            $usertypeid, $fullname, $email,
            $imagepath, $phone, $activedate, $updateddate, $deleteddate, $activeby, $updatedby, $deletedby, $userip
        );
        $where = "userid = '" . $userid . "'";
        $this->db->updateData("user", $field, $value, $where);
    }


    public function updatestatus($data)
    {
        $userid = $this->db->escape($data['userid']);
        $status = $this->db->escape($data['status']);
        $updateddate = $this->date->getToday();
        $updatedby = $this->user->getId();
        $userip = $this->db->escape($this->request->server['REMOTE_ADDR']);

        $field = array(
            'userid', 'status', 'updateddate', 'updatedby', 'userip'
        );
        $value = array(
            $userid, $status, $updateddate, $updatedby, $userip
        );
        $where = "userid = '" . $userid . "'";
        $this->db->updateData("user", $field, $value, $where);
    }


    public function deleteUser($userid)
    {
        $userid = $this->db->escape($userid);
        $deleteddate = $this->date->getToday();
        $deletedby = $this->user->getId();
        $userip = $this->db->escape($this->request->server['REMOTE_ADDR']);

        $field = array(
            'userid', 'deleteddate', 'deletedby', 'userip'
        );
        $value = array(
            $userid, $deleteddate, $deletedby, $userip
        );
        $where = "userid = '" . $userid . "'";
        $this->db->updateData("user", $field, $value, $where);
    }

    public function deleteUsers($data)
    {
        foreach ($data as $userid) {
            $this->deleteUser($userid);
        }
    }


    public function changePassword($data)
    {
        $userid = $this->db->escape($data['userid']);
        $password = $this->db->escape($data['password']);
        $updateddate = $this->db->escape($data['updateddate']);
        $updatedby = $this->db->escape($data['updatedby']);

        $field = array(
            'password', 'updateddate', 'UpdatedBy'
        );
        $value = array(
            $password, $updateddate, $updatedby

        );
        $where = "userid = '" . $userid . "'";
        $this->db->updateData("user", $field, $value, $where);

    }


    public function changeNewPassword($userid, $password)
    {
        if($userid != "") {
            $password = $this->db->escape(@$password);

            $field = array(
                'password'
            );

            $value = array(
                md5($password)
            );

            $where = " userid = '" . $userid . "'";

            $this->db->updateData("user", $field, $value, $where);
        }
    }


    /*
    public function getItem($userid)
    {
        $userid = $this->db->escape($userid);
        $query = $this->db->query("Select * from `user` where userid = '" . $userid . "'");
        return $query->row;
    }

    public function getItemByUserName($username)
    {
        $username = $this->db->escape($username);
        $query = $this->db->query("Select * from `user` where username = '" . $username . "' AND deletedby =''");
        return $query->row;
    }

    public function getItemByEmail($email)
    {
        $email = $this->db->escape($email);
        $query = $this->db->query("Select * from `user` where email = '" . $email . "' AND deletedby =''");
        return $query->row;
    }

    public function insertUser($data)
    {
        $userid = $this->db->escape($data['username']);
        $username = $this->db->escape($data['username']);
        $usertypeid = $this->db->escape($data['usertypeid']);
        $password = $this->db->escape($data['password']);
        $fullname = $this->db->escape($data['fullname']);
        $email = $this->db->escape($data['email']);
        $status = "lock";
        $imageid = $this->db->escape($data['imageid']);
        $imagepath = $this->db->escape($data['imagepath']);
        $address = $this->db->escape($data['address']);
        $provincecity = $this->db->escape($data['provincecity']);
        $country = $this->db->escape($data['country']);
        $birthday = $this->db->escape($data['birthday']);
        $phone = $this->db->escape($data['phone']);
        $activedate = $this->date->getToday();
        $updateddate = $this->date->getToday();
        $deleteddate = "";
        $activeby = $this->user->getId();
        $updatedby = $this->user->getId();
        $deletedby = "";
        $userip = $this->db->escape($this->request->server['REMOTE_ADDR']);

        $field = array(
            '`userid`', '`username`', '`usertypeid`', '`password`', '`fullname`', '`email`', '`status`', '`imageid`', '`imagepath`', '`address`', '`provincecity`', '`country`', '`birthday`', '`phone`', '`activedate`', '`updateddate`', '`deleteddate`', '`activeby`', '`updatedby`', '`deletedby`', '`userip`'
        );
        $value = array(
            $userid, $username, $usertypeid, md5($password), $fullname, $email, $status, $imageid, $imagepath, $address, $provincecity, $country, $birthday, $phone, $activedate, $updateddate, $deleteddate, $activeby, $updatedby, $deletedby, $userip
        );
        $arr = $this->getItemByUserName($username);
        if (count($arr) == 0) {
            $this->db->insertData("user", $field, $value);
            return $userid;
        } else {
            return $arr['userid'];
        }
    }





    public function deleteuser($userid)
    {
        $userid = $this->db->escape($userid);
        $deleteddate = $this->date->getToday();
        $deletedby = $this->user->getId();
        $userip = $this->db->escape($this->request->server['REMOTE_ADDR']);

        $field = array(
            '`userid`', '`deleteddate`', '`deletedby`', '`userip`'
        );
        $value = array(
            $userid, $deleteddate, $deletedby, $userip
        );
        $where = "userid = '" . $userid . "'";
        $this->db->updateData("user", $field, $value, $where);
    }

    public function deleteusers($data)
    {
        foreach ($data as $userid) {
            $this->deleteuser($userid);
        }
    }

    public function validatePassword($UserID, $Pass)
    {
        $contain = $this->getItem($UserID);
        if (count($contain) == 0) {
            return false;
        } else {

            if ($contain['password'] == $Pass) {
                return true;
            } else {
                return false;
            }
        }
    }

    public function changePassword($data)
    {
        $userid = $this->db->escape($data['userid']);
        $password = $this->db->escape($data['password']);
        $updateddate = $this->db->escape($data['updateddate']);
        $updatedby = $this->db->escape($data['updatedby']);

        $field = array(
            'password', 'updateddate', 'UpdatedBy'
        );
        $value = array(
            $password, $updateddate, $updatedby

        );
        $where = "userid = '" . $userid . "'";
        $this->db->updateData("user", $field, $value, $where);

    }

    public function getInformation($userid, $fieldname)
    {
        $sql = "Select * from user_information where userid = '" . $userid . "' and fieldname = '" . $fieldname . "'";
        $query = $this->db->query($sql);
        $info = $query->row;
        return $info['fieldvalue'];
    }

    public function saveInformation($userid, $fieldname, $fieldvalue)
    {
        $sql = "Select * from user_information where userid = '" . $userid . "' and fieldname = '" . $fieldname . "'";
        $query = $this->db->query($sql);
        $info = $query->rows;

        $field = array(
            "userid", "fieldname", "fieldvalue"
        );

        $value = array(
            $userid, $fieldname, $fieldvalue,
        );

        if (count($info) > 0) {
            $where = "userid = '" . $userid . "' AND fieldname = '" . $fieldname . "'";
            $this->db->updateData('user_information', $field, $value, $where);
        } else {
            $this->db->insertData("user_information", $field, $value);
        }
    }
    */
}