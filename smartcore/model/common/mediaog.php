<?php
/**
 * Created by PhpStorm.
 * User: phqdung
 * Date: 6/19/14
 * Time: 11:26 AM
 *
 * @property Url $url
 * @property String $string
 *
 */
class MediaOG extends aOpenGragh
{
    public function __construct($media) {
        //set page title
        if ($media['meta_title'] == "") {
            $this->metaTitle = $media['title'];
        } else {
            $this->metaTitle = $media['meta_title'];
        }

        //meta tag
        $this->metaDescription = $this->smartweb->sitemap['sitemap_description']['meta_description'] . " " . $media['metadescription'];
        $this->metaKeyword = $this->smartweb->sitemap['sitemap_description']['meta_keyword'] . " " . $media['metakeyword'];

        //link
        $this->link = $this->url->getURL($media['alias'], 'media', $media['mediaid']);

        //OG
        $this->ogTitle = str_replace('"', "", htmlspecialchars_decode($media['title']));
        $this->ogUrl = $this->url->getURL($media['alias'], 'media', $media['mediaid']);
        $this->ogImage = DIR_USERIMAGE . "resize-220x220/" . rawurlencode($media['imagepath']);
        $this->ogSummary = $media['summary'];
        $this->ogDescription = $this->string->getTextLength($media['description'], 0, 100);
        $this->ogPublicdate = str_replace("-", "/", $media['statusdate']);
        $this->ogRevisiondate = str_replace("-", "/", $media['updateddate']);
    }
}