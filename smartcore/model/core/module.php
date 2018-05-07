<?php
/**
 * ModelCoreModule
 * @property Date date
 *
 *
 */
class ModelCoreModule extends Model
{
    private $arr_col = array(
        'moduleid', 
		'modulename', 
		'modulepath', 
		'moduleparent', 
		'moduleicon', 
		'position',
		'isshow',
    );

    public function getItem($id)
    {
        $query = $this->db->query("Select `user_module`.*
									from `user_module`
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
                from `user_module`
				where 1=1 ". $where;

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getList($where = "", $from = 0, $to = 0)
    {
        $sql = "Select *
                from `user_module`
				where 1=1 ";

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
        $this->db->updateData("user_module", $field, $value, $where);
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
            $data['id'] = $this->db->insertData("user_module", $field, $value);
        } else {
            $where = "id = '" . $data['id'] . "'";
            $this->db->updateData("user_module", $field, $value, $where);
        }
        return $data['id'];
    }


    public function delete($id)
    {
        $where = "id = '" . $id . "'";
        $this->db->deleteData("user_module", $where);
    }
    public function getNextPos($parent){
        $next = 1;
        $childs = $this->getChild($parent);
        if(count($childs))
        {
            $next = $childs[count($childs)-1]['position'] +1;
        }
        return $next;
    }
    public function getChild($parent)
    {
        $where = "AND moduleparent = '$parent'" ;
        return $this->getList($where);
    }
    public function getPath($id)
    {
        $data_module = array();
        if($id)
        {
            $module = $this->getItem($id);
            while(count($module))
            {
                $data_category[] = $module;
                $module = $this->getItem($module['moduleparent']);
            }
            $data = array();
            for($i = count($data_module) - 1 ; $i>=0 ; $i--)
                $data[] = $data_module[$i];
            return $data;
        }
        return $data_module;

    }

    function getTree($id, &$data, $level=-1, $path="", $parentpath="")
    {
        $arr = $this->getItem($id);

        $rows = $this->getChild($id);

        $arr['countchild'] = count($rows);

        if(@$arr['parent'] != "")
            $parentpath .= "-".$arr['parent'];

        if($id)
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
}
?>