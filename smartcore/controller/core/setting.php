<?php

/**
 * Class ControllerCoreSetting
 *
 * @property ModelCoreSetting model_core_setting
 * @property ModelModuleCard model_module_card

 *
 */
class ControllerCoreSetting extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;
    private $setting = array();
    function __construct()
    {
        $this->load->model("module/card");

        $this->load->model("core/setting");
        $this->setting = $this->model_core_setting->getSettingInfo();

    }

    public function index()
    {
        if(!$this->user->checkPermission('settingEdit'))
            $this->response->redirect("?route=core/permission&code=settingEdit");
        $data = $this->model_core_setting->getList();
        $this->data['item'] = array();
        foreach ($data as $item){
            $this->data['item'][$item['settingcode']] = $item['settingvalue'];
        }
        $this->data['item']['version'] = $this->setting['version'];
        $this->data['item']['currentfinancialyearend'] = $this->setting['monthfinanacial']."-".$this->date->getYear($this->date->getToday());
        $this->data['item']['lockedperiod'] = "01-".($this->setting['monthfinanacial']+1)."-".$this->date->getYear($this->date->getToday());
        $datasize = $this->model_core_setting->getDataBaseSize();
        //print_r($datasize);
        $folder = "../";
        //$filesize = $this->model_core_setting->foldersize($folder);
        //echo $filesize/1024/1024;
        $this->data['item']['storageused'] = $this->string->numberFormate($datasize['datasizemb'] + $filesize/1024/1024);
        $this->data['item']['userlimt'] = $this->setting['userlimt'];
        $this->data['item']['stocklimt'] = $this->setting['stocklimt'];

        $where = " AND account <> '' AND cardtype = 'staff'";
        $datacard = $this->model_module_card->getList($where);
        $this->data['item']['countuser'] = count($datacard);

        $this->template = "core/setting.tpl";
        $this->layout = "page/home";
        $this->render();
    }
    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            foreach ($data as $code => $value){
                $setting['settingcode'] = $code;
                $setting['settingvalue'] = $value;
                $this->model_core_setting->save($setting);
            }
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


        if ("" == $data['companyname']) {
            $this->errors['companyname'] = "Company Name not empty";
        }



        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
}