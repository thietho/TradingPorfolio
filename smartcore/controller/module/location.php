<?php

/**
 * Class ControllerModuleLocation
 * @property ModelModuleLocation model_module_location
 *
 */
class ControllerModuleLocation extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("module/location");
        $this->data['locations'] = array();
        $this->model_module_location->getTree(0,$this->data['locations']);
        foreach ($this->data['locations'] as $key => $location) {
            $this->data['locations'][$key]['locationname'] = $this->model_module_location->showPath($location['id']);
        }
    }

    public function index()
    {
        $this->getList();
    }

    public function getList()
    {
        $this->template = "module/location_list.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if ($type == 'popup')
            $this->layout = "";
        $this->render();

    }

    public function loadData()
    {
        $this->template = "module/location_table.tpl";
        $this->render();
    }

    private function getForm()
    {
        $id = $this->request->get['id'];
        $parent = (int)$this->request->get['parent'];
        if ($id) {
            $this->data['item'] = $this->model_module_location->getItem($id);
        }
        else{
            $this->data['item']['parent'] = $parent;
            $this->data['item']['sortorder'] = $this->model_module_location->getNextSortOrder($parent);
        }

        $this->template = "module/location_form.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if ($type == 'popup')
            $this->layout = "";
        $this->render();
    }

    public function getLocation()
    {
        $id = $this->request->get['id'];
        $data = $this->model_module_location->getItem($id);
        $data['locationtext'] = $this->model_module_location->showPath($id);
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function insert()
    {
        $this->getForm();
    }

    public function update()
    {
        $this->getForm();
    }

    public function delete()
    {
        $id = $this->request->get['id'];

        $this->model_module_location->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $data['shipfee'] = $this->string->toNumber($data['shipfee']);
            $data['shipfeeorder'] = $this->string->toNumber($data['shipfeeorder']);
            $data['freeshiporder'] = $this->string->toNumber($data['freeshiporder']);
            $data['id'] = $this->model_module_location->save($data);
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

        if ("" == $data['locationname']) {
			$this->errors['locationname'] = "Location Name not empty";
		}

		

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
}