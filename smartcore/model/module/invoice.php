<?php
/**
 * ModelModuleInvoice
 * @property Date date
 *
 *
 */
class ModelModuleInvoice extends Model
{
    private $arr_col = array(
        'invoiceid', 
		'invoicedate', 
		'transactionid', 
		'marginid', 
		'dividendid', 
		'invoicetype', 
		'amount', 
		'notes', 
		'createdate', 
		'createby', 
		'updatedate', 
		'updateby', 
		'deletedate', 
		'deleteby'
    );

    public function getItem($id)
    {
        $query = $this->db->query("Select `invoice`.*
									from `invoice`
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
                from `invoice`
				where deleteby = '' ". $where;

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getList($where = "", $from = 0, $to = 0)
    {
        $sql = "Select *
                from `invoice`
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
        $this->db->updateData("invoice", $field, $value, $where);
    }
    public function createId($prefix)
    {
        $now = $this->date->getToday();
        $year = $this->date->getYear($now);
        $month = $this->date->getMonth($now);
        $nextid = $this->db->getNextIdVarCharNumber('invoice','invoiceid',$prefix.$year.$month);
        return $prefix.$year.$month.$this->string->numberToString($nextid,5);
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
        if($data['invoiceid'] == ''){
            $data['invoiceid'] = $this->createId($data['invoicetype']);
        }

        foreach ($this->arr_col as $col) {
            $value[] = $this->db->escape(@$data[$col]);
        }

        $field = $this->arr_col;

        if ($data['id'] == '') {
            $data['id'] = $this->db->insertData("invoice", $field, $value);
        } else {
            $where = "id = '" . $data['id'] . "'";
            $this->db->updateData("invoice", $field, $value, $where);
        }
        return $data['invoiceid'];
    }

    public function destroy($id)
    {
        $where = "id = '" . $id . "'";
        $this->db->deleteData("invoice", $where);
    }

    public function delete($id)
    {
        $where = "id = '" . $id . "'";
        $field = array('deleteby','deletedate');
        $value = array($this->user->getUserName(),$this->date->getToday());
        $this->db->updateData("invoice", $field, $value, $where);
    }
}
?>