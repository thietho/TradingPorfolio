<?php
/**
 * ModelModuleMargin
 * @property Date date
 *
 *
 */
class ModelModuleMargin extends Model
{
    private $arr_col = array(
        'opendate', 
		'closedate', 
		'amount', 
		'countdate', 
		'rate', 
		'totalpay', 
		'cardid', 
		'accountid', 
		'transactionid', 
		'createdate', 
		'createby', 
		'updatedate', 
		'updateby', 
		'deletedate', 
		'deleteby'
    );

    public function getItem($id)
    {
        $query = $this->db->query("Select `margin`.*
									from `margin`
									where id ='" . $id . "' ");
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
                from `margin`
				where deleteby = '' ". $where;

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getList($where = "", $from = 0, $to = 0)
    {
        $sql = "Select *
                from `margin`
				where deleteby = '' ";

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
        $this->db->updateData("margin", $field, $value, $where);
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
            $data['updatedate'] = $this->date->getToday();
            $data['updateby'] = $this->user->getUserName();
        } else {
            //insert new item
            $data['createdate'] = $this->date->getToday();
            $data['createby'] = $this->user->getUserName();
            $data['updatedate'] = $this->date->getToday();
            $data['updateby'] = $this->user->getUserName();
        }


        foreach ($this->arr_col as $col) {
            $value[] = $this->db->escape(@$data[$col]);
        }

        $field = $this->arr_col;

        if ($data['id'] == '') {
            $data['id'] = $this->db->insertData("margin", $field, $value);
        } else {
            $where = "id = '" . $data['id'] . "'";
            $this->db->updateData("margin", $field, $value, $where);
        }
        return $data['id'];
    }

    public function destroy($id)
    {
        $where = "id = '" . $id . "'";
        $this->db->deleteData("margin", $where);
    }

    public function delete($id)
    {
        $where = "id = '" . $id . "'";
        $field = array('deleteby','deletedate');
        $value = array($this->user->getUserName(),$this->date->getToday());
        $this->db->updateData("margin", $field, $value, $where);
    }
}
?>