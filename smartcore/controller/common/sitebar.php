<?php

/**
 * Class ControllerCommonSitebar
 *
 * @property ModelFmraRegion model_fmra_region
 * @property Common common
 *
 */
class ControllerCommonSitebar extends Controller
{
    public function index()
    {
        $this->template = "common/sitebar.tpl";
        $this->render();
    }
}