<?php

/**
 * Class ControllerModuleDividendstock
 * @property ModelModuleDividendstock model_module_dividendstock
 * @property ModelModuleAccountstock model_module_accountstock
 * @property ModelModuleItem model_module_item
 * @property ModelModuleTransaction model_module_transaction
 */
class ControllerModuleDividendstock extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("module/dividendstock");
        $this->load->model("module/accountstock");
        $this->load->model("module/transaction");
        $this->data['accountstocks'] = $this->model_module_accountstock->getList();
        $this->load->model("module/item");
        $this->data['itemcks'] = $this->model_module_item->getList();
    }

    public function index()
    {
        $this->getList();
    }

    public function getList()
    {
        $this->template = "module/dividendstock_list.tpl";
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
        if ($datasearch['receivedate']) {
			$where .= " AND `receivedate` like '%" . $datasearch['receivedate'] . "%'";
		}
		if ($datasearch['deadline']) {
			$where .= " AND `deadline` like '%" . $datasearch['deadline'] . "%'";
		}
		if ($datasearch['symbol']) {
			$where .= " AND `symbol` like '%" . $datasearch['symbol'] . "%'";
		}
		if ($datasearch['accountid']) {
			$where .= " AND `accountid` like '%" . $datasearch['accountid'] . "%'";
		}
		if ($datasearch['transactionid']) {
			$where .= " AND `transactionid` like '%" . $datasearch['transactionid'] . "%'";
		}
		if ($datasearch['price']) {
			$where .= " AND `price` like '%" . $datasearch['price'] . "%'";
		}
		if ($datasearch['dividendrate']) {
			$where .= " AND `dividendrate` like '%" . $datasearch['dividendrate'] . "%'";
		}
		if ($datasearch['quantity']) {
			$where .= " AND `quantity` like '%" . $datasearch['quantity'] . "%'";
		}
		if ($datasearch['quantityallowbuy']) {
			$where .= " AND `quantityallowbuy` like '%" . $datasearch['quantityallowbuy'] . "%'";
		}
		if ($datasearch['quantityallowreceive']) {
			$where .= " AND `quantityallowreceive` like '%" . $datasearch['quantityallowreceive'] . "%'";
		}
		if ($datasearch['notes']) {
			$where .= " AND `notes` like '%" . $datasearch['notes'] . "%'";
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
        $this->data['dividendstocks'] = $this->model_module_dividendstock->getList($where.$orderby, $from, $to);

        $total = $this->model_module_dividendstock->countTotal($where);
        $this->data['total'] = $total;

        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'dividendstock-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "module/dividendstock_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_module_dividendstock->getItem($id);
            $transaction = $this->model_module_transaction->getItemById($this->data['item']['transactionid']);
            $this->data['item']['tranid'] = $transaction['id'];
        }

        $this->template = "module/dividendstock_form.tpl";
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

        $this->model_module_dividendstock->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $data['receivedate'] = $this->date->formatViewDate($data['receivedate']);
            $data['deadline'] = $this->date->formatViewDate($data['deadline']);
            $data['price'] = $this->string->toNumber($data['price']);
            $data['dividendrate'] = $this->string->toNumber($data['dividendrate']);
            $data['quantity'] = $this->string->toNumber($data['quantity']);
            $data['quantityallowbuy'] = $this->string->toNumber($data['quantityallowbuy']);
            $data['quantityallowreceive'] = $this->string->toNumber($data['quantityallowreceive']);
            $data['id'] = $this->model_module_dividendstock->save($data);
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

        if ("" == $data['receivedate']) {
			$this->errors['receivedate'] = "Ngày nhận not empty";
		}
		if ("" == $data['deadline']) {
			$this->errors['deadline'] = "Ngày chốt quyền not empty";
		}
		if ("" == $data['symbol']) {
			$this->errors['symbol'] = "Mã chứng khoán not empty";
		}
		if ("" == $data['accountid']) {
			$this->errors['accountid'] = "Tài khoản nhận not empty";
		}

		if ("" == $data['price']) {
			$this->errors['price'] = "Giá phát hành not empty";
		}
		if ("" == $data['dividendrate']) {
			$this->errors['dividendrate'] = "Tỷ lệ phát hành not empty";
		}
		if ("" == $data['quantity']) {
			$this->errors['quantity'] = "Số lượng mua not empty";
		}
		if ("" == $data['quantityallowbuy']) {
			$this->errors['quantityallowbuy'] = "Số lượng được mua not empty";
		}
		if ("" == $data['quantityallowreceive']) {
			$this->errors['quantityallowreceive'] = "Số cổ phiếu được nhận not empty";
		}
		

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
}