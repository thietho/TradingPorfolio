<?php
class ControllerCommonUploadfile extends Controller
{
	function index()
	{	
		
		$folder = urldecode(@$this->request->get['folder']);
		$root = DIR_FILE."upload";
		if(!is_dir($root))
			mkdir($root,777);
		if(@$folder == "")
			$filepath = $root."/";
		else
			$filepath = $root."/".$folder."/";
		//echo $filepath;
		//Tao thu muc neu chua có
		$arrdir = explode("/",$folder);
		$str = $root;
		foreach($arrdir as $dir)
		{
			$str.="/".$dir;
			if(!is_dir($str))
			mkdir($str);
		}
		
		foreach($_FILES['files']['name'] as $key => $item)
		{
			if(@$_FILES['files']['name'][$key] != "")
			{
				$ftemp['name'] = $_FILES['files']['name'][$key];
				$ftemp['type'] = $_FILES['files']['type'][$key];
				$ftemp['tmp_name'] = $_FILES['files']['tmp_name'][$key];
				$ftemp['error'] = $_FILES['files']['error'][$key];
				$ftemp['size'] = $_FILES['files']['size'][$key];
				
				
				move_uploaded_file($ftemp['tmp_name'],$filepath.$ftemp['name']);
				
			}

		}
		@$this->data['output'] = json_encode(array('files' => $_FILES['files']['name']));
		@$this->id="uploadpreview";
		@$this->template="common/output.tpl";
		@$this->render();
	}
	
}
?>