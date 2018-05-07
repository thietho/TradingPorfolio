<?php
    function compress_html($buffer) {
        $options = array();
        $html = Minify_HTML::minify($buffer, $options);
        return $html;
    }

    ob_start('compress_html');
?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>FMRA</title>

    <!-- META SECTION -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <!-- END META SECTION -->

    <!-- BEGIN STYLESHEETS -->
    <link rel="stylesheet" href="<?php echo DIR_CSS ?>styles.css" type="text/css"/>
    <!-- END STYLESHEETS -->

</head>

<?php ob_flush(); ?>

<body>

<!-- APP WRAPPER -->
<div class="app app-fh">
    <div class="row">
        <div class="elife-content col-md-8 col-md-offset-2 text-center">
            <div class="maintenance">
                <p><img width="150" class="img-responsive center-block" src="<?php echo DIR_COMMON ?>images/icon-under-construction.png"/></p>
                <?php echo $lang_text_message; ?>
            </div>
        </div>
    </div>
</div>
<!-- END APP WRAPPER -->






<!-- ADD JAVASCRIPT -->
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/moment/moment.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/customscrollbar/jquery.mCustomScrollbar.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/bootstrap-select/bootstrap-select.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/bootstrap-datetimepicker/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/maskedinput/jquery.maskedinput.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/form-validator/jquery.form-validator.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/noty/jquery.noty.packaged.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/datatables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/datatables/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/knob/jquery.knob.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/jvectormap/jquery-jvectormap.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>/vendor/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/jvectormap/jquery-jvectormap-us-aea-en.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/sparkline/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/morris/raphael.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/morris/morris.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/rickshaw/d3.v3.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/rickshaw/rickshaw.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>vendor/isotope/isotope.pkgd.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>app.js"></script>
<script type="text/javascript" src="<?php echo DIR_JS ?>app_plugins.js"></script>
<!-- END JAVASCRIPT -->

</body>
</html>


<?php
    ob_end_flush();
?>