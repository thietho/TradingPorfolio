<?php

/**
 * Class ControllerModuleImport

 *
 */
class ControllerCommonDashboard extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {

    }

    public function index()
    {

        $this->template = "common/dashboard.tpl";
        $this->layout = "page/home";
        $this->render();
    }

}