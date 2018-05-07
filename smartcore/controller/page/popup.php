<?php

/**
 * Class ControllerPagePrint
 *
 *
 */
class ControllerPagePopup extends Controller
{
    public function index()
    {



        $this->template = "page/popup.tpl";
        $this->render();
    }
}