<?php

/**
 * Class ControllerCoreBackup
 *
 * @property ModelCoreUser model_core_user
 * @property ModelCoreUsertype model_core_usertype
 *
 */
class ControllerCoreBackup extends Controller
{

    public function index()
    {


        $this->template = "core/createmodule.tpl";
        $this->layout = "page/home";
        $this->render();
    }
}
?>