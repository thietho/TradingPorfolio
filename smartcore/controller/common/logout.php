<?php

/**
 * Class ControllerCommonFooter
 *
 *
 * @property User user
 */
class ControllerCommonLogout extends Controller
{
    public function __construct() {

    }

    public function index()
    {
        $this->user->logout();

        $this->template = "common/logout.tpl";
        $this->render();
    }
}