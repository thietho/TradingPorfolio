<?php

/**
 * Class ControllerTestFacility
 * @property ModelTestFacility model_test_facility
 *
 */
class ControllerTestFacility extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("test/facility");
    }

    public function index()
    {
        $this->getList();
    }

    public function getList()
    {
        $this->template = "test/facility_list.tpl";
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
        if ($datasearch['propertyname']) {
			$where .= " AND `propertyname` like '%" . $datasearch['propertyname'] . "%'";
		}
		if ($datasearch['locationid']) {
			$where .= " AND `locationid` like '%" . $datasearch['locationid'] . "%'";
		}
		if ($datasearch['primaryuse']) {
			$where .= " AND `primaryuse` like '%" . $datasearch['primaryuse'] . "%'";
		}
		if ($datasearch['businessunit']) {
			$where .= " AND `businessunit` like '%" . $datasearch['businessunit'] . "%'";
		}
		if ($datasearch['propertystreetaddress1']) {
			$where .= " AND `propertystreetaddress1` like '%" . $datasearch['propertystreetaddress1'] . "%'";
		}
		if ($datasearch['propertystreetaddress2']) {
			$where .= " AND `propertystreetaddress2` like '%" . $datasearch['propertystreetaddress2'] . "%'";
		}
		if ($datasearch['propertycity']) {
			$where .= " AND `propertycity` like '%" . $datasearch['propertycity'] . "%'";
		}
		if ($datasearch['propertystate']) {
			$where .= " AND `propertystate` like '%" . $datasearch['propertystate'] . "%'";
		}
		if ($datasearch['propertyzip']) {
			$where .= " AND `propertyzip` like '%" . $datasearch['propertyzip'] . "%'";
		}
		if ($datasearch['propertycountry']) {
			$where .= " AND `propertycountry` like '%" . $datasearch['propertycountry'] . "%'";
		}
		if ($datasearch['type']) {
			$where .= " AND `type` like '%" . $datasearch['type'] . "%'";
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
        $this->data['facilitys'] = $this->model_test_facility->getList($where.$orderby, $from, $to);

        $total = $this->model_test_facility->countTotal($where);


        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'facility-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "test/facility_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_test_facility->getItem($id);
        }

        $this->template = "test/facility_form.tpl";
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

        $this->model_test_facility->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $data['id'] = $this->model_test_facility->save($data);
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

        if ("" == $data['propertyname']) {
			$this->errors['propertyname'] = "propertyname not empty";
		}
		if ("" == $data['locationid']) {
			$this->errors['locationid'] = "locationid not empty";
		}
		if ("" == $data['primaryuse']) {
			$this->errors['primaryuse'] = "primaryuse not empty";
		}
		if ("" == $data['businessunit']) {
			$this->errors['businessunit'] = "businessunit not empty";
		}
		if ("" == $data['propertystreetaddress1']) {
			$this->errors['propertystreetaddress1'] = "propertystreetaddress1 not empty";
		}
		if ("" == $data['propertystreetaddress2']) {
			$this->errors['propertystreetaddress2'] = "propertystreetaddress2 not empty";
		}
		if ("" == $data['propertycity']) {
			$this->errors['propertycity'] = "propertycity not empty";
		}
		if ("" == $data['propertystate']) {
			$this->errors['propertystate'] = "propertystate not empty";
		}
		if ("" == $data['propertyzip']) {
			$this->errors['propertyzip'] = "propertyzip not empty";
		}
		if ("" == $data['propertycountry']) {
			$this->errors['propertycountry'] = "propertycountry not empty";
		}
		if ("" == $data['type']) {
			$this->errors['type'] = "type not empty";
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