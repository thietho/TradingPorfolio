<?php

/**
 * Class ControllerPageHome
 *
 *
 */
class ControllerPageHome extends Controller
{
    public function index()
    {

        $this->data['header'] = $this->load->controller("common/header");
        $this->data['footer'] = $this->load->controller("common/footer");
        //$this->data['mainmenu'] = $this->load->controller("common/mainmenu");

        $this->data['sitebar'] = $this->load->controller("common/sitebar");

        //javascript in each tpl file
        $this->data['pageScripts'] = $this->document->getPageScripts();
        $this->data['pageStyles'] = $this->document->getPageStyles();
        $this->data['layoutid'] = $this->smartweb->layoutid;

        $this->template = "page/base.tpl";
        $this->render();
    }
}