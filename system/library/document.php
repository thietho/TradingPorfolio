<?php

/**
 * Class Document
 *
 * @property Config config
 * @property Db db
 * @property Date date
 *
 */
final class Document
{
    public $title;
    public $description = '';
    public $keywords = '';
    public $languages = array();
    public $links = array();
    public $styles = array();
    public $pageStyles = array();
    public $scripts = array(); //common javascript library
    public $pageScripts = array(); //javascript for each tpl
    public $setting = array();
    public $sitemapid = '';
    public $breadcrumbs = '';
    public $route = '';
    public $permission = array();
    public $moneyval = array(
        100,200,500,1000,2000,5000,10000,20000,50000,100000,200000,500000
    );
    public $status = array(
        '0' => 'Active',
        '1' => 'Hidden'
    );
    public $userStatus = array(
        'active' => 'Active',
        'lock' => 'Lock'
    );
    public $invoicestatus = array(
        'pending' => 'Chờ duyệt',
        'approved' => 'Đã duyệt'
    );
    public $invoicestype = array(
        'INC' => 'Thu',
        'EXP' => 'Chi'
    );

    public $cardtype = array(
        'customer' => 'Customer',
        'company' => 'Company',
        'staff' => 'Staff',
        'other' => 'Other'
    );
    public $inventorycheckstatus = array(
        'pending' => 'Chờ xử lý',
        'complete' => 'Đã xử lý xong'
    );


    public $tablelocation = array(
        'LA' => 'Location A',
        'LB' => 'Location B'
    );
    public $transactiontype = array(
        'B' => 'Mua',
        'S' => 'Bán'
    );
    public function __construct()
    {
        $this->config = Registry::get('config');
        $this->language = Registry::get('language');
        $this->db = Registry::get('db');
        $this->date = Registry::get('date');
        $arr_language = explode(",", $this->config->get("config_language"));
        $languagelist = $this->language->getLanguages();
        foreach ($arr_language as $item) {
            $item = trim($item);
            $this->languages[trim($item)] = $languagelist[$item]["name"];
        }
        $this->getSetting();
    }
    public function currencyFormate($num,$n=0)
    {
        $config = Registry::get('config');
        if($n == 0)
            $n = $config->get('config_number_decimal');
        $dec_point = $config->get('config_dec_point');
        $thousands_sep = $config->get('config_thousands_sep');
        $num1 = number_format($num,$n);
        //if($num1 == 0)
            //return '';
        /*if($num >= 0)
            return $this->setting['currencyprefix'].number_format($num, $n, $dec_point, $thousands_sep).$this->setting['currencysubfix'];
        else
            return $this->setting['currencyprefix']."(".number_format($num*-1, $n, $dec_point, $thousands_sep).")".$this->setting['currencysubfix'];*/
        return $this->setting['currencyprefix'].number_format($num, $n, $dec_point, $thousands_sep).$this->setting['currencysubfix'];
    }
    public function loadDataPermission()
    {
        $filename = DIR_SYSTEM."permission.json";
        $handle = fopen($filename, "r");
        $contents = fread($handle, filesize($filename));
        fclose($handle);
        return json_decode($contents,true);
    }

    public function getLanguage()
    {
        return $this->languages;
    }


    public function getTitle()
    {
        return $this->title;
    }

    public function setTitle($title)
    {
        $this->title = $title;
    }

    public function getDescription()
    {
        return $this->description;
    }

    public function setDescription($description)
    {
        $this->description = $description;
    }

    public function getKeywords()
    {
        return $this->keywords;
    }

    public function setKeywords($keywords)
    {
        $this->keywords = $keywords;
    }

    public function addLink($href, $rel = "canonical")
    {
        $this->links[md5($href)] = array(
            'href' => $href,
            'rel' => $rel
        );
    }

    public function getLinks()
    {
        return $this->links;
    }

    public function addStyle($href, $rel = 'stylesheet', $media = 'screen')
    {
        if (!$this->config->get('config_web_publish')) {
            $this->styles[md5($href)] = array(
                'href' => $href,
                'rel' => $rel,
                'media' => $media
            );
        }
    }

    public function getStyles()
    {
        return $this->styles;
    }


    public function addPageStyle($path)
    {
        if (!$this->config->get('config_web_publish')) {
            $file = DIR_TEMPLATE_CSS . $path;
            if(file_exists(DIR_USERTEMPLATE_CSS . $path)) {
                $file = DIR_USERTEMPLATE_CSS . $path;
            }
            $csscontent = file_get_contents($file);
            $cssMin = new CSSmin();
            $mincsscontent = $cssMin->run($csscontent);

            $filename = substr($file, 0, -4);
            file_put_contents($filename . ".min.css", $mincsscontent);
        }

        $pathWithoutExt = substr($path, 0, -4);
        $filecss = DIR_TEMPLATE_CSS . $pathWithoutExt . ".min.css";
        if(file_exists(DIR_USERTEMPLATE_CSS . $path)) {
            $filecss = DIR_USERTEMPLATE_CSS . $pathWithoutExt . ".min.css";
        }
        $this->pageStyles[md5($path)] = $filecss;
    }

    public function getPageStyles()
    {
        return $this->pageStyles;
    }


    public function addLibraryScripts($scripts)
    {
        if (!$this->config->get('config_web_publish')) {
            $scripts = array_reverse($scripts);
            foreach($scripts as $script) {
                array_unshift($this->scripts, $script);
            }
        }
    }

    public function addScript($script)
    {
        if (!$this->config->get('config_web_publish')) {
            $this->scripts[] = $script;
        }
    }

    public function getScripts()
    {
        return $this->scripts;
    }

    public function addPageScript($path)
    {
        if(!isset($this->pageScripts[md5($path)])) {
            if (!$this->config->get('config_web_publish')) {
                $file = DIR_TEMPLATE_JS . $path;
                if(file_exists(DIR_USERTEMPLATE_JS . $path)) {
                    $file = DIR_USERTEMPLATE_JS . $path;
                }
                $jscontent = file_get_contents($file);
                $minjscontent = Minifier::minify($jscontent);
                $filename = substr($file, 0, -3);
                file_put_contents($filename . ".min.js", $minjscontent);
            }

            $pathWithoutExt = substr($path, 0, -3);
            $filejs = DIR_TEMPLATE_JS . $pathWithoutExt . ".min.js";
            if(file_exists(DIR_USERTEMPLATE_JS . $path)) {
                $filejs = DIR_USERTEMPLATE_JS . $pathWithoutExt . ".min.js";
            }
            $this->pageScripts[md5($path)] = $filejs;
        }
    }
    public function getSetting()
    {
        $query = $this->db->query("Select *
                    from `soft_setting`");
        $data = $query->rows;
        foreach ($data as $item){
            $this->setting[$item['settingcode']] = $item['settingvalue'];
        }
        $ini_array = parse_ini_file(DIR_SYSTEM."setting.ini");
        $this->setting = array_merge($this->setting,$ini_array['setting']);
    }
    public function getPageScripts()
    {
        return $this->pageScripts;
    }
    public function getCard($cardid,$name = 'fullname')
    {
        $query = $this->db->query("Select `card`.*
									from `card`
									where cardid ='" . $cardid . "' ");
        return $query->row[$name];
    }
    public function getAccountstock($accountid,$name = 'cardid')
    {
        $query = $this->db->query("Select `accountstock`.*
									from `accountstock`
									where accountid ='" . $accountid . "' ");
        return $query->row[$name];
    }
    public function getItem($symbol,$name = 'name')
    {
        $query = $this->db->query("Select `item`.*
									from `item`
									where symbol ='" . $symbol . "' ");
        return $query->row[$name];
    }
    public function getDividendCash($id,$name = '')
    {
        $query = $this->db->query("Select `dividendcash`.*
									from `dividendcash`
									where id ='" . $id . "' ");
        if($name == ''){
            return $query->row['symbol']." - ".$query->row['accountid']." - ".$query->row['notes'];
        }
        return $query->row[$name];
    }
    public function getUserType($usertypeid,$name = 'usertypename')
    {
        $query = $this->db->query("Select `usertype`.*
									from `usertype`
									where usertypeid ='" . $usertypeid . "' ");
        return $query->row[$name];
    }

    public function getModule($id,$name = 'modulename')
    {
        if($id == 0)
            return 'Root';
        $query = $this->db->query("Select `user_module`.*
									from `user_module`
									where id ='" . $id . "' ");
        return $query->row[$name];
    }
}