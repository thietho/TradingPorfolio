<?php

/**
 * Class ControllerModuleCustomer
 * @property ModelModuleCard model_module_card

 * @property ModelModuleCardlocation model_module_cardlocation

 * @property ModelCoreUserType model_core_usertype
 * @property ModelCoreUser model_core_user

 * @property ModelCoreSetting model_core_setting
 * @property ModelModuleLocation model_module_location
 *
 */
class ControllerModuleCard extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;
    private $setting = array();
    function __construct()
    {
        $this->load->model("module/card");
        $this->load->model("module/cardlocation");
        $this->load->model("core/usertype");
        $this->load->model("core/user");
        $this->load->model("core/setting");
        $this->setting = $this->model_core_setting->getSettingInfo();
        $this->load->model("module/location");
        $this->data['locations'] = array();
        $this->model_module_location->getTree(0,$this->data['locations']);
    }

    public function index()
    {
        if(!$this->user->checkPermission('cardList'))
            $this->response->redirect("?route=core/permission&code=cardList");


        /*require_once DIR_COMPONENT.'PHPExcel/PHPExcel.php';

        $inputFileName = DIR_COMPONENT.'/temp/customer.xlsx';

        try {
            $inputFileType = PHPExcel_IOFactory::identify($inputFileName);
            $objReader = PHPExcel_IOFactory::createReader($inputFileType);
            $objPHPExcel = $objReader->load($inputFileName);
        } catch (Exception $e) {
            die('Error loading file "' . pathinfo($inputFileName, PATHINFO_BASENAME) . '": ' .
                $e->getMessage());
        }

        $sheet = $objPHPExcel->getSheet(0);
        $highestRow = $sheet->getHighestRow();
        $highestColumn = $sheet->getHighestColumn();

        for ($row = 1; $row <= $highestRow; $row++) {
            $rowData = $sheet->rangeToArray('A' . $row . ':' . $highestColumn . $row,
                null, true, false);

            //Prints out data in each row.
            //Replace this with whatever you want to do with the data.
            echo $row;
            echo '<pre>';
            print_r($rowData);
            echo '</pre>';
            if($row>=3)
            {
                $where = " AND fullname = '".$rowData[0][1]."'";
                $cards = $this->model_module_card->getList($where);
                if(count($cards) == 0){
                    $card['id']= '';
                }
                else{
                    $card = $cards[0];
                }

                $card['cardid'] = $this->model_module_card->createCardId('C');
                $card['cardtype'] = 'customer';
                $card['fullname'] = $rowData[0][1];
                $card['telephone'] = $rowData[0][2];
                $card['addressline1'] = $rowData[0][5];
                $this->model_module_card->save($card);

                $cardlocation['id'] = '';
                $cardlocation['cardid'] = $card['cardid'];
                $cardlocation['locationname'] = 'Nhà riêng';
                $cardlocation['contactname'] = $card['fullname'];
                $cardlocation['phone'] = $card['telephone'];
                $cardlocation['addressline1'] = $card['addressline1'];
                $this->model_module_cardlocation->save($cardlocation);
                if($rowData[0][6]!=''){
                    $cardlocation['id'] = '';
                    $cardlocation['cardid'] = $card['cardid'];
                    $cardlocation['locationname'] = 'Công ty';
                    $cardlocation['contactname'] = $card['fullname'];
                    $cardlocation['phone'] = $card['telephone'];
                    $cardlocation['addressline1'] = $rowData[0][6];
                    $this->model_module_cardlocation->save($cardlocation);
                }

            }
        }*/

        $this->getList();
    }

    public function getList()
    {
        $this->template = "module/card_list.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if ($type == 'popup')
            $this->layout = "";
        $this->render();

    }

    public function loadData()
    {
        $where = " AND cardid <> 'RetailCustomer'";
        $datasearch = $this->request->get;
        if ($datasearch['cardid']) {
			$where .= " AND `cardid` like '%" . $datasearch['cardid'] . "%'";
		}
		if ($datasearch['cardtype']) {
			$where .= " AND `cardtype` like '%" . $datasearch['cardtype'] . "%'";
		}
		if ($datasearch['image']) {
			$where .= " AND `image` like '%" . $datasearch['image'] . "%'";
		}
		if ($datasearch['firstname']) {
			$where .= " AND `firstname` like '%" . $datasearch['firstname'] . "%'";
		}
		if ($datasearch['lastname']) {
			$where .= " AND `lastname` like '%" . $datasearch['lastname'] . "%'";
		}
        if ($datasearch['fullname']) {
            $where .= " AND `fullname` like '%" . $datasearch['fullname'] . "%'";
        }
		if ($datasearch['email']) {
			$where .= " AND `email` like '%" . $datasearch['email'] . "%'";
		}
		if ($datasearch['telephone']) {
			$where .= " AND `telephone` like '%" . $datasearch['telephone'] . "%'";
		}
		if ($datasearch['mobilephone']) {
			$where .= " AND `mobilephone` like '%" . $datasearch['mobilephone'] . "%'";
		}
        $page = preg_replace('#[^0-9]#i', '', $this->request->get['page']);
        if ($page == ''){
            if(!isset($_SESSION['pagecard'][$datasearch['cardtype']])){
                $_SESSION['pagecard'][$datasearch['cardtype']] = 1;
            }
            $page = $_SESSION['pagecard'][$datasearch['cardtype']];
        }else{
            $_SESSION['pagecard'][$datasearch['cardtype']] = $page;
        }

        $this->data['page'] = $page;


        $from = ($page - 1) * $this->itemsPerPage;
        $to = $this->itemsPerPage;
        $orderby = "";
        if($datasearch['sortcol']!="")
        {
            $orderby = " ORDER BY `".$datasearch['sortcol']."` ".$datasearch['sorttype'];
        }
        $this->data['cards'] = $this->model_module_card->getList($where.$orderby, $from, $to);

        $total = $this->model_module_card->countTotal($where);
        $this->data['total'] = $total;

        /*** generate paging ***/
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->itemsPerPage;
        $pagination->url = $this->string->toUrlPara($datasearch);
        $pagination->filter = '';
        $pagination->eid = 'card-list-'.$datasearch['cardtype'];
        $this->data['pagination'] = $pagination->ajaxRenderNew();
        $this->data['objPage'] = array(
                    'pape' => $page,
                    'itemsPerPage' => $this->itemsPerPage
                );

        $this->template = "module/card_table.tpl";
        $this->render();
    }


    private function getForm()
    {
        $id = $this->request->get['id'];
        if ($id) {
            $this->data['item'] = $this->model_module_card->getItem($id);
        }else{
            $this->data['item']['cardtype'] = 'customer';
        }

        $this->template = "module/card_form.tpl";
        $this->layout = "page/home";
        $type = $this->request->get['type'];
        if ($type == 'popup')
            $this->layout = "";
        $this->render();
    }
    public function view()
    {
        $id = $this->request->get['id'];
        if($id)
            $this->data['item'] = $this->model_module_card->getItem($id);
        $cardid = $this->request->get['cardid'];
        if($cardid)
            $this->data['item'] = $this->model_module_card->getItemById($cardid);
        $this->data['item']['addressline2'] = $this->model_module_location->showPath($this->data['item']['addressline2']);
        $this->template = "module/card_view.tpl";
        $this->render();
    }
    public function updateAccount()
    {
        $id = $this->request->post['id'];
        $username = $this->request->post['username'];
        $this->model_module_card->updateCol($id,'account',$username);
        $this->template = "common/output.tpl";
        $this->render();
    }

    public function insert()
    {
        if(!$this->user->checkPermission('cardAdd'))
            $this->response->redirect("?route=core/permission&code=cardAdd");
        $this->getForm();
    }

    public function update()
    {
        if(!$this->user->checkPermission('cardEdit'))
            $this->response->redirect("?route=core/permission&code=cardEdit");
        $this->getForm();
    }

    public function delete()
    {
        if(!$this->user->checkPermission('cardDel'))
            $this->response->redirect("?route=core/permission&code=cardDel");
        $id = $this->request->get['id'];

        $this->model_module_card->delete($id);
        $this->data['output'] = "true";
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function validateDel()
    {
        $id = $this->request->get['id'];
        $card = $this->model_module_card->getItem($id);
        //Kiểm tra order
        $where = " AND cardid = '".$card['cardid']."'";
        $orders = $this->model_module_order->getList($where);
        //Kiêm tra invoice
        $invoices = $this->model_module_invoice->getList($where);
        if(count($orders) || count($invoices))
        {
            $this->data['output'] = "false";
        }
        else
        {
            $this->data['output'] = "true";
        }
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function save()
    {
        $data = $this->request->post;
        if ($this->validate($data)) {
            $id = $data['id'];
            $data['fullname'] = $data['fullname'];
            $data['birthdate'] = $this->date->formatViewDate($data['birthdate']);
            if($data['cardid'] == "")
                $data['cardid'] = $this->model_module_card->createCardId('C');
            $data['id'] = $this->model_module_card->save($data);

            if($id == '')
            {
                if($data['image'] != "")
                {
                    //Move file vo dung thu muc
                    $oldname = DIR_FILE.$data['image'];
                    $file = pathinfo($oldname);
                    $path = DIR_FILE."upload/card/".$data['cardid'];
                    if(!is_dir($path))
                        mkdir($path);
                    $newfile = $path."/".$file['basename'];
                    rename($oldname,$newfile);
                    rmdir($file['dirname']);
                    $newfile = str_replace(DIR_FILE,'',$newfile);
                    $this->model_module_card->updateCol($data['id'],'image',$newfile);
                }

            }

            //Xoa dia chi giao hàng
            $listlocationremove = $data['listlocationremove'];
            if($listlocationremove!=''){
                $arrlocationid = explode(',',$listlocationremove);
                foreach ($arrlocationid as $locationid){
                    $this->model_module_cardlocation->delete($locationid);
                }
            }
            //Thêm list dia chi giao hàng
            if(count($data['location']['id'])){
                foreach ($data['location']['id'] as $key => $locationid){
                    $location['id'] = $locationid;
                    $location['cardid'] = $data['cardid'];
                    $location['locationname'] = $data['location']['locationname'][$key];
                    $location['contactname'] = $data['location']['contactname'][$key];
                    $location['phone'] = $data['location']['phone'][$key];
                    $location['email'] = $data['location']['email'][$key];
                    $location['addressline1'] = $data['location']['addressline1'][$key];
                    $location['addressline2'] =$data['location']['addressline2'][$key];
                    $this->model_module_cardlocation->save($location);
                }
            }

            //Xoa sap pham cung cap
            $listproductremove = $data['listproductremove'];
            if($listproductremove!=''){
                $arrid = explode(',',$listproductremove);
                foreach ($arrid as $id){
                    $this->model_module_cardproduct->delete($id);
                }
            }
            //Them san pham cung cap
            if(count($data['product']['id'])){
                foreach ($data['product']['id'] as $key => $cardproductid){
                    $cardproduct['id'] = $cardproductid;
                    $cardproduct['cardid'] = $data['cardid'];
                    $cardproduct['productcode'] = $data['product']['productcode'][$key];
                    $cardproduct['import'] = $this->string->toNumber($data['product']['import'][$key]);
                    $cardproduct['unit'] = $data['product']['unit'][$key];
                    $this->model_module_cardproduct->save($cardproduct);
                }
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
		if ("" == $data['fullname']) {
			$this->errors['fullname'] = "Tên khách hàng không được rỗng";
		}
        if ("" == $data['telephone']) {
            $this->errors['telephone'] = "Số điện thoại không được rỗng";
        }
        
        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
    public function setAccount()
    {
        if(!$this->user->checkPermission('cardSetAcc'))
            $this->response->redirect("?route=core/permission&code=cardSetAcc");
        $id = $this->request->get['id'];
        if($id == '')
            $this->response->redirect("?route=module/card");
        $this->data['usertypes'] = $this->model_core_usertype->getList();


        if ($id)
        {
            $this->data['item'] = $this->model_module_card->getItem($id);
            $this->data['user'] = array();
            if($this->data['item']['account'] == '')
            {
                $where = " AND account <> '' AND cardtype = 'staff'";
                $datacard = $this->model_module_card->getList($where);
                $countuser = count($datacard);
                if($this->setting['userlimt']> $countuser)
                    $this->data['allowadduser'] = true;
                else
                    $this->data['allowadduser'] = false;
            }
            else
            {
                $this->data['allowadduser'] = true;
                $this->data['user'] = $this->model_core_user->getItemByUserName($this->data['item']['account']);
            }

        }
        $this->template = "module/card_setaccount.tpl";
        $this->layout = "page/home";
        $this->render();
    }
    public function saveSetAccount()
    {
        $data = $this->request->post;
        if ($this->validateSetAccount($data)) {
            $card = $this->model_module_card->getItem($data['id']);

            if($card['account'] == '')
            {
                //Lu khoang
                $user['userid'] = $data['username'];
                $user['username'] = $data['username'];
                $user['usertypeid'] = $data['usertypeid'];
                $user['password'] = md5($data['password']);
                $user['fullname'] = $card['fullname'];
                $user['email'] = $card['email'];
                $user['imagepath'] = $card['image'];
                $user['phone'] = $card['mobilephone'];
                $user['status'] = 'active';
                $this->model_core_user->save($user);
                $this->model_module_card->updateCol($card['id'],'account',$user['username']);
            }else{
                $user = $this->model_core_user->getItemByUserName($card['account']);
                $user['usertypeid'] = $data['usertypeidupdate'];
                $this->model_core_user->save($user);
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
    private function validateSetAccount($data)
    {
        $this->errors = array();
        if($data['usertypeid'] != '')
        {
            if ("" == $data['username']) {
                $this->errors['username'] = "User name not empty";
            }
            if ("" == $data['password']) {
                $this->errors['password'] = "Password not empty";
            }
            if ("" == $data['confirmpassword']) {
                $this->errors['confirmpassword'] = "Confirm password not empty";
            }
        }


        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
    public function getCardLocationForm()
    {
        $id = $this->request->get['id'];
        $cardid = $this->request->get['cardid'];
        if($id)
        {
            $this->data['item'] = $this->model_module_cardlocation->getItem($id);
        }
        else
        {
            $this->data['item']['cardid'] = $cardid;
        }

        $this->template = "module/card_location_form.tpl";
        $this->render();
    }
    public function saveCardLocation()
    {
        $data = $this->request->post;
        if ($this->validateCardLocation($data)) {

            $data['id'] = $this->model_module_cardlocation->save($data);
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
    private function validateCardLocation($data)
    {
        $this->errors = array();
        if ("" == $data['cardid']) {
            $this->errors['cardid'] = "Cardid name not empty";
        }
        if ("" == $data['locationname']) {
            $this->errors['locationname'] = "Location name not empty";
        }
        if ("" == $data['addressline1']) {
            $this->errors['addressline1'] = "Address Line 1 not empty";
        }

        if (count($this->errors) > 0) {
            return false;
        }
        return true;
    }
    public function removeLocation()
    {
        if(!$this->user->checkPermission('cardLocationDel'))
            $this->response->redirect("?route=core/permission&code=cardLocationDel");
        $id = $this->request->get['id'];
        $this->model_module_cardlocation->delete($id);
        $this->data['output'] = 'true';
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function getCardLocations()
    {
        $col = $this->request->get['col'];
        $val = $this->request->get['val'];

        $where = " AND $col = '$val'";
        $data = $this->model_module_cardlocation->getList($where);
        foreach ($data as $key => $item){
            $data[$key]['locationpath'] = $this->model_module_location->showPath($item['addressline2']);
            $location = $this->model_module_location->getItem($item['addressline2']);
            $data[$key]['shipfee'] = $location['shipfee'];
            $data[$key]['shipfeeorder'] = $location['shipfeeorder'];
            $data[$key]['freeshiporder'] = $location['freeshiporder'];
        }
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function getCardProducts()
    {
        $col = $this->request->get['col'];
        $val = $this->request->get['val'];

        $where = " AND $col = '$val'";
        $data = $this->model_module_cardproduct->getList($where);
        foreach ($data as $key => $item){
            $data[$key]['name'] = $this->document->getProductDes($item['productcode']);
        }
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function getLiabilities()
    {
        if(!$this->user->checkPermission('cardLiabilities'))
            $this->response->redirect("?route=core/permission&code=cardLiabilities");
        $cardid = $this->request->get['cardid'];
        $fromdate = $this->request->get['fromdate'];
        if($fromdate!='')
            $fromdate = $this->date->formatViewDate($fromdate);
        $todate = $this->request->get['todate'];
        if($todate!='')
            $todate = $this->date->formatViewDate($todate);
        $data = $this->model_module_order->getLiabilities($cardid,$fromdate,$todate);

        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function getCard()
    {
        $cardid = $this->request->get['cardid'];
        $data = $this->model_module_card->getItemById($cardid);
        $data['locationpath'] = $this->model_module_location->showPath($data['addressline2']);

        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function getCardsByKeyWord()
    {
        $keyword = $this->request->get['keyword'];
        if($keyword == '')
            $keyword = $this->request->get['query'];
        $where = " AND (fullname like '%$keyword%' OR telephone like '%$keyword%')";
        $cards = $this->model_module_card->getList($where);
        $data = array();
        foreach ($cards as $key => $item){
            $arr = array('id' => $item['cardid'],'name' => $item['fullname'].' - '.$item['telephone']);
            $data[] = $arr;
        }
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }
    public function history()
    {
        if(!$this->user->checkPermission('cardViewHistory'))
            $this->response->redirect("?route=core/permission&code=cardViewHistory");
        $cardid = $this->request->get['cardid'];
        $order = " ORDER BY  `order`.`orderdate` DESC";
        $arr = array();
        foreach($this->document->importtype as $code => $typename)
            $arr[] = $code;
        $where = " AND cardid like '".$cardid."' AND ordertype in('".implode("','",$arr)."')";
        $this->data['imports'] = $this->model_module_order->getList($where.$order);
        $arr = array();
        foreach($this->document->exporttype as $code => $typename)
            $arr[] = $code;
        $where = " AND cardid like '".$cardid."' AND ordertype in('".implode("','",$arr)."')";
        $this->data['exports'] = $this->model_module_order->getList($where.$order);
        $arr = array();
        foreach($this->document->saletype as $code => $typename)
            $arr[] = $code;
        $where = " AND cardid like '".$cardid."' AND ordertype in('".implode("','",$arr)."')";
        $this->data['sales'] = $this->model_module_order->getList($where.$order);

        $where = " AND cardid like '".$cardid."' ORDER BY `soft_invoice`.`invoicedate` ASC";
        $this->data['invioces'] = $this->model_module_invoice->getList($where);
        $this->template = "module/card_history.tpl";
        $this->render();
    }
    public function permissionForm()
    {
        if(!$this->user->checkPermission('cardPermission'))
            $this->response->redirect("?route=core/permission&code=cardPermission");
        $cardid = $this->request->get['cardid'];
        $this->data['card'] = $this->model_module_card->getItemById($cardid);
        $this->data['user'] = $this->model_core_user->getItemByUserName($this->data['card']['account']);
        $this->data['user']['permission'] = json_decode($this->data['user']['permission'],true);
        $this->data['datapermission'] = $this->document->loadDataPermission();
        $this->template = "module/card_permission.tpl";
        $this->render();
    }
    public function savePermission()
    {
        $data = $this->request->post;
        //print_r($data);
        $user = $this->model_core_user->getItemByUserName($data['username']);
        $user['permission'] = json_encode($data['permission']);
        $this->model_core_user->updateCol($user['username'],'permission',$user['permission']);
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }
}