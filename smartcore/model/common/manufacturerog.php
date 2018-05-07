<?php
/**
 * Created by PhpStorm.
 * User: phqdung
 * Date: 6/19/14
 * Time: 11:26 AM
 *
 * Class ManufacturerOG
 *
 *
 *
 *
 */
class ManufacturerOG extends aOpenGragh
{
    public function __construct($manufacturer) {
        //set page title
        $this->document->setTitle($manufacturer['name']);

        //meta tag
        $meta_description = $this->smartweb->sitemap['sitemap_description']['meta_description'] . " " . $manufacturer['meta_description'];
        $this->document->setDescription($meta_description);
        $meta_keywords = $this->smartweb->sitemap['sitemap_description']['meta_keyword'] . " " . $manufacturer['meta_keyword'];
        $this->document->setKeywords($meta_keywords);

        //link
        $this->document->addLink(HTTP_WEB . $this->smartweb->sitemap['seo_url'] . 'html?manufacturerID=' . $this->smartweb->objectid);

        //OG
        $this->og_title = str_replace('"', "", htmlspecialchars_decode($manufacturer['name']));
        $this->og_url = HTTP_WEB . $this->smartweb->sitemap['seo_url'] . 'html?manufacturerID=' . $this->smartweb->objectid;
        $this->og_image = DIR_USERIMAGE . "resize-220x220/" . rawurlencode($manufacturer['image']);
        $this->og_summary = $manufacturer['summary'];
        $this->og_description = $manufacturer['meta_description'];
        $this->og_publicdate = '';
        $this->og_revisiondate = '';
    }
}