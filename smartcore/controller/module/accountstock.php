<?php

/**
 * Class ControllerModuleAccountstock
 * @property ModelModuleAccountstock model_module_accountstock
 * @property ModelModuleCard model_module_card
 *
 */
class ControllerModuleAccountstock extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("module/accountstock");
        $this->load->model("module/card");
        $this->data['customers'] = $this->model_module_card->getList(" AND cardtype like 'customer'");
        $this->data['companys'] = $this->model_module_card->getList(" AND cardtype like 'company'");
    }

    public function index()
    {
        $this->getList();
    }

    public function getList()
    {
        $this->template = "module/accountstock_list.tpl";
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
        if ($datasearch['accountid']) {
			$where .= " AND `accountid` like '%" . $datasearch['accountid'] . "%'";
		}
		if ($datasearch['openat']) {
			$where .= " AND `openat` like '%" . $datasearch['openat'] . "%'";
		}
		if ($datasearch['buyfee']) {
			$where .= " AND `buyfee` like '%" . $datasearch['buyfee'] . "%'";
		}
		if ($datasearch['salefee']) {
			$where .= " AND `salefee` like '%" . $datasearch['salefee'] . "%'";
		}
		if ($datasearch['marginrate']) {
			$where .= " AND `marginrate` like '%" . $datasearch['marginrate'] . "%'";
		}
		if ($datasearch['cardid']) {
			$where .= " AND `cardid` like '%" . $datasearch['cardid'] . "%'";
		}
		if ($datasearch['status']) {
			$where .= " AND `status` like '%" . $datasearch['status'] . "%'";
		}
		if ($datasearch['depositfee']) {
			$where .= " AND `depositfee` like '%" . $datasearch['depositfee'] . "%'";
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
        $this->data['accountstocks'] = $this->model_module_accountstock->getList($where.$orderby, $from, $to);

        $total = $this->model_module_accountstock->countTotal($where);
        $this->data['total'] = $total;

        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'accountstock-list';
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "module/accountstock_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_module_accountstock->getItem($id);
        }

        $this->template = "module/accountstock_form.tpl";
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

        $this->model_module_accountstock->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $data['buyfee'] = $this->string->toNumber($data['buyfee']);
            $data['salefee'] = $this->string->toNumber($data['salefee']);
            $data['marginrate'] = $this->string->toNumber($data['marginrate']);
            $data['depositfee'] = $this->string->toNumber($data['depositfee']);
            $data['id'] = $this->model_module_accountstock->save($data);
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
		}else{
            if($data['id'] == ''){
                $obj = $this->model_module_accountstock->getItembyId($data['accountid']);
                if(count($obj)){
                    $this->errors['accountid'] = "Tài khoản đã được sử dụng!";
                }
            }
        }
		if ("" == $data['openat']) {
			$this->errors['openat'] = "Mở tại not empty";
		}
		if ("" == $data['buyfee']) {
			$this->errors['buyfee'] = "Phí mua not empty";
		}
		if ("" == $data['salefee']) {
			$this->errors['salefee'] = "Phí bán not empty";
		}
		if ("" == $data['marginrate']) {
			$this->errors['marginrate'] = "Lãi xuất margin not empty";
		}
		if ("" == $data['cardid']) {
			$this->errors['cardid'] = "Chủ tài khoản not empty";
		}
		if ("" == $data['status']) {
			$this->errors['status'] = "Trạng thái not empty";
		}
		if ("" == $data['depositfee']) {
			$this->errors['depositfee'] = "Phí lưu ký ck not empty";
		}
		

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
    public function getAccountStock(){
        $accountid = $this->request->get['accountid'];
        $data = $this->model_module_accountstock->getItembyId($accountid);
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function getAccountStockList(){
        $col = $this->request->get['col'];
        $val = $this->request->get['val'];
        $where = '';
        if($col !=''){
            $where = " AND $col like '$val'";
        }

        $data = $this->model_module_accountstock->getList($where);
        foreach ($data as &$item){
            $item['text'] = $item['accountid']." - ".$this->document->getCard($item['cardid'])." - ".$this->document->getCard($item['openat']);
        }
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }
}