<?php
/**
 * ModelCoreSetting
 * @property Date date
 *
 *
 */
class ModelCoreSetting extends Model
{
    private $arr_col = array(
        'settingcode',
		'settingvalue'
    );

    public function getItem($id)
    {
        $query = $this->db->query("Select `soft_setting`.*
									from `soft_setting`
									where id ='" . $id . "' ");
        return $query->row;
    }
    public function getItemByCode($settingcode)
    {
        $query = $this->db->query("Select `soft_setting`.*
									from `soft_setting`
									where settingcode ='" . $settingcode . "' ");
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
                from `soft_setting`
				where 1=1 ". $where;

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getList($where = "", $from = 0, $to = 0)
    {
        $sql = "Select *
                from `soft_setting`
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
        $this->db->updateData("soft_setting", $field, $value, $where);
    }
    public function getSettingInfo()
    {
        $ini_array = parse_ini_file(DIR_SYSTEM."setting.ini");
        return $ini_array['setting'];
    }
    public function getDataBaseSize()
    {
        $sql = "SELECT table_schema, SUM( data_length + index_length ) /1024 /1024 \"datasizemb\", SUM( data_free ) /1024 /1024 \"freespacemb\"
                FROM information_schema.TABLES
                WHERE table_schema =  '".DB_DATABASE."'";
        $query = $this->db->query($sql);
        return $query->row;
    }
    public function foldersize($path) {
        $total_size = 0;
        @$files = scandir($path);
        //var_dump($files);
        if($files){
            foreach($files as $t) {
                if (is_dir(rtrim($path, '/') . '/' . $t)) {
                    if ($t<>"." && $t<>"..") {
                        $size = $this->foldersize(rtrim($path, '/') . '/' . $t);

                        $total_size += $size;
                    }
                } else {
                    $size = filesize(rtrim($path, '/') . '/' . $t);
                    $total_size += $size;
                }
            }
        }

        return $total_size;
    }

    public function format_size($size) {
        $mod = 1024;
        $units = explode(' ','B KB MB GB TB PB');
        for ($i = 0; $size > $mod; $i++) {
            $size /= $mod;
        }

        return round($size, 2) . ' ' . $units[$i];
    }
    public function save($data)
    {
        $obj = $this->getItemByCode($data['settingcode']);
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

        if (count($obj)==0) {
            $data['id'] = $this->db->insertData("soft_setting", $field, $value);
        } else {
            $where = "settingcode = '" . $data['settingcode'] . "'";
            $this->db->updateData("soft_setting", $field, $value, $where);
        }
        return $data['id'];
    }


    public function delete($id)
    {
        $where = "id = '" . $id . "'";
        $this->db->deleteData("soft_setting", $where);
    }
}
?>