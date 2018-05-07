<?php
class OpenGraphFactory {

    /**
     * @param $ogType [string] each of values ("media", sitemap, product)
     * @param $data [object] object media, sitemap, product
     * @return object of aOpenGraph type
     */
    public static function getInstance($ogType, $data)
    {
        if ($ogType == 'sitemap') {
            return new SitemapOG($data);
        } elseif ($ogType == 'media') {
            return new MediaOG($data);
        } elseif ($ogType == 'product') {
            return new ProductOG($data);
        } elseif ($ogType == 'manufacturer') {
            return new ManufacturerOG($data);
        } else {
            return null;
        }
    }
}