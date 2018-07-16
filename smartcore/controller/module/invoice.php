<?php

/**
 * Class ControllerModuleInvoice
 * @property ModelModuleInvoice model_module_invoice
 *
 */
class ControllerModuleInvoice extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("module/invoice");
    }

    public function index()
    {
        $this->getList();
    }

    public function getList()
    {
        $this->template = "module/invoice_list.tpl";
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
        if ($datasearch['invoiceid']) {
			$where .= " AND `invoiceid` like '%" . $datasearch['invoiceid'] . "%'";
		}
		if ($datasearch['invoicedate']) {
			$where .= " AND `invoicedate` like '%" . $datasearch['invoicedate'] . "%'";
		}
		if ($datasearch['transactionid']) {
			$where .= " AND `transactionid` like '%" . $datasearch['transactionid'] . "%'";
		}
		if ($datasearch['marginid']) {
			$where .= " AND `marginid` like '%" . $datasearch['marginid'] . "%'";
		}
		if ($datasearch['dividendid']) {
			$where .= " AND `dividendid` like '%" . $datasearch['dividendid'] . "%'";
		}
		if ($datasearch['invoicetype']) {
			$where .= " AND `invoicetype` like '%" . $datasearch['invoicetype'] . "%'";
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
        $this->data['invoices'] = $this->model_module_invoice->getList($where.$orderby, $from, $to);

        $total = $this->model_module_invoice->countTotal($where);
        $this->data['total'] = $total;

        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'invoice-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "module/invoice_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_module_invoice->getItem($id);
        }

        $this->template = "module/invoice_form.tpl";
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

        $this->model_module_invoice->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $data['invoicedate'] = $this->date->formatViewDate($data['invoicedate']);
            $data['amount'] = $this->string->toNumber($data['amount']);
            $data['id'] = $this->model_module_invoice->save($data);
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

		if ("" == $data['invoicedate']) {
			$this->errors['invoicedate'] = "Ngày not empty";
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