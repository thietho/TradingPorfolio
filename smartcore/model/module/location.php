<?php
/**
 * ModelModuleLocation
 * @property Date date
 *
 *
 */
class ModelModuleLocation extends Model
{
    private $arr_col = array(
        'locationname', 
		'xval', 
		'yval', 
		'parent', 
		'sortorder',
        'shipfee',
        'shipfeeorder',
        'freeshiporder'
    );

    public function getItem($id)
    {
        $query = $this->db->query("Select `location`.*
									from `location`
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
                from `location`
				where 1=1 ". $where;

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getList($where = "", $from = 0, $to = 0)
    {
        $sql = "Select *
                from `location`
				where 1=1 ";

        $sql .= $where;
        if ($to > 0) {
            $sql .= " Limit " . $from . "," . $to;
        }

        $query = $this->db->query($sql);
        return $query->rows;
    }
    public function getChild($parent)
    {
        $where = "AND parent like '$parent' Order by sortorder" ;
        return $this->getList($where);
    }
    public function getNextSortOrder($parent){
        $next = 1;
        $childs = $this->getChild($parent);
        if(count($childs))
        {
            $next = $childs[count($childs)-1]['sortorder'] +1;
        }
        return $next;
    }
    public function getPath($id)
    {
        $data_obj = array();
        if((int)$id != 0)
        {
            $obj = $this->getItem($id);
            while(count($obj))
            {
                $data_obj[] = $obj;
                $obj = $this->getItem($obj['parent']);
            }
            $data = array();
            for($i = count($data_obj) - 1 ; $i>=0 ; $i--)
                $data[] = $data_obj[$i];
            return $data;
        }
        return $data_obj;

    }
    public function showPath($id)
    {
        $data = array();
        if((int)$id != 0)
        {
            $obj = $this->getItem($id);
            while(count($obj))
            {
                $data[] = $obj['locationname'];
                $obj = $this->getItem($obj['parent']);
            }
            return implode(' - ',$data);
        }
        else
            return '';

    }
    function getTree($id, &$data, $level=-1, $path="", $parentpath="")
    {
        $arr=$this->getItem($id);

        $rows = @$this->getChild($id);
        $arr['countchild'] = count($rows);
        if(@$arr['parent'] != "")
            $parentpath .= "-".$arr['parent'];

        if((int)$id!=0 )
        {
            $level += 1;
            $path .= "-".$id;

            @$arr['level'] = $level;
            @$arr['path'] = $path;
            @$arr['parentpath'] = $parentpath;

            array_push($data,$arr);
        }
        if(count($rows))
            foreach($rows as $row)
            {
                @$this->getTree($row['id'], $data, $level, $path, $parentpath);
            }
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
        $this->db->updateData("location", $field, $value, $where);
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
        } else {
            //insert new item

        }


        foreach ($this->arr_col as $col) {
            $value[] = $this->db->escape(@$data[$col]);
        }

        $field = $this->arr_col;

        if ($data['id'] == '') {
            $data['id'] = $this->db->insertData("location", $field, $value);
        } else {
            $where = "id = '" . $data['id'] . "'";
            $this->db->updateData("location", $field, $value, $where);
        }
        return $data['id'];
    }


    public function delete($id)
    {
        $where = "id = '" . $id . "'";
        $this->db->deleteData("location", $where);
    }
}
?>