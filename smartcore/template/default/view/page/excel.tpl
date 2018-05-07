<?php
header("Content-type: application/octet-stream");
header("Content-Disposition: attachment; filename=data.xls");
header("Pragma: no-cache");
header("Expires: 0");
?>
<meta charset="utf-8" />
<?php echo $pagecontent?>