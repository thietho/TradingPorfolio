<?php

/**
 * Class ControllerCodeProfile
 * @property ModelModuleCard model_module_card

 * @property ModelModuleCardlocation model_module_cardlocation

 * @property ModelCoreUserType model_core_usertype
 * @property ModelCoreUser model_core_user

 * @property ModelCoreSetting model_core_setting
 *
 */
class ControllerCoreProfile extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;
    private $setting = array();
    function __construct()
    {
        $this->load->model("module/card");
        $this->load->model("module/order");
        $this->load->model("module/cardlocation");
        $this->load->model("core/usertype");
        $this->load->model("core/user");
        $this->load->model("core/setting");
        $this->setting = $this->model_core_setting->getSettingInfo();
    }

    public function index()
    {
        $this->getForm();
    }
    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_module_card->getItem($id);
        }

        $this->template = "core/profile.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if ($type == 'popup')
            $this->layout = "";
        $this->render();
    }


    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $id = $data['id'];
            $data['fullname'] = $data['lastname']." ".$data['firstname'];
            $data['birthdate'] = $this->date->formatViewDate($data['birthdate']);
            if($data['cardid'] == "")
                $data['cardid'] = "C".time();
            $data['id'] = $this->model_module_card->save($data);
            if($id == '')
            {
                if($data['image'] != "")
                {
                    //Move file vo dung thu muc
                    $oldname = DIR_FILE.$data['image'];
                    $file = pathinfo($oldname);
                    $path = DIR_FILE."upload/card/".$data['cardid'];
                    if(!is_dir($path))
                        mkdir($path);
                    $newfile = $path."/".$file['basename'];
                    rename($oldname,$newfile);
                    rmdir($file['dirname']);
                    $newfile = str_replace(DIR_FILE,'',$newfile);
                    $this->model_module_card->updateCol($data['id'],'image',$newfile);
                }

            }
            //Them dia chi giao hang mac dinh
            $where = " AND cardid like '".$data['cardid']."' AND locationname like 'Default'";
            $dataLocations = $this->model_module_cardlocation->getList($where);
            if(count($dataLocations))
            {
                $location = $dataLocations[0];
            }
            $location['cardid'] = $data['cardid'];
            $location['locationname'] = "Default";
            $location['contactname'] = $data['fullname'];
            $location['phone'] = $data['telephone'];
            $location['email'] = $data['email'];
            $location['addressline1'] = $data['addressline1'];
            $location['addressline2'] = $data['addressline2'];
            $location['city'] = $data['city'];
            $location['country'] = $data['country'];
            $location['postcode'] = $data['postcode'];
            $this->model_module_cardlocation->save($location);

            $data['errors'] = array();
            $data['errorstext'] = '';

        } else {
            $data['errors'] = $this->errors;
            $data['errorstext'] = '';
            foreach ($this->errors as $error) {
                $data['errorstext'] .= $error . "<br>";
            }
        }
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }

    private function validate($data)
    {
        $this->errors = array();
        if ("" == $data['firstname']) {
            $this->errors['firstname'] = "Firstname not empty";
        }
        if ("" == $data['lastname']) {
            $this->errors['lastname'] = "Lastname not empty";
        }

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }


}