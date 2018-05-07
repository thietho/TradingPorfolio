<?php

/**
 * Class ControllerCoreUsertype
 * @property ModelCoreUsertype model_core_usertype
 *
 */
class ControllerCoreUsertype extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("core/usertype");

    }

    public function index()
    {
        $this->getList();
    }

    public function getList()
    {
        $this->template = "core/usertype_list.tpl";
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
        if ($datasearch['usertypeid']) {
			$where .= " AND `usertypeid` like '%" . $datasearch['usertypeid'] . "%'";
		}
		if ($datasearch['usertypename']) {
			$where .= " AND `usertypename` like '%" . $datasearch['usertypename'] . "%'";
		}
		if ($datasearch['usertypeparent']) {
			$where .= " AND `usertypeparent` like '%" . $datasearch['usertypeparent'] . "%'";
		}
		if ($datasearch['permission']) {
			$where .= " AND `permission` like '%" . $datasearch['permission'] . "%'";
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
        $this->data['usertypes'] = $this->model_core_usertype->getList($where.$orderby, $from, $to);

        $total = $this->model_core_usertype->countTotal($where);
        $this->data['total'] = $total;

        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'usertype-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "core/usertype_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_core_usertype->getItem($id);
            $this->data['item']['permission'] = json_decode($this->data['item']['permission'],true);
        }
        $this->data['datapermission'] = $this->document->loadDataPermission();
        $this->template = "core/usertype_form.tpl";
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

        $this->model_core_usertype->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $data['permission'] = json_encode($data['permission']);
            $data['id'] = $this->model_core_usertype->save($data);
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

        if ("" == $data['usertypeid']) {
			$this->errors['usertypeid'] = "User Type ID not empty";
		}
		if ("" == $data['usertypename']) {
			$this->errors['usertypename'] = "User Type Name not empty";
		}


        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
}