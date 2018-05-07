<?php
/*
 * jQuery File Upload Plugin PHP Example 5.14
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

error_reporting(E_ALL ^ E_NOTICE);

//$skinid = $_POST['skinid'];
//$options = array('upload_dir'=>'../../file_'.$skinid.'/file/');

require('uploadhandler.php');

if(isset($_GET['folder_upload_name'])) {
    define("FOLDER_UPLOAD", $_GET['folder_upload_name']);
} else {
    define("FOLDER_UPLOAD", "upload");
}
define("FOLDER_THUMBNAILS", "thumbnails");
//$upload_handler = new UploadHandler($options);
$upload_handler = new UploadHandler();
