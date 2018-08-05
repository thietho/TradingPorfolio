<?php

/**
 * Class ControllerCoreUser
 *
 * @property ModelCoreUser model_core_user
 * @property ModelCoreUsertype model_core_usertype
 *
 */
class ControllerCoreCreatemodule extends Controller
{
    private $module = array();
    private $obj = '';
    private $objname = '';
    private $path = '';
    private $table = '';
    private $prefix = '';
    private $col = array();
    private $maincol = '';
    public function index()
    {
        $this->data['output'] = '';
        $this->obj = 'Margin';
        $this->objname = 'Khoản vay';
        $this->path = 'module/margin';
        $this->table = 'margin';
        $this->prefix = 'trading_';
        $this->col = array(
            'opendate'=> 'Ngày phụ lục',
            'closedate'=> 'Ngày thanh lý',
            'amount'=> 'Giá trị',
            'countdate' => 'Ngày nắm giử',
            'rate'=> 'Lãi xuất',
            'totalpay'=> 'Tổng trả',
            'cardid'=> 'Người nhận',
            'accountid'=> 'Tài khoản nhận',
            'transactionid'=> 'Tạo từ giao dịch',
            'createdate'=> 'Ngày tạo',
            'createby'=> 'Tạo bởi',
            'updatedate'=> 'Ngày cập nhật',
            'updateby'=> 'Cập nhật bởi',
            'deletedate'=> 'Ngày xóa',
            'deleteby'=> 'Xóa bởi',
        );
        $this->maincol = 'symbol';
        $this->createModel();
        $this->createController();
        $this->createView();
        $this->data['output'] .= '<br>Create module <a href="'.HTTP_WEB.'?route='.$this->path.'">'.$this->path."</a> success";
        
        $this->template = "core/createmodule.tpl";
        $this->layout = "page/home";
        $this->render();
    }
    private function createModel()
    {
        $filename = DIR_COMPONENT."createmodule/model.txt";
        $handle = fopen($filename, "rb");
        $contents = fread($handle, filesize($filename));
        fclose($handle);
        $arr = explode('/',$this->path);
        $ModelName = ucfirst($arr[0]).ucfirst($arr[1]);
        $contents = str_replace('{ModelName}',$ModelName,$contents);
        $arrcol = array();
        foreach($this->col as $col => $colname)
        {
            $arrcol[] = $col;
        }
        $ListCol = "'".implode("', \n\t\t'" , $arrcol)."'";
        $contents = str_replace('{ListCol}',$ListCol,$contents);
        $contents = str_replace('{Table}',$this->table,$contents);
        $path = DIR_MODEL.$arr[0];
        if(!is_dir($path))
        {
            mkdir($path,0777);
        }
        $file = fopen($path."/".$arr[1].".php","w");
        fwrite($file,$contents);
        fclose($file);
    }
    private function createController()
    {
        $filename = DIR_COMPONENT."createmodule/controller.txt";
        $handle = fopen($filename, "rb");
        $contents = fread($handle, filesize($filename));
        fclose($handle);
        $arr = explode('/',$this->path);
        $ClassName = ucfirst($arr[0]).ucfirst($arr[1]);
        $contents = str_replace('{ClassName}',$ClassName,$contents);
        $ModelName = $arr[0]."_".$arr[1];
        $contents = str_replace('{ModelName}',$ModelName,$contents);
        $Path = $arr[0]."/".$arr[1];
        $contents = str_replace('{Path}',$Path,$contents);
        $SearchWhere = "";
        foreach($this->col as $col => $colname)
        {
            $SearchWhere .= 'if ($datasearch[\''.$col.'\']) {';
            $SearchWhere.="\n\t\t\t".'$where .= " AND `'.$col.'` like \'%" . $datasearch[\''.$col.'\'] . "%\'";';
            $SearchWhere.="\n\t\t".'}'."\n\t\t";
        }
        $contents = str_replace('{SearchWhere}',$SearchWhere,$contents);
        $ValidateCol = '';
        foreach($this->col as $col => $colname)
        {
            $ValidateCol .= 'if ("" == $data[\''.$col.'\']) {';
            $ValidateCol .= "\n\t\t\t".'$this->errors[\''.$col.'\'] = "'.$colname.' not empty";';
            $ValidateCol.="\n\t\t".'}'."\n\t\t";
        }
        $contents = str_replace('{ValidateCol}',$ValidateCol,$contents);
        $Table = $arr[1];
        $contents = str_replace('{Table}',$Table,$contents);

        $path = DIR_CONTROLLER.$arr[0];
        if(!is_dir($path))
        {
            mkdir($path,0777);
        }
        $file = fopen($path."/".$arr[1].".php","w");
        fwrite($file,$contents);
        fclose($file);
    }
    private function createView()
    {
        //List
        $filename = DIR_COMPONENT."createmodule/view/list.txt";
        $handle = fopen($filename, "rb");
        $contents = fread($handle, filesize($filename));
        fclose($handle);
        $arr = explode('/',$this->path);
        $ObjName = $this->objname;
        $contents = str_replace('{ObjName}',$ObjName,$contents);
        $Obj = $this->obj;
        $contents = str_replace('{Obj}',$Obj,$contents);
        $contents = str_replace('{Prefix}',$this->prefix,$contents);
        $Path = $arr[0]."/".$arr[1];
        $contents = str_replace('{Path}',$Path,$contents);
        $contents = str_replace('{Table}',$arr[1],$contents);

        /*$SearchFrom = "";
        foreach($this->col as $col => $colname)
        {
            $SearchFrom .= '<div class="col-md-3">';
            $SearchFrom .= "\n\t\t\t\t\t".'<label class="control-label">'.$colname.'</label>';
            $SearchFrom .= "\n\t\t\t\t\t".'<input type="text" class="form-control input-control" placeholder="'.$colname.'" id="'.$col.'" name="'.$col.'">';
            $SearchFrom .= "\n\t\t\t\t".'</div>'."\n\t\t\t\t";
        }
        $contents = str_replace('{SearchFrom}',$SearchFrom,$contents);*/
        $optionseachcol = "";
        foreach($this->col as $col => $colname)
        {
            $optionseachcol .= '<option value="'.$col.'">'.$colname.'</option>';

        }
        $contents = str_replace('{optionseachcol}',$optionseachcol,$contents);
        $seachval = "";
        foreach($this->col as $col => $colname)
        {
            $seachval .= '<div id="ctr-'.$col.'">';
            $seachval .= "\n\t\t\t".'<input type="text" class="form-control input-sm" placeholder="'.$colname.'" id="'.$col.'" name="'.$col.'">';
            $seachval .= "\n\t\t".'</div>'."\n\t\t";

        }
        $contents = str_replace('{seachval}',$seachval,$contents);

        $path = DIR_VIEW.$arr[0];
        if(!is_dir($path))
        {
            mkdir($path,0777);
        }
        $file = fopen($path."/".$arr[1]."_list.tpl","w");
        fwrite($file,$contents);
        fclose($file);
        //Table
        $filename = DIR_COMPONENT."createmodule/view/table.txt";
        $handle = fopen($filename, "rb");
        $contents = fread($handle, filesize($filename));
        fclose($handle);
        $arr = explode('/',$this->path);
        $Path = $arr[0]."/".$arr[1];
        $contents = str_replace('{Path}',$Path,$contents);
        $contents = str_replace('{Table}',$arr[1],$contents);
        $ObjName = $this->obj;
        $contents = str_replace('{ObjName}',$ObjName,$contents);
        $Obj = $this->obj;
        $contents = str_replace('{Obj}',$Obj,$contents);
        $contents = str_replace('{Prefix}',$this->prefix,$contents);
        $TableHearder = "";
        $TableBody = "";
        $MoblieRowShow = '';
        $MobileColSort = '';
        $BtnSelect = $arr[1].'id="<?php echo $'.$arr[1].'[\'id\']?>"'."\n\t\t\t\t\t\t\t";
        foreach($this->col as $col => $colname)
        {
            $TableHearder .= '<th class="sort-default" sortcol="'.$col.'">'.$colname.'</th>'."\n\t\t\t\t";
            $TableBody .= '<td><?php echo $'.$arr[1].'[\''.$col.'\'] ?></td>'."\n\t\t\t\t";
            $BtnSelect .= $col.'="<?php echo $'.$arr[1].'[\''.$col.'\']?>"'."\n\t\t\t\t\t\t\t";
            $MoblieRowShow .= '<label>'.$colname.':</label> <?php echo $'.$arr[1].'[\''.$col.'\'] ?><br>'."\n\t\t";
            $MobileColSort .= '<option value="'.$col.'">'.$colname.'</option>'."\n\t\t\t\t\t";
        }
        $contents = str_replace('{TableHearder}',$TableHearder,$contents);
        $contents = str_replace('{TableBody}',$TableBody,$contents);
        $contents = str_replace('{BtnSelect}',$BtnSelect,$contents);
        $contents = str_replace('{MoblieRowShow}',$MoblieRowShow,$contents);
        $contents = str_replace('{MobileColSort}',$MobileColSort,$contents);
        $contents = str_replace('{ColName}',$this->maincol,$contents);


        $path = DIR_VIEW.$arr[0];
        if(!is_dir($path))
        {
            mkdir($path,0777);
        }
        $file = fopen($path."/".$arr[1]."_table.tpl","w");
        fwrite($file,$contents);
        fclose($file);
        //From
        $filename = DIR_COMPONENT."createmodule/view/form.txt";
        $handle = fopen($filename, "rb");
        $contents = fread($handle, filesize($filename));
        fclose($handle);
        $arr = explode('/',$this->path);
        $Path = $arr[0]."/".$arr[1];
        $contents = str_replace('{Path}',$Path,$contents);
        $contents = str_replace('{Table}',$arr[1],$contents);
        $ObjName = $this->objname;
        $contents = str_replace('{ObjName}',$ObjName,$contents);
        $Obj = $this->obj;
        $contents = str_replace('{Obj}',$Obj,$contents);
        $FromBody = '';
        foreach($this->col as $col => $colname)
        {
            $FromBody .= '<div class="form-group">';
            $FromBody .= "\n\t\t\t\t\t\t".'<label class="col-md-3 control-label">'.$colname.'</label>';
            $FromBody .= "\n\t\t\t\t\t\t".'<div class="col-md-9">';
            $FromBody .= "\n\t\t\t\t\t\t\t".'<input type="text" class="form-control input-sm"
                                       name="'.$col.'" id="'.$col.'" placeholder="'.$colname.'"
                                       value="<?php echo $item[\''.$col.'\'] ?>">';
            $FromBody .= "\n\t\t\t\t\t\t".'</div>';
            $FromBody .= "\n\t\t\t\t\t".'</div>'."\n\t\t\t\t\t";
        }
        $contents = str_replace('{FromBody}',$FromBody,$contents);
        $path = DIR_VIEW.$arr[0];
        if(!is_dir($path))
        {
            mkdir($path,0777);
        }
        $file = fopen($path."/".$arr[1]."_form.tpl","w");
        fwrite($file,$contents);
        fclose($file);
    }
}
?>