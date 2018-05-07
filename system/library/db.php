<?php

/**
 * Class DB
 *
 * @property Log log
 *
 */
final class DB
{
    private $driver;
    private $log;

    public function __construct($driver, $hostname, $username, $password, $database, $prefix = NULL)
    {
        $class = 'DB\\' . $driver;
        if (!class_exists($class)) {
            exit('Error: Could not load database driver ' . $driver . '!');
        }
        $this->driver = new $class($hostname, $username, $password, $database, $prefix);
        $this->log = Registry::get('log');
    }

    public function query($sql)
    {
        $config = Registry::get('config');
        $debug = $config->get('config_debug');
        if($debug) {
            $starttime = microtime(true);
        }

        $query = $this->driver->query($sql);

        if($debug) {
		    $endtime = microtime(true);
		    $duration = $endtime - $starttime; //calculates total time taken
            $this->log->write($sql."\n----duration = ". ($duration * 1000). " ms\n\n");
        }
		return $query;
    }

    public function escape($value)
    {
        return $this->driver->escape($value);
    }

    public function countAffected()
    {
        return $this->driver->countAffected();
    }

    public function getLastId()
    {
        return $this->driver->getLastId();
    }

    public function getNextId($tablename, $tableid)
    {
        return $this->driver->getNextId($tablename, $tableid);
    }

    public function getNextIdVarChar($tablename, $tableid, $prefix)
    {
        return $this->driver->getNextIdVarChar($tablename, $tableid, $prefix);
    }

    public function getNextIdVarCharNumber($tablename, $tableid, $prefix)
    {
        return $this->driver->getNextIdVarCharNumber($tablename, $tableid, $prefix);
    }

    public function insertData($tablename = NULL, $fields = NULL, $values = NULL)
    {
        return $this->driver->insertData($tablename, $fields, $values);
    }

    public function updateData($tablename = NULL, $fields = NULL, $values = NULL, $where = NULL)
    {
        return $this->driver->updateData($tablename, $fields, $values, $where);
    }

    public function deleteData($tablename = NULL, $where = NULL)
    {
        return $this->driver->deleteData($tablename, $where);
    }
}