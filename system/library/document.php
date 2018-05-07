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
    public $invoicetype = array(
        'income' => 'Income',
        'expense' => 'Expense'
    );
    public $methodtype = array(
        'cash' => 'Tiền mặt',
        'bank' => 'Chuyển khoản',
        'debit' => 'Tạm ứng'
    );
    public $cardtype = array(
        'customer' => 'Customer',
        'supplier' => 'Supplier',
        'staff' => 'Staff',
        'other' => 'Other'
    );
    public $inventorycheckstatus = array(
        'pending' => 'Chờ xử lý',
        'complete' => 'Đã xử lý xong'
    );

    public $importtype = array(
        'IPO' => 'Purchase Order',
        'IPC' => 'Import Processing',
        'IIN' => 'Import Internal',
        'IRO' => 'Import Return Orders',
    );
    public $exporttype = array(
        'EIN' => 'Export Internal',
        'EPC' => 'Export Processing',
        'ERO' => 'Export return orders',
        'EDE' => 'Export Destroy',
    );
    public $saletype = array(
        'ESA' => 'Sale',
        'SAS' => 'Sale Services'
    );
    public $accounttype = array(
        'debit' => 'Debit',
        'credit' => 'Cretid'
    );

    public $tabletype = array(
        'normal' => 'Normal',
        'vip' => 'VIP'
    );
    public $tablelocation = array(
        'LA' => 'Location A',
        'LB' => 'Location B'
    );
    public $servicestatus = array(
        'active' => 'Active',
        'suspend' => 'Suspend',
        'delete' => 'Delete'
    );
    public $depreciationtype = array(
        'no' => 'No',
        'target' => 'Straight-Line',
        'percent' => 'Declining-Balance'
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
    public function getStatus($statuscode,$name = 'statusname')
    {
        $query = $this->db->query("Select `orderstatus`.*
									from `orderstatus`
									where statuscode ='" . $statuscode . "' ");
        return $query->row[$name];
    }
    public function getUserType($usertypeid,$name = 'usertypename')
    {
        $query = $this->db->query("Select `usertype`.*
									from `usertype`
									where usertypeid ='" . $usertypeid . "' ");
        return $query->row[$name];
    }
    public function getTax($taxcode,$name = 'taxname')
    {
        $query = $this->db->query("Select `soft_tax`.*
									from `soft_tax`
									where taxcode ='" . $taxcode . "' ");
        return $query->row[$name];
    }
    
    public function getUnit($unitcode,$name = 'unitname')
    {
        $query = $this->db->query("Select `soft_unit`.*
									from `soft_unit`
									where unitcode ='" . $unitcode . "' ");
        return $query->row[$name];
    }
    public function getLocation($id,$name = 'locationname')
    {
        $query = $this->db->query("Select `location`.*
									from `location`
									where id ='" . $id . "' ");
        return $query->row[$name];
    }
    public function getAccount($accountid,$name = 'accountname',$languageid = '')
    {
        if($languageid == '')
            $languageid = $this->config->get('config_languageid');
        $query = $this->db->query("Select `soft_accounts`.*
									from `soft_accounts`
									where accountid ='" . $accountid . "' AND languageid = '".$languageid."'");
        return $query->row[$name];
    }
    public function getProduct($productcode,$name = 'model')
    {
        $query = $this->db->query("Select `product`.*
									from `product`
									where productcode ='" . $productcode . "'");
        return $query->row[$name];
    }
    public function getProductDes($productcode,$name = 'name',$languageid = '')
    {
        if($languageid == '')
            $languageid = $this->config->get('config_languageid');
        $query = $this->db->query("Select `product_description`.*
									from `product_description`
									where productcode ='" . $productcode . "' AND languageid = '".$languageid."'");
        return $query->row[$name];
    }
    public function getPaymentmethod($paymentmethodcode,$name = 'paymentmethod',$languageid = '')
    {
        if($languageid == '')
            $languageid = $this->config->get('config_languageid');
        $query = $this->db->query("Select `soft_paymentmethod`.*
									from `soft_paymentmethod`
									where paymentmethodcode ='" . $paymentmethodcode . "' AND languageid = '".$languageid."'");
        return $query->row[$name];
    }
    public function getCategory($categoryid,$name = 'categoryname',$languageid = '')
    {
        if($languageid == '')
            $languageid = $this->config->get('config_languageid');
        $query = $this->db->query("Select `category`.*
									from `category`
									where categoryid ='" . $categoryid . "' AND languageid = '".$languageid."'");
        return $query->row[$name];
    }
    public function getFixedassetType($id,$name = 'fixedassettype')
    {
        $query = $this->db->query("Select `soft_fixedassettype`.*
									from `soft_fixedassettype`
									where id ='" . $id . "'");
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
    public function getOrderType($ordertype)
    {
        if($ordertype == "CHK")
            return "Check Stock";
        $name = $this->importtype[$ordertype];
        if($name != '')
            return $name;
        $name = $this->exporttype[$ordertype];
        if($name != '')
            return $name;
        $name = $this->saletype[$ordertype];
        if($name != '')
            return $name;
    }
    public function calEndDate($startdate,$qty,$unitcode)
    {
        if($unitcode != 'month')
        {
            $unitex = $this->getUnit($unitcode,'unitex');
            if($unitex != 'month')
                return '';
            else
            {
                $exchange = $this->getUnit($unitcode,'exchange');
                $qty = $qty * $exchange;

            }
        }
        return $this->date->addmonth($startdate,$qty);
    }
    public function getDepreciationStraightLine($price,$nummonth,$targetprice,$targetmonth){
        $hprice = $price - $targetprice;
        if($nummonth >= $targetmonth){
            return $targetprice;
        }else{
            $blockamount = $hprice/$targetmonth;
            return $price - $blockamount*$nummonth;
        }
    }
    public function getDepreciationDecliningBalance($price,$nummonth,$rate){
        $newprice = $price;
        for($i=1;$i<=$nummonth;$i++){
            $newprice -= $newprice*$rate/100;
        }
        return $newprice;
    }
}