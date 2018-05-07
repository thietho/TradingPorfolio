<?php
/**
 * ModelModuleCard
 * @property Date date
 *
 *
 */
class ModelModuleCard extends Model
{
    private $arr_col = array(
        'cardid',
		'account', 
		'image', 
		'firstname',
        'lastname',
        'fullname',
        'companyname',
        'bankinfo',
        'taxcode',
        'email',
		'telephone', 
		'mobilephone', 
		'password', 
		'ip', 
		'approved', 
		'activecode', 
		'added_date', 
		'updated_date', 
		'addressline1', 
		'addressline2', 
		'birthdate', 
		'gender',
        'cardtype',
		'age', 
		'zoneid',
        'notes',
        'levelcode',
        'deletedby',
        'deleteddate'
    );

    public function getItem($id)
    {
        $query = $this->db->query("Select `card`.*
									from `card`
									where id ='" . $id . "' ");
        return $query->row;
    }
    public function getItemById($cardid)
    {
        $sql = "Select `card`.*
									from `card`
									where cardid ='" . $cardid . "' ";
        $query = $this->db->query($sql);
        return $query->row;
    }
    public function getItemByAccount($account)
    {
        $query = $this->db->query("Select `card`.*
									from `card`
									where account ='" . $account . "' ");
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
                from `card`
				where deletedby = '' ". $where;

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getList($where = "", $from = 0, $to = 0)
    {
        $sql = "Select *
                from `card`
				where deletedby = '' ";

        $sql .= $where;
        if ($to > 0) {
            $sql .= " Limit " . $from . "," . $to;
        }

        $query = $this->db->query($sql);
        return $query->rows;
    }

    public function updateCol($id, $col, $val)
    {
        $id = $this->db->escape($id);
        $col = $this->db->escape($col);
        $val = $this->db->escape($val);

        $field = array(
            $col
        );
        $value = array(
            $val
        );

        $where = "id = '" . $id . "'";
        $this->db->updateData("card", $field, $value, $where);
    }
    public function createCardId($prefix = '')
    {


        $nextid = $this->db->getNextIdVarCharNumber('card','cardid',$prefix);
        return $prefix.$this->string->numberToString($nextid,5);


    }
    public function save($data)
    {
        $obj = $this->getItem($data['id']);
        $value = array();
        if (count($obj)) {
            //update old item
            foreach ($obj as $col => $val) {
                if (isset($data[$col]))
                    $obj[$col] = $data[$col];
            }
            $data = $obj;
            $data['updated_date'] = $this->date->getToday();
        } else {
            //insert new item

            $data['added_date'] = $this->date->getToday();
            $data['updated_date'] = $this->date->getToday();
        }


        foreach ($this->arr_col as $col) {
            $value[] = $this->db->escape(@$data[$col]);
        }

        $field = $this->arr_col;

        if ($data['id'] == '') {
            $data['id'] = $this->db->insertData("card", $field, $value);
        } else {
            $where = "id = '" . $data['id'] . "'";
            $this->db->updateData("card", $field, $value, $where);
        }
        return $data['id'];
    }


    public function delete($id)
    {
        //$where = "id = '" . $id . "'";
        //$this->db->deleteData("card", $where);
        $this->updateCol($id,'deletedby',$this->user->getUserName());
        $this->updateCol($id,'deleteddate',$this->date->getToday());
    }
}
?>