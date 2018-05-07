<?php
final class Smartweb {
    public $sitemap = array();
    public $object = array();
    public $allsitemap = array();
    public $allmainmenus = array();

    //Load web page
    public $rootsitemapid = "";
    public $moduleroute = "";
    public $sitemapid = "";
    public $objectid = "";
    public $weburl = "";

    //Cai dat cho 1 web page
    public $breadcrumbs = '';
    public $route = '';
    public $layoutid = '';
    public $layouttype = '';
    public $sidebar_left = '';
    public $sidebar_right = '';
    public $splash = '';
    public $dashboard = '';

    //og variables
    public $og_site_name = '';
    public $og_type = '';
    public $og_title = '';
    public $og_url = '';
    public $og_image = '';
    public $og_description = '';
    public $og_publicdate = '';
    public $og_revisiondate = '';

    //Setting
    public $settings = array();
    public $webcounter = 0;

    public function __construct()
    {
        $this->db = Registry::get('db');
        $this->language = Registry::get('language');
        $this->config = Registry::get('config');


        /*
        if($this->config->get("config_visitors_summary")) {
            //get setting from setting.json
            $this->getSetting();

            $onlinevisitors = $this->countVisitorsOnline();
            $this->config->set('config_countonlinevisitors', $onlinevisitors);

            //save setting
            $this->saveSetting();
        }
        */

    }

    
    //SEO_URL common functions
    public function getSEOURL($seourl, $where = "")
    {
        $query = $this->db->query("Select *
									from `url_alias` 
									where languageid = '". $this->config->get('config_languageid') . "' AND keyword ='".$seourl."' ".$where);
        $result = $query->row;
        if(count($result) == 0) {
            $query = $this->db->query("Select *
									from `url_alias` 
									where keyword ='".$seourl."' " . $where);
            return $query->row;
        } else {
            return $result;
        }
    }

    public function checkSEOURL($seo_url, $object, $id, $languageid)
    {
        if($seo_url != "")
        {
            $sql="SELECT * FROM url_alias WHERE keyword = '" .$seo_url . "' AND languageid = '".$languageid."'";
            $query = $this->db->query($sql);
            $data = $query->rows;
            $count = count($data);
            if($count > 0){
                if($count > 1)
                {
                    if ($count == 2 && $object == 'sitemap') {

                        $mediaid = "";
                        foreach($data as $url_alias) {
                            if ($url_alias['object'] == "media") {
                                $mediaid = $url_alias['value'];
                            }
                        }
                        $sqlMedia="SELECT * FROM media WHERE mediaid = '" . $mediaid . "' AND languageid = '".$languageid."'";
                        $queryMedia = $this->db->query($sqlMedia);
                        $media = $queryMedia->row;

                        if (count($media) > 0) {
                            if ($media['sitemapid'] == $id) {
                                return true;
                            }
                        }
                    }
                    return false;
                }
                else
                {
                    $data = $query->row;
                    if($data['object'] == $object && $data['value'] == $id)
                    {
                        return true;
                    } else if ($object == "sitemap") {

                        $mediaid = $data['value'];
                        $sqlMedia="SELECT * FROM media WHERE mediaid = '" . $mediaid . "' AND languageid = '".$languageid."'";
                        $queryMedia = $this->db->query($sqlMedia);
                        $media = $queryMedia->row;

                        if (count($media) > 0) {
                            if ($media['sitemapid'] == $id) {
                                return true;
                            }
                        }

                    }
                    else
                    {
                        return false;
                    }
                }

            }else{
                return true;
            }
        }
        else
        {
            return true;
        }
        return false;
    }

    public function saveSEOURL($seo_url, $object, $id, $languageid)
    {
        $object = $this->db->escape($object);
        $value = $this->db->escape($id);
        $keyword = $this->db->escape($seo_url);
        $languageid = $this->db->escape($languageid);

        $fields = array(
			'object',
			'value',
			'keyword',
			'languageid',
        );
        $values = array(
            $object,
            $value,
            $keyword,
            $languageid
        );

        $sql="SELECT * FROM url_alias WHERE object = '" .$object . "' AND value = '".$value."' AND languageid = '".$languageid."' ";
        $query = $this->db->query($sql);
        if(count($query->rows) > 0)
        {
            $where="object = '".$object."' AND `value` = '".$id."' AND `languageid` = '".$languageid."'";
            $this->db->updateData("url_alias",$fields,$values,$where);
        }
        else
        {
            $this->db->insertData("url_alias",$fields,$values);
        }
    }

    public function deleteList($object, $values) {
        $where = " WHERE `object` = '". $object ."' AND `value` IN ('" . implode("','", $values) . "')";
        $sql = "DELETE FROM url_alias " . $where;
        $this->db->query($sql);
    }

    public function deleteSEOURL($object, $id, $languageid = "")
    {
        if($languageid == '') {
            $sql = "DELETE FROM url_alias where `object` = '".$object."' AND `value` = '".$id."' ";
        } else {
            $sql = "DELETE FROM url_alias where `object` = '".$object."' AND `value` = '".$id."' AND `languageid` = '".$languageid."' ";
        }

        $this->db->query($sql);
    }

    public function deleteURL_ALIAS($seo_url, $languageid = "") {
        if($languageid == '') {
            $sql = "DELETE FROM url_alias where `keyword` = '".$seo_url."'";
        } else {
            $sql = "DELETE FROM url_alias where `keyword` = '".$seo_url."' AND `languageid` = '".$languageid."' ";
        }
        $this->db->query($sql);
    }

    
    //set OG Facebook
    public function setOG($title = '', $url = '', $image = '', $summary = '', $description = '', $publicdate = '', $revisiondate = ''){
        $this->og_title = $title;
        $this->og_url = $url;
        $this->og_image = $image;
        $this->og_description = trim($summary) != "" ? strip_tags($summary) : strip_tags($description);
        $this->og_publicdate = $publicdate;
        $this->og_revisiondate = $revisiondate;
    }

}