<?php

/**
 * Class ControllerPagePrint
 *
 *
 */
class ControllerPagePrint extends Controller
{
    public function index()
    {
        $this->template = "page/print.tpl";
        $this->render();
    }
}