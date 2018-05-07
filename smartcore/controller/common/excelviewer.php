<?php
class ControllerCommonExcelviewer extends Controller
{
    function index()
    {
        
        $this->template="common/excelviewer.tpl";
        $this->render();
    }

}
?>