<?php

/**
 * Class ControllerModuleMargin
 * @property ModelModuleMargin model_module_margin
 * @property ModelModuleAccountstock model_module_accountstock
 * @property ModelModuleTransaction model_module_transaction
 */
class ControllerModuleMargin extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("module/margin");
        $this->load->model("module/accountstock");
        $this->load->model("module/transaction");
        $this->data['accountstocks'] = $this->model_module_accountstock->getList();
        $this->data['transactions'] = $this->model_module_transaction->getList();

    }

    public function index()
    {
        $this->getList();
    }

    public function getList()
    {
        $this->template = "module/margin_list.tpl";
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
        if ($datasearch['opendate']) {
			$where .= " AND `opendate` like '%" . $datasearch['opendate'] . "%'";
		}
		if ($datasearch['closedate']) {
			$where .= " AND `closedate` like '%" . $datasearch['closedate'] . "%'";
		}
		if ($datasearch['amount']) {
			$where .= " AND `amount` like '%" . $datasearch['amount'] . "%'";
		}
		if ($datasearch['countdate']) {
			$where .= " AND `countdate` like '%" . $datasearch['countdate'] . "%'";
		}
		if ($datasearch['rate']) {
			$where .= " AND `rate` like '%" . $datasearch['rate'] . "%'";
		}
		if ($datasearch['totalpay']) {
			$where .= " AND `totalpay` like '%" . $datasearch['totalpay'] . "%'";
		}
		if ($datasearch['cardid']) {
			$where .= " AND `cardid` like '%" . $datasearch['cardid'] . "%'";
		}
		if ($datasearch['accountid']) {
			$where .= " AND `accountid` like '%" . $datasearch['accountid'] . "%'";
		}
		if ($datasearch['transactionid']) {
			$where .= " AND `transactionid` like '%" . $datasearch['transactionid'] . "%'";
		}
		if ($datasearch['createdate']) {
			$where .= " AND `createdate` like '%" . $datasearch['createdate'] . "%'";
		}
		if ($datasearch['createby']) {
			$where .= " AND `createby` like '%" . $datasearch['createby'] . "%'";
		}
		if ($datasearch['updatedate']) {
			$where .= " AND `updatedate` like '%" . $datasearch['updatedate'] . "%'";
		}
		if ($datasearch['updateby']) {
			$where .= " AND `updateby` like '%" . $datasearch['updateby'] . "%'";
		}
		if ($datasearch['deletedate']) {
			$where .= " AND `deletedate` like '%" . $datasearch['deletedate'] . "%'";
		}
		if ($datasearch['deleteby']) {
			$where .= " AND `deleteby` like '%" . $datasearch['deleteby'] . "%'";
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
        $this->data['margins'] = $this->model_module_margin->getList($where.$orderby, $from, $to);

        $total = $this->model_module_margin->countTotal($where);
        $this->data['total'] = $total;

        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'margin-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "module/margin_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_module_margin->getItem($id);
        }

        $this->template = "module/margin_form.tpl";
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

        $this->model_module_margin->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $data['opendate'] = $this->date->formatViewDate($data['opendate']);
            $data['closedate'] = $this->date->formatViewDate($data['closedate']);
            $data['amount'] = $this->string->toNumber($data['amount']);
            $data['id'] = $this->model_module_margin->save($data);
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

        if ("" == $data['opendate']) {
			$this->errors['opendate'] = "Ngày phụ lục not empty";
		}

		if ("" == $data['amount']) {
			$this->errors['amount'] = "Giá trị not empty";
		}

		

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
}