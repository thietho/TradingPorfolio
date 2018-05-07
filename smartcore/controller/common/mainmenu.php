<?php

/**
 * Class ControllerCommonMainmenu
 *
 * @property ModelCoreSitemap $model_core_sitemap
 * @property Common common
 *
 */
class ControllerCommonMainmenu extends Controller
{
    public function index()
    {
        $this->template = "common/mainmenu.tpl";
        $this->render();
    }
}