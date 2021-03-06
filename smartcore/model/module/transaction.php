<?php
/**
 * ModelModuleTransaction
 * @property Date date
 *
 *
 */
class ModelModuleTransaction extends Model
{
    private $arr_col = array(
        'transactionid', 
		'accountid', 
		'cardid', 
		'transactiondate', 
		'receivemoneydate', 
		'receivestockdate', 
		'symbol', 
		'name', 
		'type', 
		'costofsale', 
		'volume', 
		'price', 
		'fee', 
		'tax', 
		'total', 
		'profit', 
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
        $query = $this->db->query("Select `transaction`.*
									from `transaction`
									where id ='" . $id . "' ");
        return $query->row;
    }
    public function getItemById($transactionid)
    {
        $query = $this->db->query("Select `transaction`.*
									from `transaction`
									where transactionid ='" . $transactionid . "' ");
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
                from `transaction`
				where deleteby = '' ". $where;

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getList($where = "", $from = 0, $to = 0)
    {
        $sql = "Select *
                from `transaction`
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
        $this->db->updateData("transaction", $field, $value, $where);
    }
    public function createId($prefix)
    {
        $now = $this->date->getToday();
        $year = $this->date->getYear($now);
        $month = $this->date->getMonth($now);
        $nextid = $this->db->getNextIdVarCharNumber('transaction','transactionid',$prefix.$year.$month);
        return $prefix.$year.$month.$this->string->numberToString($nextid,3);
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
            $data['id'] = $this->db->insertData("transaction", $field, $value);
        } else {
            $where = "id = '" . $data['id'] . "'";
            $this->db->updateData("transaction", $field, $value, $where);
        }
        return $data['id'];
    }
    public function destroy($id)
    {
        //Destroy invoice
        $transaction = $this->getItem($id);
        $where = "transactionid = '" . $transaction['transactionid'] . "'";
        $this->db->deleteData("invoice", $where);

        $where = "id = '" . $id . "'";
        $this->db->deleteData("transaction", $where);
    }

    public function delete($id)
    {
        //Xóa invoice
        $transaction = $this->getItem($id);
        $where = "transactionid = '" . $transaction['transactionid'] . "'";
        $field = array('deleteby','deletedate');
        $value = array($this->user->getUserName(),$this->date->getToday());
        $this->db->updateData("invoice", $field, $value, $where);

        $where = "id = '" . $id . "'";
        $field = array('deleteby','deletedate');
        $value = array($this->user->getUserName(),$this->date->getToday());
        $this->db->updateData("transaction", $field, $value, $where);

    }

    public function getCostOfSale($accountid,$symbol,$transaction)
    {
        $where = " AND accountid like '$accountid' AND symbol like '$symbol'";
        if($transaction['id'] != ''){
            $where .= " AND id < ".$transaction['id'];
        }
        $where .= " ORDER BY `createby` ASC";
        $data = $this->getList($where);

        $sumvolumebuy = 0;
        $sumvolumesale = 0;
        $sumtotalbuy = 0;
        $sumtotalesale = 0;
        $sumcostofsale = 0;
        foreach ($data as $item){
            if($item['type'] == 'B'){
                $sumvolumebuy += $item['volume'];
                $sumtotalbuy += $item['total'];
            }else{
                $sumvolumesale += $item['volume'];
                $sumtotalesale += $item['total'];
                $sumcostofsale += $item['costofsale']*$item['volume'];
            }
        }
        if( $sumvolumebuy - $sumvolumesale == 0)
            return 0;

        $cost = ($sumtotalbuy - $sumcostofsale)/($sumvolumebuy - $sumvolumesale);
        return $cost;

    }
}
?>