<?php

/**
 * Class ControllerTestProject
 * @property ModelTestProject model_test_project
 *
 */
class ControllerTestProject extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("test/project");
    }

    public function index()
    {
        $this->getList();
    }

    public function getList()
    {
        $this->template = "test/project_list.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if ($type == 'popup')
            $this->layout = "";
        $this->render();

    }

    public function loadData()
    {
        $where = " ";
        $datasearch = $this->request->get;
        if ($datasearch['projectname']) {
			$where .= " AND `projectname` like '%" . $datasearch['projectname'] . "%'";
		}
		if ($datasearch['createdate']) {
			$where .= " AND `createdate` like '%" . $datasearch['createdate'] . "%'";
		}
		if ($datasearch['description']) {
			$where .= " AND `description` like '%" . $datasearch['description'] . "%'";
		}
		if ($datasearch['color']) {
			$where .= " AND `color` like '%" . $datasearch['color'] . "%'";
		}
		if ($datasearch['portfolioid']) {
			$where .= " AND `portfolioid` like '%" . $datasearch['portfolioid'] . "%'";
		}
		


        $page = preg_replace('#[^0-9]#i', '', $this->request->get['page']);
        if ($page == '')
            $page = 1;
        $this->data['page'] = $page;


        $from = ($page - 1) * $this->itemsPerPage;
        $to = $this->itemsPerPage;
        $orderby = "";
        if($datasearch['sortcol']!="")
        {
            $orderby = " ORDER BY `".$datasearch['sortcol']."` ".$datasearch['sorttype'];
        }
        $this->data['projects'] = $this->model_test_project->getList($where.$orderby, $from, $to);

        $total = $this->model_test_project->countTotal($where);


        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'project-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "test/project_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_test_project->getItem($id);
        }

        $this->template = "test/project_form.tpl";
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

        $this->model_test_project->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $data['id'] = $this->model_test_project->save($data);
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

        if ("" == $data['projectname']) {
			$this->errors['projectname'] = "projectname not empty";
		}
		if ("" == $data['createdate']) {
			$this->errors['createdate'] = "createdate not empty";
		}
		if ("" == $data['description']) {
			$this->errors['description'] = "description not empty";
		}
		if ("" == $data['color']) {
			$this->errors['color'] = "color not empty";
		}
		if ("" == $data['portfolioid']) {
			$this->errors['portfolioid'] = "portfolioid not empty";
		}
		

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
}