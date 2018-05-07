<?php
class ControllerCorePermission extends Controller
{
    private $errors = array();
    private $itemsPerPage = 12;



    public function index()
    {
        /*$code = $this->request->get['code'];
        $data = $this->document->loadDataPermission();
        $datamodule = array();
        foreach($data as $modules)
        {
            foreach($modules as $module)
            {
                print_r($module);
            }
                //$datamodule[$module['moduleid']] = $module['modulename'];
        }*/

        //$this->data['modulename'] = $datamodule[$code];
        $this->template = "core/permission.tpl";
        $this->layout = "page/home";
        $this->render();
    }
}