<?php

/**
 * Class ControllerCoreModule
 * @property ModelCoreModule model_core_module
 *
 */
class ControllerCoreModule extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("core/module");
        $this->data['modules'] = array();
        $this->model_core_module->getTree(0,$this->data['modules']);
    }

    public function index()
    {
        $this->getList();
    }

    public function getList()
    {
        $this->template = "core/module_list.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if ($type == 'popup')
            $this->layout = "";
        $this->render();

    }

    public function loadData()
    {
        $this->template = "core/module_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        $parent = $this->request->get['parent'];
        if ($id) {
            $this->data['item'] = $this->model_core_module->getItem($id);
        }else{
            $this->data['item']['moduleparent'] = $parent;
            $this->data['item']['position'] = $this->model_core_module->getNextPos($parent);

        }

        $this->template = "core/module_form.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if ($type == 'popup')
            $this->layout = "";
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

        $this->model_core_module->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $data['id'] = $this->model_core_module->save($data);
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

        if ("" == $data['moduleid']) {
			$this->errors['moduleid'] = "Module Id not empty";
		}
		if ("" == $data['modulename']) {
			$this->errors['modulename'] = "Module Name not empty";
		}
		

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
    public function updateShow(){
        $id = $this->request->get['id'];
        $value = $this->request->get['value'];
        $this->model_core_module->updateCol($id,'isshow',$value);
        $this->data['output'] = 'true';
        $this->template = "common/output.tpl";
        $this->render();
    }
}