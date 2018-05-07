<?php

/**
 * Class ControllerCommonFooter
 *
 *
 */
class ControllerErrorNotFound extends Controller
{
    public function index()
    {
        $this->load->language("error/not_found_module");

        $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

        $this->template = "error/not_found.tpl";
        $this->render();
    }
}