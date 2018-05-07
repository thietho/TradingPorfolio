<?php

/**
 * Created by PhpStorm.
 * User: phqdung
 * Date: 6/19/14
 * Time: 11:26 AM
 *
 * @property Url $url
 * @property String $string
 * @property Sitemap $sitemap
 * @property Config $config
 *
 */
class SitemapOG extends aOpenGragh
{
    public function __construct($sitemap) {
        //page title
        if ($sitemap['sitemap_description']['meta_title'] == "") {
            $this->metaTitle = $sitemap['sitemap_description']['sitemapname'];
        } else {
            $this->metaTitle = $sitemap['sitemap_description']['meta_title'];
        }

        //meta tag
        $this->metaDescription = $sitemap['sitemap_description']['meta_description'];
        $this->metaKeywords = $sitemap['sitemap_description']['meta_keyword'];

        //link
        $this->link = $this->url->getURL($sitemap['sitemap_description']['seo_url'], 'sitemap', $sitemap['sitemapid']);

        //OG
        $this->ogTitle = str_replace('"', "", htmlspecialchars_decode($sitemap['sitemap_description']['sitemapname']));

        if($sitemap['layoutid'] == 'home') {
            $this->ogUrl = ROOT_HTTP_SERVER;
        } else {
            $this->ogUrl = $this->url->getURL($sitemap['sitemap_description']['seo_url'], 'sitemap', $sitemap['sitemapid']);
        }
        $this->ogImage = DIR_USERIMAGE . "resize-220x220/" . rawurlencode($this->config->get('config_logo'));
        $this->ogSummary = $sitemap['sitemap_description']['summary'];
        $this->ogDescription = $this->string->getTextLength($sitemap['sitemap_description']['description'], 0, 100);
        $this->ogPublicdate = "";
        $this->ogRevisiondate = "";
    }
}