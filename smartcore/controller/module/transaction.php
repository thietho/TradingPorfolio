<?php

/**
 * Class ControllerModuleTransaction
 * @property ModelModuleTransaction model_module_transaction
 * @property ModelModuleAccountstock model_module_accountstock
 * @property ModelModuleItem model_module_item
 * @property ModelModuleInvoice model_module_invoice
 *
 */
class ControllerModuleTransaction extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("module/transaction");
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
        $this->template = "module/transaction_list.tpl";
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
        if ($datasearch['transactionid']) {
			$where .= " AND `transactionid` like '%" . $datasearch['transactionid'] . "%'";
		}
		if ($datasearch['accountid']) {
			$where .= " AND `accountid` like '%" . $datasearch['accountid'] . "%'";
		}
		if ($datasearch['cardid']) {
			$where .= " AND `cardid` like '%" . $datasearch['cardid'] . "%'";
		}
		if ($datasearch['transactiondate']) {
			$where .= " AND `transactiondate` like '%" . $datasearch['transactiondate'] . "%'";
		}
		if ($datasearch['receivemoneydate']) {
			$where .= " AND `receivemoneydate` like '%" . $datasearch['receivemoneydate'] . "%'";
		}
		if ($datasearch['receivestockdate']) {
			$where .= " AND `receivestockdate` like '%" . $datasearch['receivestockdate'] . "%'";
		}
		if ($datasearch['symbol']) {
			$where .= " AND `symbol` like '%" . $datasearch['symbol'] . "%'";
		}
		if ($datasearch['name']) {
			$where .= " AND `name` like '%" . $datasearch['name'] . "%'";
		}
		if ($datasearch['type']) {
			$where .= " AND `type` like '%" . $datasearch['type'] . "%'";
		}
		if ($datasearch['costofsale']) {
			$where .= " AND `costofsale` like '%" . $datasearch['costofsale'] . "%'";
		}
		if ($datasearch['volume']) {
			$where .= " AND `volume` like '%" . $datasearch['volume'] . "%'";
		}
		if ($datasearch['price']) {
			$where .= " AND `price` like '%" . $datasearch['price'] . "%'";
		}
		if ($datasearch['fee']) {
			$where .= " AND `fee` like '%" . $datasearch['fee'] . "%'";
		}
		if ($datasearch['tax']) {
			$where .= " AND `tax` like '%" . $datasearch['tax'] . "%'";
		}
		if ($datasearch['total']) {
			$where .= " AND `total` like '%" . $datasearch['total'] . "%'";
		}
		if ($datasearch['profit']) {
			$where .= " AND `profit` like '%" . $datasearch['profit'] . "%'";
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
        $this->data['transactions'] = $this->model_module_transaction->getList($where.$orderby, $from, $to);

        $total = $this->model_module_transaction->countTotal($where);
        $this->data['total'] = $total;

        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'transaction-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "module/transaction_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        $type = $this->request->get['type'];
        if ($id) {
            $this->data['item'] = $this->model_module_transaction->getItem($id);
        }else{
            $this->data['item']['type'] = $type;
            $this->data['item']['transactiondate'] = $this->date->getToday();
        }
        switch ($this->data['item']['type']){
            case "B":
                $this->template = "module/transaction_buy.tpl";
                break;
            case "S":
                $this->template = "module/transaction_sale.tpl";
                break;
        }

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

        $this->model_module_transaction->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            if($data['transactionid'] == ''){
                $data['transactionid'] = $this->model_module_transaction->createId($data['type']);
            }
            $data['cardid'] = $this->document->getAccountstock($data['accountid']);
            $data['name'] = $this->document->getItem($data['symbol']);
            $data['transactiondate'] = $this->date->formatViewDate($data['transactiondate']);
            $data['receivemoneydate'] = $this->date->addWorkDay($data['transactiondate'],2);
            $data['receivestockdate'] = $this->date->addWorkDay($data['transactiondate'],3);
            $data['volume'] = $this->string->toNumber($data['volume']);
            $data['price'] = $this->string->toNumber($data['price']);
            $data['fee'] = $this->string->toNumber($data['fee']);
            $data['tax'] = $this->string->toNumber($data['tax']);
            $data['total'] = $this->string->toNumber($data['total']);
            $data['costofsale'] = $this->model_module_transaction->getCostOfSale($data['accountid'],$data['symbol'],$data);
            $data['profit'] = $this->string->toNumber( $data['total'] -  $data['costofsale']*$data['volume']);
            $data['id'] = $this->model_module_transaction->save($data);
            //Luu vào thu chi
            if($data['price']>0){
                $where = " AND transactionid like '".$data['transactionid']."'";
                $invoices = $this->model_module_invoice->getList($where);
                $invoice = array();
                if(count($invoices)){
                    $invoice = $invoices[0];
                }
                $invoice['transactionid'] = $data['transactionid'];
                if ($data['type']=='B'){
                    $invoice['invoicetype'] = "EXP";
                    $invoice['invoicedate'] = $data['transactiondate'];
                    $invoice['notes'] = "Mua cổ phiếu ".$data['symbol'];
                }else{
                    $invoice['invoicetype'] = "INC";
                    $invoice['invoicedate'] = $data['receivemoneydate'];
                    $invoice['notes'] = "Bán cổ phiếu ".$data['symbol'];
                }
                $invoice['amount'] = $data['total'];
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
		if ("" == $data['accountid']) {
			$this->errors['accountid'] = "Tài khoản not empty";
		}

		if ("" == $data['transactiondate']) {
			$this->errors['transactiondate'] = "Ngày giao dịch not empty";
		}

		if ("" == $data['symbol']) {
			$this->errors['symbol'] = "Mã ck not empty";
		}

		if ("" == $data['type']) {
			$this->errors['type'] = "Loại giao dịch not empty";
		}
		if ("" == $data['volume']) {
			$this->errors['volume'] = "Số lượng not empty";
		}
		if ("" == $data['price']) {
			$this->errors['price'] = "Giá not empty";
		}
		if ("" == $data['fee']) {
			$this->errors['fee'] = "Phí giao dich not empty";
		}

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
}