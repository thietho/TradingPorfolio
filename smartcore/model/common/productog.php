<?php

/**
 * @property Url $url
 * @property String string
 *
 */
class ProductOG extends aOpenGragh
{
    public function __construct($product) {
        //set page title
        if ($product['meta_title'] == "") {
            $this->metaTitle = $product['name'];
        } else {
            $this->metaTitle = $product['meta_title'];
        }

        //meta tag
        $this->metaDescription = $this->smartweb->sitemap['sitemap_description']['meta_description'] . " " . $product['meta_description'];
        $this->metaKeyword = $this->smartweb->sitemap['sitemap_description']['meta_keyword'] . " " . $product['meta_keyword'];

        //link
        $this->link = $this->url->getURL($product['seo_url'], 'product', $product['productid']);

        //OG
        $this->ogTitle = str_replace('"',"", htmlspecialchars_decode($product['name']));
        $this->ogUrl = $this->url->getURL($product['seo_url'], 'product', $product['productid']);
        $this->ogImage = DIR_USERIMAGE . "resize-220x220/" . rawurlencode($product['image']);
        $this->ogSummary = $product['summary'];
        $this->ogDescription = $this->string->getTextLength($product['description'], 0, 100);
        $this->ogPublicdate = str_replace("-", "/", $product['date_added']);
        $this->ogRevisiondate = str_replace("-", "/", $product['date_modified']);
    }
}