<?php

/**
 * Class ControllerModuleImport
 * @property ModelModuleOrder model_module_order
 * @property ModelModuleOrderproduct model_module_orderproduct
 * @property ModelModuleOrderstatus model_module_orderstatus
 * @property ModelModuleStore model_module_store
 * @property ModelModuleStoreticket model_module_storeticket
 * @property ModelModuleCash model_module_cash
 *
 */
class ControllerCommonDashboard extends Controller
{
    private $errors = array();
    private $itemsPerPage = 20;

    function __construct()
    {
        $this->load->model("module/order");
        $this->load->model("module/cash");

    }

    public function index()
    {
        
        if($this->user->getUserTypeId() == 'saleretail')
            $this->response->redirect("?route=module/sale");
        $this->data['fromdate'] = $this->date->addday($this->date->getTodayNoTime(),-30);
        $this->data['todate'] = $this->date->getTodayNoTime();

        $this->data['data_chart'] = $this->getDataChart($this->data['fromdate'],$this->data['todate']);
        $where = " AND storeid = '". $this->user->store['id'] ."' ORDER BY  `order`.`orderdate` DESC LIMIT 0 , 10";
        $this->data['oders'] = $this->model_module_order->getList($where);

        //Tao ca làm viec
        $this->session->set('cash',$this->model_module_cash->createSession());
        $this->template = "common/dashboard.tpl";
        $this->layout = "page/home";
        $this->render();
    }

    public function getDataChart($fromdate = '' ,$todate ='')
    {

        $datadate = array();
        $dateindex = $fromdate;
        while($this->date->timeToInt($dateindex) <= $this->date->timeToInt($todate))
        {
            $datadate[] = $dateindex;
            $dateindex = $this->date->addday($dateindex,1);
        }

        $datacounts= array();
        foreach($datadate as $date)
        {

            $listorder = $this->model_module_order->getOrderByDate($date);
            $datacount = array();
            if(count($listorder))
                $datacount = $this->model_module_order->countOrder($listorder);
            $datacounts[$date] = $datacount;
        }

        $datacountimport = array();
        $datacountsale = array();
        foreach($datacounts as $date => $item)
        {
            $import = 0;
            $sale = 0;
            if(isset($item['IPO']))
                $import = $item['IPO'];
            if(isset($item['ESA']))
                $sale = $item['ESA'];
            $datacountimport[] = $import;
            $datacountsale[] = $sale;

        }

        $data['imports'] = $datacountimport;
        $data['sales'] = $datacountsale;
        $data['dates'] = $datadate;
        return $data;
    }
    public function getDataChartAjax()
    {


        $fromdate = $this->date->formatViewDate($this->request->post['fromdate']);
        $todate = $this->date->formatViewDate($this->request->post['todate']);
        //print_r( $this->request->post['fromdate']);
        $data = $this->getDataChart($fromdate,$todate);
        $this->data['output'] = json_encode($data);
        $this->template = "common/output.tpl";
        $this->render();
    }
}