<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>Trading Porfolio</title>

    <!-- META SECTION -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <!-- END META SECTION -->

    <!-- BEGIN STYLESHEETS -->
    <link rel="stylesheet" href="<?php echo DIR_CSS ?>responsive.css?version=<?php echo $this->document->setting['version']?>" type="text/css"/>
    <link rel="stylesheet" href="<?php echo DIR_CSS ?>styles.css?version=<?php echo $this->document->setting['version']?>" type="text/css"/>
    <link rel="stylesheet" href="<?php echo DIR_CSS ?>elife.css?version=<?php echo $this->document->setting['version']?>" type="text/css"/>
    <link rel="stylesheet" href="<?php echo DIR_CSS ?>toastr.min.css" type="text/css"/>
    <!-- END STYLESHEETS -->

    <!-- ADD JAVASCRIPT -->
    <script type="text/javascript">
        var currencyprefix = "<?php echo $this->document->setting['currencyprefix']?>";
        var currencysubfix = "<?php echo $this->document->setting['currencysubfix']?>";
    </script>
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
    <script type="text/javascript" src="<?php echo DIR_JS ?>vendor/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>vendor/jvectormap/jquery-jvectormap-us-aea-en.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>vendor/sparkline/jquery.sparkline.min.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>vendor/morris/raphael.min.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>vendor/morris/morris.min.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>vendor/rickshaw/d3.v3.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>vendor/rickshaw/rickshaw.min.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>vendor/isotope/isotope.pkgd.min.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>app.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>app_plugins.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>toastr.min.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>common.js?version=<?php echo $this->document->setting['version']?>"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>bootstrap-typeahead.js"></script>

    <!-- upload images -->

    <script type="text/javascript" src="<?php echo DIR_JS ?>jquery.fancybox-2.1.4.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="<?php echo DIR_JS ?>jquery.fileupload.js"></script>


    <!-- END JAVASCRIPT -->
</head>

<body>

<!-- APP WRAPPER -->
<div class="app">
    <!-- APP WRAPPER -->
    <div class="app">
        <!-- START APP CONTAINER -->
        <div class="app-container app-sidebar-left-minimized app-header-inside-content">
            <!-- START SIDEBAR -->
            <?php echo $sitebar?>
            <!-- END SIDEBAR -->
            <!-- START APP CONTENT -->
            <div class="app-content app-sidebar-left">
                <!-- START APP HEADER -->
                <?php echo $header?>
                <!-- END APP HEADER  -->

                <!-- START PAGE CONTAINER -->
                <?php echo $pagecontent?>
                <!-- END PAGE CONTAINER -->
            </div>
            <!-- END APP CONTENT -->
        </div>
        <!-- END APP CONTAINER -->
        <!-- START APP FOOTER -->
        <div class="app-footer app-footer-default" id="footer">
            <div class="app-footer-line darken">
                <div class="copyright wide text-center">&copy; 2016 Boooya. All right reserved in the Ukraine and other countries.</div>
            </div>
        </div>
        <!-- END APP FOOTER -->
        <!-- START APP SIDEPANEL -->
        <div class="app-sidepanel scroll" data-overlay="show">
            <div class="container">
                <div class="app-heading app-heading-condensed app-heading-small">
                    <div class="icon icon-lg"><span class="icon-alarm"></span>
                    </div>
                    <div class="title">
                        <h2>Notifications</h2>
                        <p><strong>7 new</strong>, latest: July 19, 2016 at 10:14:32.</p>
                    </div>
                </div>
                <div class="listing margin-bottom-10">
                    <div class="listing-item margin-bottom-10"><strong>Product Delivered</strong> <span class="label label-success pull-right">delivered</span>
                        <p class="margin-0 margin-top-5">#SPW-955-18 to st. StreetName SA, USA.</p>
                        <p class="text-muted"><span class="fa fa-truck margin-right-5"></span> 19/07/2016 10:14:32 AM</p>
                    </div>
                    <div class="listing-item margin-bottom-10"><strong>Successful Payment</strong> <span class="label label-success pull-right">success</span>
                        <p class="margin-0 margin-top-5">Payment for order #SPW-955-17: <strong>$145.44</strong>.</p>
                        <p class="text-muted"><span class="fa fa-bank margin-right-5"></span> 19/07/2016 09:55:12 AM</p>
                    </div>
                    <div class="listing-item margin-bottom-10"><strong>New Order #SPW-955-17</strong> <span class="label label-warning pull-right">waiting</span>
                        <p class="margin-0 margin-top-5">Added new order, waiting for payment. <a href="#">Order details</a>.</p>
                        <p class="text-muted"><span class="fa fa-bank margin-right-5"></span> 19/07/2016 09:51:55 AM</p>
                    </div>
                    <div class="listing-item margin-bottom-10"><strong>Money Back Request</strong> <span class="label label-primary pull-right">return</span>
                        <p class="margin-0 margin-top-5">#SPW-955-17 return requested. <a href="#">Request details</a>.</p>
                        <p class="text-muted"><span class="fa fa-bank margin-right-5"></span> 19/07/2016 08:44:51 AM</p>
                    </div>
                    <div class="listing-item margin-bottom-10"><strong>The critical amount of product</strong> <span class="label label-danger pull-right">important</span>
                        <p class="margin-0 margin-top-5">Product: <a href="#">Extra Awesome Product</a> (amount: <span class="text-danger">2</span>). <a href="#">Storehouse</a>.</p>
                        <p class="text-muted"><span class="fa fa-cube margin-right-5"></span> 19/07/2016 08:30:00 AM</p>
                    </div>
                    <div class="listing-item margin-bottom-10"><strong>Product Delivery Start</strong> <span class="label label-warning pull-right">delivering</span>
                        <p class="margin-0 margin-top-5">#SPW-955-18 to st. StreetName SA, USA.</p>
                        <p class="text-muted"><span class="fa fa-truck margin-right-5"></span> 18/07/2016 06:14:32 PM</p>
                    </div>
                    <div class="listing-item margin-bottom-10"><strong>Critical Server Load</strong> <span class="label label-danger pull-right">server</span>
                        <p class="margin-0 margin-top-5">Disk space: 248.1Gb/250Gb. <a href="#">Control panel</a>.</p>
                        <p class="text-muted"><span class="fa fa-truck margin-right-5"></span> 18/07/2016 06:14:32 PM</p>
                    </div>
                </div>
                <div class="row margin-bottom-30">
                    <div class="col-xs-6 col-xs-offset-3">
                        <button class="btn btn-default btn-block">All Notification</button>
                    </div>
                </div>
                <div class="app-heading app-heading-condensed app-heading-small margin-bottom-20">
                    <div class="icon icon-lg"><span class="icon-cog"></span>
                    </div>
                    <div class="title">
                        <h2>Settings</h2>
                        <p>Notification Settings</p>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2">
                            <label class="switch switch-sm margin-0">
                                <input type="checkbox" name="app_settings_1" checked="" value="0">
                            </label>
                        </div>
                        <div class="col-xs-10">
                            <label>Delivery Information</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2">
                            <label class="switch switch-sm margin-0">
                                <input type="checkbox" name="app_settings_2" checked="" value="0">
                            </label>
                        </div>
                        <div class="col-xs-10">
                            <label>Product Amount Information</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2">
                            <label class="switch switch-sm margin-0">
                                <input type="checkbox" name="app_settings_3" checked="" value="0">
                            </label>
                        </div>
                        <div class="col-xs-10">
                            <label>Order Information</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2">
                            <label class="switch switch-sm margin-0">
                                <input type="checkbox" name="app_settings_4" checked="" value="0">
                            </label>
                        </div>
                        <div class="col-xs-10">
                            <label>Server Load</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2">
                            <label class="switch switch-sm margin-0">
                                <input type="checkbox" name="app_settings_5" value="0">
                            </label>
                        </div>
                        <div class="col-xs-10">
                            <label>User Registrations</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2">
                            <label class="switch switch-sm margin-0">
                                <input type="checkbox" name="app_settings_6" value="0">
                            </label>
                        </div>
                        <div class="col-xs-10">
                            <label>Purchase Information</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END APP SIDEPANEL -->
        <!-- APP OVERLAY -->
        <div class="app-overlay"></div>
        <!-- END APP OVERLAY -->
    </div>
    <!-- END APP WRAPPER -->
    <!-- APP OVERLAY -->
    <div class="app-overlay"></div>
    <!-- END APP OVERLAY -->
</div>
<!-- END APP WRAPPER -->
<div id="loading" style="position:fixed;top: 0;width: 100%;height: 100%;text-align: center;display: table;background: #fff;opacity: 0.7;z-index: 10000" class="hidden">
    <span style="display: table-cell;vertical-align: middle">
        <img src="<?php echo DIR_IMAGE?>loading.gif" >
    </span>

</div>
<!-- MODAL SMALL -->
<div class="modal fade" id="modal-select-file" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-lg" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header">Select file</h4>
            </div>
            <div class="modal-body"></div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-product-listsamecode" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-default-header">
                    There are more than 1 product use this barcode <strong>xxxx</strong>.<br>
                    <strong>Please select which one you want to add to oder:</strong>
                </h4>
            </div>
            <div class="modal-body"></div>

        </div>
    </div>
</div>

<div class="modal fade" id="modal-basket-form" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-fw" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-default-header">Thêm chuyến đi</h4>
            </div>
            <div class="modal-body">
                <form id="frmBasket">
                    <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">

                    <div class="col-md-6 col-md-offset-3">
                        <div class="form-group">
                            <label class="col-md-3 control-label">Chuyến đi</label>
                            <div class="col-md-9">
                                <select class="bs-select" id="tourid" name="tourid">
                                    <option value=""></option>
                                    <?php foreach($tours as $tour){ ?>
                                    <option value="<?php echo $tour['id']?>"><?php echo $tour['tourname']?>(<?php echo $tour['listlocation']?>)</option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Buổi</label>
                            <div class="col-md-9">
                                <div class="radio">
                                    <label><input type="radio" name="basketname" class="basketname" value="morning" checked><?php echo $text_shipwhen['morning']?></label>
                                    <label><input type="radio" name="basketname" class="basketname" value="afternoon"><?php echo $text_shipwhen['afternoon']?></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Ngày giờ</label>
                            <div class="col-md-3">
                                <input type="text" class="form-control input-sm bs-datepicker" id="shipdate" name="shipdate" value="<?php echo $this->date->formatMySQLDate($this->date->getToday());?>">
                            </div>
                            <div class="col-md-2">
                                <select class="bs-select" id="hours" name="hours">
                                    <option value="00">12</option>
                                    <?php for($i=1;$i<=11;$i++){ ?>
                                    <option value="<?php echo $this->date->numberFormate($i)?>"><?php echo $this->date->numberFormate($i)?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="bs-select" id="minute" name="minute">
                                    <option value="00">00</option>
                                    <?php for($i=1;$i<=12;$i++){ ?>
                                    <option value="<?php echo  $this->date->numberFormate($i*5)?>"><?php echo  $this->date->numberFormate($i*5)?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="bs-select" name="session" id="session">
                                    <option value="AM">AM</option>
                                    <option value="PM">PM</option>

                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Giao bởi</label>
                            <div class="col-md-9">
                                <select class="bs-select" id="shipby" name="shipby">
                                    <option value=""></option>
                                    <?php foreach($staffs as $staff){ ?>
                                    <option value="<?php echo $staff['cardid']?>" <?php echo $basket['shipby']==$staff['cardid']?'selected':'' ?>><?php echo $staff['fullname']?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Ghi chú</label>
                            <div class="col-md-9">
                                <textarea class="form-control input-sm" id="shipnotes" name="shipnotes"><?php echo $basket['shipnotes']?></textarea>
                            </div>
                        </div>
                </form>
            </div>
            <div class="modal-body text-center">
                <button type="button" class="btn btn-primary" id="btnSaveBasket">Lưu chuyến đi</button>
                <button type="button" class="btn btn-success" data-dismiss="modal">Đóng</button>

            </div>
        </div>
    </div>
</div>
<!-- END MODAL SMALL -->
</body>
</html>
