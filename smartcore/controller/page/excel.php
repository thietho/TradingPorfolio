<?php

/**
 * Class ControllerPageExcel
 *
 *
 */
class ControllerPageExcel extends Controller
{
    public function index()
    {
        $this->template = "page/excel.tpl";
        $this->render();
    }
}