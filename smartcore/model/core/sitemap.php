<?php

/**
 * Class ModelCoreSitemap
 *
 * property DB db
 * property Document document
 * property Config config
 * property Smartweb smartweb
 *
 */
class ModelCoreSitemap extends Model
{
    public function countTotal($where = "") {
        $query = $this->db->query("Select count(sitemapid) as total
                                    from sitemap
                                    where 1= 1 $where");
        return $query->row['total'];
    }

    public function getItem($sitemapid, $where = "")
    {
        $sql = "Select sitemap.*, sd.sitemapname, sd.description, sd.seo_url, sd.meta_description, sd.meta_keyword, m.modulename
                                    from `sitemap`
                                    LEFT JOIN `sitemap_description` sd ON (sitemap.sitemapid = sd.sitemapid AND sd.languageid = '" . $this->config->get('config_languageid') . "')
                                    LEFT JOIN `module` m ON (sitemap.moduleid = m.moduleid)
                                    where sitemap.sitemapid='" . $sitemapid . "' " . $where;
        $query = $this->db->query($sql);
        return $query->row;
    }

    public function getDescription($sitemapid, $languageid = '')
    {
        if ($languageid != '') {
            $query = $this->db->query("Select sitemap_description.*
                                    from `sitemap_description` 
                                    where sitemapid='" . $sitemapid . "' AND languageid = '" . $languageid . "'
                                    ");
            return $query->row;
        } else {
            $query = $this->db->query("Select sitemap_description.*
                                    from `sitemap_description`
                                    where sitemapid=" . $sitemapid);
            return $query->rows;
        }
    }

    public function getList($where = "")
    {
        $sql = "Select sitemap.*, sd.sitemapname, sd.description, sd.seo_url, sd.meta_description, sd.meta_keyword, m.modulename
                                    from `sitemap`
                                    LEFT JOIN `sitemap_description` sd ON (sitemap.sitemapid = sd.sitemapid AND sd.languageid = '" . $this->config->get('config_languageid') . "')
                                    LEFT JOIN `module` m ON (sitemap.moduleid = m.moduleid)
                                    where 1 = 1 " . $where . " ORDER BY sitemap.sitemapparent, position ASC, sitemapid";
        $query = $this->db->query($sql);
        return $query->rows;
    }


    
    public function renderTreeView($parentid, &$data, $class = "", $indentwidth = 15, $indenttext = "", $prefix = "&nbsp;")
    {
        $this->renderTreeLevel($parentid, $data, $class, $indentwidth, $indenttext, $prefix);
        
        $position = array();
        $treelevel = array();
        foreach ($data as $key => $row) {
            $position[$key] = $row['position'];
            $treelevel[$key] = $row['treelevel'];
        }
        array_multisort($treelevel, SORT_ASC, $position, SORT_ASC, $data);
    }

    private function getStringLevel($treelevel, $index) {
        $level = $treelevel . "-";
        if ($index >= 10 && $index < 100) {
            $level .= "a$index";
        } else if ($index >= 100) {
            $level .= "b$index";
        } else {
            $level .= $index;
        }
        return $level;
    }

    private function renderTreeLevel($parentid, &$data, $class, $indentwidth, $indenttext, $prefix, $treelevel = 0)
    {
        $index = 0;
        $dataSize = count($data);
        for ($i = 0; $i < $dataSize; $i++) {
            if ($data[$i]['sitemapparent'] == $parentid) {
                $index++;

                $data[$i]['treelevel'] = $this->getStringLevel($treelevel, (int)$index);
                $data[$i]['treetext'] = $this->getTreePrefix($prefix, $indentwidth, $indenttext, $class, $data[$i]['treelevel']) . $data[$i]['sitemapname'];

                $arrLevel = explode("-", $treelevel);
                $deep = count($arrLevel) - 2;
                $data[$i]['treedeep'] = $deep;

                $this->renderTreeLevel($data[$i]['sitemapid'], $data, $class, $indentwidth, $indenttext, $prefix, $data[$i]['treelevel']);
            } else {
                if ($data[$i]['treelevel'] == "") {
                    $data[$i]['treelevel'] = 9999;
                }
                if ($data[$i]['weight'] == 0) {
                    $data[$i]['weight'] = 9999;
                }

            }
        }
    }

    private function getTreePrefix($prefix, $indentwidth, $indenttext, $class, $treelevel)
    {
        $arrLevel = explode("-", $treelevel);
        $deep = count($arrLevel) - 2;

        $indentwidth = (int)$indentwidth * $deep;
        $str_indenttext = "";
        for ($i = 0; $i < $deep; $i++) {
            $str_indenttext .= $indenttext;
        }
        return $str_indenttext . '<span class="treeindent ' . $class . '" style="margin-left:' . $indentwidth . 'px">' . $prefix . '</span>';
        //return $str_indenttext;
    }

    public function nextPosition($parentid)
    {
        $sql = "Select max(position) as max From sitemap where sitemapparent='" . $parentid . "' Order By position";
        $query = $this->db->query($sql);
        return $query->rows[0]['max'] + 1;
    }


    public function getListByParent($parentid, $status = "")
    {
        $where = " AND sitemapparent = '" . $parentid . "' ";
        if ($status != "") {
            $where .= " AND `sitemap`.status = '" . $status . "' ";
        }
        return $this->getList($where);
    }

    public function getListByModule($moduleid)
    {
        $where = " AND `sitemap`.moduleid = '" . $moduleid . "'";
        return $this->getList($where);
    }

    public function getPath($sitemapid)
    {
        $data_sitemap = array();
        if($sitemapid !='')
        {
            $sitemap = $this->getItem($sitemapid);
            while(count($sitemap))
            {
                $data_sitemap[] = $sitemap;
                $sitemap = $this->getItem($sitemap['sitemapparent']);
            }
            $data = array();
            for($i = count($data_sitemap) - 1 ; $i>=0 ; $i--)
                $data[] = $data_sitemap[$i];
            return $data;
        }
        return $data_sitemap;

    }

    
    public function save($data)
    {
        $row = $data['sitemap'];
        $sitemapid = $this->db->escape($row['sitemapid']);
        $siteid = SITEID;
        $sitemapparent = $this->db->escape($row['sitemapparent']);
        $position = (int)$row['position'];
        if ($position == "") {
            $position = $this->nextPosition($sitemapparent);
        }
        $moduleid = $this->db->escape($row['moduleid']);
        $imageid = (int)$row['imageid'];
        $imagepath = $this->db->escape($row['imagepath']);
        $hyperlink = $this->db->escape($row['hyperlink']);
        $top_mainmenu = (int)$row['top_mainmenu'];
        $top_footermenu = (int)$row['top_footermenu'];
        $layoutid = $this->db->escape($row['layoutid']);
        $status = (int)$row['status'];

        $field = array(
            "sitemapid", "siteid", "sitemapparent", "position", "moduleid", "imageid", "imagepath", "hyperlink", "top_mainmenu", "top_footermenu", "layoutid", "status"
        );
        $value = array(
            $sitemapid, $siteid, $sitemapparent, $position, $moduleid, $imageid, $imagepath, $hyperlink, $top_mainmenu, $top_footermenu, $layoutid, $status
        );
        if ($sitemapid == "") {
            $sitemapid = $this->db->insertData("sitemap", $field, $value);
        } else {
            $where = " sitemapid = '" . $sitemapid . "'";
            $this->db->updateData('sitemap', $field, $value, $where);
        }
        //Save description
        foreach ($this->document->getLanguage() as $key => $value) {
            $row = $data['sitemap'][$key];
            $languageid = $key;
            $sitemapname = $this->db->escape($row['sitemapname']);
            $description = $this->db->escape($row['description']);
            $tag = $this->db->escape($row['tag']);
            $meta_title = $this->db->escape($row['meta_title']);
            $meta_description = $this->db->escape($row['meta_description']);
            $meta_keyword = $this->db->escape($row['meta_keyword']);
            $seo_url = $this->db->escape($row['seo_url']);

            $og_title = $this->db->escape($row['og_title']);
            $og_description = $this->db->escape($row['og_description']);
            $og_image = $this->db->escape($row['og_image']);

            $field = array(
                "sitemapid", "languageid", "sitemapname", "description", "tag", "meta_title",
                "meta_description", "meta_keyword", "seo_url",
                "og_title", "og_description", "og_image"
            );
            $value = array(
                $sitemapid, $languageid, $sitemapname, $description, $tag, $meta_title,
                $meta_description, $meta_keyword, $seo_url,
                $og_title, $og_description, $og_image
            );

            $this->db->query("DELETE FROM sitemap_description where sitemapid = '" . $sitemapid . "' AND languageid = '" . $key . "'");
            $this->db->insertData("sitemap_description", $field, $value);
        }
        $this->clearCache();

        return $sitemapid;
    }

    private function clearCache()
    {
        //clear cms cache
        $arr_sitemap_smart = glob(DIR_CACHE . 'cache.*');
        if(is_array($arr_sitemap_smart)) {
            foreach ($arr_sitemap_smart as $file) {
                unlink($file);
            }
        }

        $arr_cachehtml = glob(DIR_CACHE . 'cachehtml.*');
        if(is_array($arr_cachehtml)) {
            foreach ($arr_cachehtml as $file) {
                unlink($file);
            }
        }

        //clear web cache
        if(defined('DIR_WEB_CACHE')) {
            $arr_sitemap_smart = glob(DIR_WEB_CACHE . 'cache.*');
            if(is_array($arr_sitemap_smart)) {
                foreach ($arr_sitemap_smart as $file) {
                    unlink($file);
                }
            }

            $arr_cachehtml = glob(DIR_WEB_CACHE . 'cachehtml.*');
            if(is_array($arr_cachehtml)) {
                foreach ($arr_cachehtml as $file) {
                    unlink($file);
                }
            }
        }
    }

    public function updateSiteMapPosition($sitemapid, $position)
    {
        $field = array(
            "position"
        );
        $value = array(
            $position
        );
        $where = "sitemapid = " . $sitemapid;
        $this->db->updateData('sitemap', $field, $value, $where);
    }

    public function  updateSiteMapPositions($positions) {
        $sitemapids = array_keys($positions);
        $where_sitemap = implode(",", $sitemapids);
        $sql = "UPDATE sitemap";
        $sql .= " SET position = CASE ";
        foreach ($positions as $key => $val) {
            $sql .= " WHEN sitemapid = " . $key . " THEN " . $val;
        }
        $sql .= " END ";
        $sql .= "WHERE sitemapid IN (" . $where_sitemap . ")";

        $this->db->query($sql);
        $this->clearCache();
    }


    public function deleteSiteMap($sitemapid)
    {
        if (count($this->getListByParent($sitemapid)) == 0) {

            //get sitemap
            /*
            $where = "SELECT *
                      FROM sitemap_description
                      WHERE sitemapid = '" . $sitemapid . "'";
            $query = $this->db->query($where);
            $sitemap_description = $query->row;
            */
            $where = "sitemapid = '" . $sitemapid . "'";
            $this->db->deleteData('sitemap', $where);
            $this->db->deleteData('sitemap_description', $where);


            $this->smartweb->deleteSEOURL("sitemap", $sitemapid);
            //$this->smartweb->deleteURL_ALIAS($sitemap_description['seo_url']);

            return true;
        } else {
            return false;
        }
    }



}