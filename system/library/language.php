<?php
class Language {
	private $default = 'vn';
    private $config;
    private $cache;
	private $directory;
	private $data = array();
    private $languages = array();

	public function __construct($directory = '') {
        $this->config = Registry::get('config');
        $this->cache = Registry::get('cache');
        $this->db = Registry::get('db');

		$this->directory = $directory;

        $this->getDefaultDictionary();

        //Lay toan bo Language Record
        $this->languages = $this->getDataLanguage();
	}

	public function get($key) {
		return (isset($this->data[$key]) ? $this->data[$key] : $key);
	}

	public function all() {
		return $this->data;
	}

    public function getLanguages()
    {
        return $this->languages;
    }
	
	public function load($filename) {
		$_ = array();

		$file = DIR_LANGUAGE . $this->directory . '/' . $filename . '.php';
		if (file_exists($file)) {
			require($file);
		} else {
            $file = DIR_LANGUAGE . $this->default . '/' . $filename . '.php';
            if (file_exists($file)) {
                require($file);
            }
        }
		$this->data = array_merge($this->data, $_);

		return $this->data;
	}

    protected function getDefaultDictionary()
    {
        $filename = DIR_USERLANGUAGE . "language.json";
        if (!file_exists($filename)) {
            $filename = DIR_LANGUAGE . "language.json";
            if (!is_file($filename)) {
                file_put_contents($filename, "");
            }
        }

        $contents = file_get_contents($filename);
        $obj = json_decode($contents);
        $_ = array();
        $defaultlanguageid = $this->directory;

        if (count($obj)) {
            foreach ($obj as $item) {
                $_[$item->languagekey] = $item->$defaultlanguageid;
            }
        }
        $this->data = array_merge($this->data, $_);

        return $this->data;
    }


    private function getDataLanguage()
    {
        $cacheData = "";
        $keyCache = "";
        $data = array();
        if($this->config->get('config_use_cache')) {
            $keyCache = get_class($this) . '_' . __FUNCTION__ . '_' . $this->config->get('config_languageid');
            $cacheData = $this->cache->get($keyCache);
        }
        if ($cacheData == "") {
            $query = $this->db->query("SELECT * FROM language");
            foreach ($query->rows as $result) {
                $data[$result['code']] = array('languageid' => $result['languageid'], 'name' => $result['name'], 'code' => $result['code'], 'locale' => $result['locale'], 'directory' => $result['directory'], 'filename' => $result['filename']);
            }
            if ($this->config->get('config_use_cache')) {
                $this->cache->set($keyCache, $data);
            }
        } else {
            return $cacheData;
        }
        return $data;
    }
}