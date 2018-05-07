<?php

/**
 * Class ControllerCoreTrash
 * @property ModelModuleInvoice model_module_invoice
 * @property ModelModuleAccounts model_module_accounts
 * @property ModelModuleAccountlog model_module_accountlog
 * @property ModelModuleTax model_module_tax
 * @property ModelModulePaymentmethod model_module_paymentmethod
 * @property ModelModuleLocation model_module_location
 */
class ControllerCoreTrash extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;
    private $setting = array();
    function __construct()
    {
        $this->load->model("module/invoice");
        $this->load->model("module/accounts");
        $this->load->model("module/accountlog");
        $this->load->model("module/tax");
        $this->data['accounts'] = array();
        $this->model_module_accounts->getTree('',$this->data['accounts']);
        foreach($this->data['accounts'] as $key => $item)
        {
            //$length = strlen($item['accountid']);
            $level = $item['level'];
            $this->data['accounts'][$key]['accountname'] = $this->string->setLoopStr("&nbsp;",$level*5)  .$item['accountid']."-". $item['accountname'];
        }
        $this->data['taxs'] = $this->model_module_tax->getList();
        $this->load->model("module/paymentmethod");
        $this->data['paymentmethods'] = $this->model_module_paymentmethod->getList();
        $this->load->model("module/location");
        $this->data['locations'] = array();
        $this->model_module_location->getTree(0,$this->data['locations']);
        foreach ($this->data['locations'] as $key => $location){
            $this->data['locations'][$key]['locationname'] = $this->model_module_location->showPath($location['id']);
        }
    }

    public function index()
    {
        $this->getList();

    }

    public function getList()
    {
        $this->template = "core/trash.tpl";
        $this->layout = "page/home";
        $this->render();

    }

    public function loadData()
    {
        $where = "";
        $datasearch = $this->request->get;
        if ($datasearch['invoiceid']) {
            $where .= " AND `invoiceid` like '%" . $datasearch['invoiceid'] . "%'";
        }
        if ($datasearch['invoicetype']) {
            $where .= " AND `invoicetype` like '%" . $datasearch['invoicetype'] . "%'";
        }
        if ($datasearch['frominvoicedate']) {
            $where .= " AND `invoicedate` >= '" . $this->date->formatViewDate($datasearch['frominvoicedate']) . "'";
        }
        if ($datasearch['toinvoicedate']) {
            $where .= " AND `invoicedate` <= '" . $this->date->formatViewDate($datasearch['toinvoicedate']) . " 23:59:59'";
        }

        if ($datasearch['cardname']) {
            $where .= " AND `cardname` like '%" . $datasearch['cardname'] . "%'";
        }

        if ($datasearch['methodtype']) {
            $where .= " AND `methodtype` like '%" . $datasearch['methodtype'] . "%'";
        }
        if ($datasearch['paymentmethod']) {
            $where .= " AND `paymentmethod` like '%" . $datasearch['paymentmethod'] . "%'";
        }
        if ($datasearch['accountidto']) {
            $where .= " AND `accountidto` like '%" . $datasearch['accountidto'] . "%'";
        }
        if ($datasearch['accountidfrom']) {
            $where .= " AND `accountidfrom` like '%" . $datasearch['accountidfrom'] . "%'";
        }
        if ($datasearch['orderid']) {
            $where .= " AND `orderid` like '%" . $datasearch['orderid'] . "%'";
        }


        if ($datasearch['storeid']) {
            $where .= " AND `storeid` like '%" . $datasearch['storeid'] . "%'";
        }

        if ($datasearch['status']) {
            $where .= " AND `status` like '" . $datasearch['status'] . "'";
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
        else
        {
            $orderby = " ORDER BY `createdate` ASC";
        }
        $this->data['invoices'] = $this->model_module_invoice->getListTrash($where.$orderby, $from, $to);
        foreach($this->data['invoices'] as $key => $invoice)
        {
            if($invoice['invoicetype'] == 'expense')
            {
                $this->data['invoices'][$key]['amount'] =  $invoice['amount']*-1;
                $this->data['invoices'][$key]['accountid'] = $invoice['accountidto'];
            }
            else{
                $this->data['invoices'][$key]['accountid'] = $invoice['accountidfrom'];
            }

        }

        $total = $this->model_module_invoice->countTotalTrash($where);
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

        $this->template = "core/invoice_table.tpl";
        $this->render();
    }

    public function destroy()
    {
        $id = $this->request->get['id'];
        $invoice = $this->model_module_invoice->getItem($id);
        $this->model_module_accountlog->clearByInvoice($invoice['invoiceid']);
        $this->model_module_invoice->destroy($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function restore(){
        $id = $this->request->get['id'];
        $data = $this->model_module_invoice->getItem($id);
        $this->model_module_invoice->updateCol($id,'deletedby','');
        if($data['invoicetype'] == 'expense')
        {
            $log['id'] = '';
            $log['datelog'] = $data['invoicedate'];
            $log['accountid'] = $data['accountidto'];
            $log['type'] = "debit";
            $log['amount'] = abs($data['amount']);
            $log['invoiceid'] = $data['invoiceid'];
            $log['orderid'] = '';
            $this->model_module_accountlog->save($log);

            $log['id'] = '';
            $log['datelog'] = $data['invoicedate'];
            $log['accountid'] = $data['accountidfrom'];
            $log['type'] = "credit";
            $log['amount'] = abs($data['amount']);
            $log['invoiceid'] = $data['invoiceid'];
            $log['orderid'] = '';
            $this->model_module_accountlog->save($log);
        }else{

            $log['id'] = '';
            $log['datelog'] = $data['invoicedate'];
            $log['accountid'] = $data['accountidto'];
            $log['type'] = "debit";
            $log['amount'] = $data['amount'];
            $log['invoiceid'] = $data['invoiceid'];
            $log['orderid'] = '';
            $this->model_module_accountlog->save($log);

            $log['id'] = '';
            $log['datelog'] = $data['invoicedate'];
            $log['accountid'] = $data['accountidfrom'];
            $log['type'] = "credit";
            $log['amount'] = $data['amount'];
            $log['invoiceid'] = $data['invoiceid'];
            $log['orderid'] = '';
            $this->model_module_accountlog->save($log);
        }
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

}