<?php

final class Url
{
    public function http($route)
    {
        return HTTP_SERVER . 'index.php?route=' . str_replace('&', '&amp;', $route);
    }

    public function https($route)
    {
        if (HTTPS_SERVER != '') {
            $link = HTTPS_SERVER . 'index.php?route=' . str_replace('&', '&amp;', $route);
        } else {
            $link = HTTP_SERVER . 'index.php?route=' . str_replace('&', '&amp;', $route);
        }

        return $link;
    }

    public function getURL($seo_url, $object = "", $id = "")
    {
        if ($seo_url != "") {
            return HTTP_WEB . $seo_url . ".html";
        } else {
            if ($object != "") {
                return HTTP_WEB . htmlentities("?obj=" . $object . "&id=" . $id);
            } else {
                return HTTP_WEB;
            }
        }
    }

    public function getSitemapURL($url, $seo_url, $object = "", $id = "")
    {
        if ($seo_url != "") {
            return $url . $seo_url . ".html";
        } else {
            if ($object != "") {
                return $url . htmlentities("?obj=" . $object . "&id=" . $id);
            } else {
                return $url;
            }
        }
    }
}