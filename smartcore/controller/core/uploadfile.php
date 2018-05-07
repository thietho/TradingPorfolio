<?php

/**
 * Class ControllerCoreUploadfile
 *
 *
 */
class ControllerCoreUploadfile extends Controller
{
    private $errors = array();
    private $itemsPerPage = 12;



    public function index()
    {
        $folder = $this->request->get['folder'];
        $size = $this->request->get['size'];
        $output = $this->request->get['output'];
        $this->data['type'] = $this->request->get['type'];
        $this->data['folder'] = $folder;
        $this->data['size'] = $size;
        $this->data['output'] = $output;
        $this->template = "core/uploadfile.tpl";
        $this->render();
    }

    public function getList()
    {
        $folder = $this->request->get['folder'];
        $path = DIR_FILE."upload/".$folder."/";
        $files = glob($path . '*');
        $this->data['files'] = array();
        if(count($files))
        {
            if($files !==false)
                foreach ($files as $file)
                {
                    $this->data['files'][] = pathinfo($file);

                }
        }

        $this->template = "core/file_list.tpl";
        $this->render();
    }
    public function delFile()
    {
        $data = $this->request->post;
        $filepath = $data['filepath'];
        unlink($filepath);
        $this->data['output'] = 'true';
        $this->template = "common/output.tpl";
        $this->render();
    }
}