<?php
/**
 * ModelCoreUser
 * @property Date date
 *
 *
 */
class ModelCoreUser extends Model
{
    private $arr_col = array(
        'userid', 
		'usertypeid', 
		'username', 
		'password', 
		'fullname', 
		'email', 
		'status', 
		'imagepath', 
		'phone', 
		'activedate', 
		'updateddate', 
		'deleteddate', 
		'activeby', 
		'updatedby', 
		'deletedby', 
		'userip', 
		'permission'
    );

    public function getItem($id)
    {
        $query = $this->db->query("Select `user`.*
									from `user`
									where id ='" . $id . "' ");
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
    /**
     * @param string $where
     * @param int $from
     * @param int $to
     * @return mixed
     */
    public function countTotal($where)
    {
        $sql = "Select count(*) as total
                from `user`
				where 1=1 ". $where;

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getList($where = "", $from = 0, $to = 0)
    {
        $sql = "Select *
                from `user`
				where 1=1 ";

        $sql .= $where;
        if ($to > 0) {
            $sql .= " Limit " . $from . "," . $to;
        }

        $query = $this->db->query($sql);
        return $query->rows;
    }

    public function updateCol($username, $col, $val)
    {
        $username = $this->db->escape($username);
        $col = $this->db->escape($col);
        $val = $this->db->escape($val);

        $field = array(
            $col
        );
        $value = array(
            $val
        );

        $where = "username = '" . $username . "'";
        $this->db->updateData("user", $field, $value, $where);
    }

    public function save($data)
    {
        $obj = $this->getItem($data['id']);
        $value = array();
        $data['updateddate'] = $this->date->getToday();
        $data['updatedby'] = $this->user->getId();
        $data['userip'] = $this->request->server['REMOTE_ADDR'];
        $usertype = $this->getUserType($data['usertypeid']);
        $data['permission'] = $usertype['permission'];
        if (count($obj)) {
            //update old item
            foreach ($obj as $col => $val) {
                if (isset($data[$col]))
                    $obj[$col] = $data[$col];
            }
            $data = $obj;
        } else {
            //insert new item
            $data['activedate'] = $this->date->getToday();
            $data['activeby'] = $this->user->getId();
        }


        foreach ($this->arr_col as $col) {
            $value[] = $this->db->escape(@$data[$col]);
        }

        $field = $this->arr_col;

        if ($data['id'] == '') {
            $data['id'] = $this->db->insertData("user", $field, $value);
        } else {
            $where = "id = '" . $data['id'] . "'";
            $this->db->updateData("user", $field, $value, $where);
        }


        return $data['id'];
    }


    public function delete($id)
    {
        $user = $this->getItem($id);
        $user['status'] = 'delete';
        $user['deleteddate'] = $this->date->getToday();
        $user['deletedby'] = $this->user->getId();
        $this->save($user);
    }
    public function destroy($id)
    {
        $where = "id = '" . $id . "'";
        $this->db->deleteData("user", $where);
    }
    private function getUserType($usertypeid)
    {
        $query = $this->db->query("Select `usertype`.*
									from `usertype`
									where usertypeid ='" . $usertypeid . "' ");
        return $query->row;
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
}
?>