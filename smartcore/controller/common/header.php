<?php

/**
 * Class ControllerCommonHeader
 * @property ModelCoreUser model_core_user
 * @property ModelModuleStore model_module_store
 * @property ModelModuleCardstore model_module_cardstore
 * @property User user
 *
 */
class ControllerCommonHeader extends Controller
{
    public function __construct() {
        //load language
        $this->load->model("core/user");

    }

    public function index()
    {

        $card = $this->user->card;


        $this->data['storeinfo'] = $this->user->store;
        //print_r($this->data['storeinfo']);
        //process owner data
        $this->data['logo'] = $this->config->get('config_logo');
        $this->data['user'] = $this->model_core_user->getItemByUserName($this->user->getId());
        $this->data['card'] = $card;

        //render html
        $this->template = "common/header.tpl";
        $this->render();
    }
    public function chosestore()
    {
        $storeid = $this->request->get['storeid'];
        $store = $this->model_module_store->getItem($storeid);
        $this->user->setStore($store);
        $this->template = "common/output.tpl";
        $this->render();
    }
}