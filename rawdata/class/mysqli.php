<?php
final class DataBase {
	private $link;
    private $hostname;
    private $username;
    private $password;
    private $database;
	public function __construct($hostname, $username, $password, $database) {
		$this->hostname = $hostname;
        $this->username = $username;
        $this->password = $password;
        $this->database = $database;
	}
    public function open()
    {
        $this->link = new mysqli($this->hostname, $this->username, $this->password, $this->database);

        if ($this->link->connect_error) {
            trigger_error('Error: Could not make a database link (' . $this->link->connect_errno . ') ' . $this->link->connect_error);
            exit();
        }

        $this->link->set_charset("utf8");
        $this->link->query("SET SQL_MODE = ''");
    }
    public function close() {
        $this->link->close();
    }

	public function query($sql) {
		$query = $this->link->query($sql);

		if (!$this->link->errno) {
			if ($query instanceof \mysqli_result) {
				$data = array();

				while ($row = $query->fetch_assoc()) {
					$data[] = $row;
				}

				$result = new \stdClass();
				$result->num_rows = $query->num_rows;
				$result->row = isset($data[0]) ? $data[0] : array();
				$result->rows = $data;

				$query->close();

				return $result;
			} else {
				return true;
			}
		} else {
			trigger_error('Error: ' . $this->link->error  . '<br />Error No: ' . $this->link->errno . '<br />' . $sql);
		}

        return false;
	}

	public function escape($value) {
		return $this->link->real_escape_string($value);
	}

	public function countAffected() {
		return $this->link->affected_rows;
	}

	public function getLastId() {
		return $this->link->insert_id;
	}




    public function getNextId($tablename, $tableid)
    {
        $sql = "SELECT max(" . $tableid . ") as max FROM `$tablename`";
        $query = $this->query($sql);
        return $query->rows[0]['max'] + 1;
    }


    function getNextIdVarChar($tablename, $tableid, $prefix)
    {
        $sql = "SELECT $tableid FROM `$tablename` WHERE $tableid LIKE '" . $prefix . "%'";
        $query = $this->query($sql);
        $mid = $query->rows;
        if (count($mid) == 0) return $prefix . "1";
        $mnum = array();
        for ($i = 0; $i < count($mid); $i++) {
            array_push($mnum, substr($mid[$i][$tableid], strlen($prefix)));
        }
        $max = 0;
        for ($i = 0; $i < count($mnum); $i++) if ($max < intval($mnum[$i])) $max = intval($mnum[$i]);
        $nextid = $max + 1;
        return $prefix . $nextid;
    }

    public function getNextIdVarCharNumber($tablename, $tableid, $prefix)
    {
        $sql = "SELECT $tableid FROM `$tablename` WHERE $tableid LIKE '%" . $prefix . "%'";
        $query = $this->query($sql);
        $mid = $query->rows;
        if (count($mid) == 0) return 1;
        $mnum = array();
        for ($i = 0; $i < count($mid); $i++) {

            array_push($mnum, str_replace($prefix, "", $mid[$i][$tableid]));
        }

        $max = 0;
        for ($i = 0; $i < count($mnum); $i++) if ($max < intval($mnum[$i])) $max = intval($mnum[$i]);
        $nextid = $max + 1;
        return $nextid;
    }

    function insertData($tablename = NULL, $fields = NULL, $values = NULL)
    {
        $sql = "INSERT INTO `" . $tablename . "`(";
        if (count($fields) != count($values)) {
            die("<br><b>ERROR (Syntax Error):</b> Number of fields don't match with values.");
        } else {
            is_array($fields) ? $sql .= implode(",", $fields) : $sql .= $fields;
            $sql .= ") VALUES('";
            is_array($values) ? $sql .= implode("','", $values) : $sql .= "'" . $values . "'";
            echo $sql .= "')";
            $this->query($sql);
            $this->clearCatch();
            return $this->getLastId();
        }

    }

    function updateData($tablename = NULL, $fields = NULL, $values = NULL, $where = NULL)
    {
        $sql = "UPDATE `" . $tablename . "` SET ";

        if (count($fields) != count($values)) {
            die("ERROR (Syntax Error): Number of fields don't match with values.");
        } else {
            if (is_array($fields) && is_array($values)) {
                for ($i = 0; $i < count($fields); $i++) {
                    $sql .= $fields[$i] . " = '" . $values[$i] . "' ";
                    if ($i == (count($fields) - 1)) $sql .= " "; else $sql .= ", ";

                }
            } else {
                $sql .= $fields . " = " . $values;
            }
            $sql .= " WHERE " . $where;
            $this->query($sql);
            $this->clearCatch();
        }
    }

    function deleteData($tablename = NULL, $where = NULL)
    {
        $sql = "DELETE FROM `$tablename` WHERE " . $where;
        $this->query($sql);
        $this->clearCatch();
    }
    private function clearCatch()
    {
        $dir = "catch";
        if(!is_dir($dir))
            mkdir($dir,0777);
        $dir .= "/".$this->database;
        if(!is_dir($dir))
            mkdir($dir,0777);
        $files = glob($dir . '/*');
        if(count($files))
        {
            foreach ($files as $file)
            {
                unlink($file);
            }
        }
    }
}