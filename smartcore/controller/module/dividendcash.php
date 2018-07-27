<?php

/**
 * Class ControllerModuleDividendcash
 * @property ModelModuleDividendcash model_module_dividendcash
 * @property ModelModuleAccountstock model_module_accountstock
 * @property ModelModuleItem model_module_item
 * @property ModelModuleInvoice model_module_invoice
 *
 */
class ControllerModuleDividendcash extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("module/dividendcash");
        $this->load->model("module/accountstock");
        $this->load->model("module/invoice");
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
        $this->template = "module/dividendcash_list.tpl";
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
		if ($datasearch['amount']) {
			$where .= " AND `amount` like '%" . $datasearch['amount'] . "%'";
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
        $this->data['dividendcashs'] = $this->model_module_dividendcash->getList($where.$orderby, $from, $to);

        $total = $this->model_module_dividendcash->countTotal($where);
        $this->data['total'] = $total;

        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'dividendcash-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "module/dividendcash_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_module_dividendcash->getItem($id);
        }

        $this->template = "module/dividendcash_form.tpl";
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

        $this->model_module_dividendcash->delete($id);
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
            $data['amount'] = $this->string->toNumber($data['amount']);
            $data['id'] = $this->model_module_dividendcash->save($data);
            //Luu vào thu chi
            if($data['amount']>0){
                $where = " AND dividendid = '".$data['id']."'";
                $invoices = $this->model_module_invoice->getList($where);
                $invoice = array();
                if(count($invoices)){
                    $invoice = $invoices[0];
                }
                $invoice['dividendid'] = $data['id'];
                $invoice['transactionid'] = '';
                $invoice['invoicetype'] = "INC";
                $invoice['invoicedate'] = $data['deadline'];
                $invoice['notes'] = "Nhận cổ tứ từ cổ phiếu ".$data['symbol'];
                $invoice['amount'] = $data['amount'];
                $this->model_module_invoice->save($invoice);
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
		if ("" == $data['amount']) {
			$this->errors['amount'] = "Số tiền not empty";
		}

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
}