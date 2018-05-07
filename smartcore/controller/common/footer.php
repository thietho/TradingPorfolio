<?php

/**
 * Class ControllerCommonFooter
 *
 *
 */
class ControllerCommonFooter extends Controller
{
    public function index()
    {
        $this->template = "common/footer.tpl";
        $this->render();
    }
}