<?php

/**
 * Created by PhpStorm.
 * User: phqdung
 * Date: 6/19/14
 * Time: 11:34 AM
 *
 * Class AOpenGraph
 * @property Document document
 * @property Smartweb smartweb
 *
 */
abstract class aOpenGragh
{
    public $metaTitle;
    public $metaDescription;
    public $metaKeyword;
    public $link;
    public $ogTitle;
    public $ogUrl;
    public $ogImage;
    public $ogSummary;
    public $ogDescription;
    public $ogPublicDate;
    public $ogRevisionDate;

    public function __get($key)
    {
        return Registry::get($key);
    }

    public function __set($key, $value)
    {
        Registry::set($key, $value);
    }

    public function addOpenGragh()
    {
        //set page title
        $this->document->setTitle($this->metaTitle);

        //meta tag
        $this->document->setDescription($this->metaDescription);
        $this->document->setKeywords($this->metaKeyword);

        //link
        $this->document->addLink($this->link);

        //OG
        $this->smartweb->setOG(
            $this->ogTitle,
            $this->ogUrl,
            $this->ogImage,
            $this->ogSummary,
            $this->ogDescription,
            $this->ogPublicDate,
            $this->ogRevisionDate);

    }
}