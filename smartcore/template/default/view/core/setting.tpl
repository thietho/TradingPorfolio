<div class="container">
    <div id="module-title" class="pull-left">
        Setting
    </div>
    <div id="module-path" class="pull-right">
        <?php echo $text_home?> / Setting
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmSetting">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Company Long Name </label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="companylongname" id="companylongname" placeholder="Company Long Name"
                                   value="<?php echo $item['companylongname'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_company_name?> Line 2</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="companyname" id="companyname" placeholder="<?php echo $text_company_name?>"
                                   value="<?php echo $item['companyname'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Logo(249x80)</label>
                        <div class="col-md-9">
                            <img id="imglogo" width="auto" src="<?php echo DIR_USERIMAGE ?>fixsize-249x80/<?php echo $item['logo'] ?>" />

                            <button type="button" id="btnRemoveLogo" class="btn btn-default btn-sm"><span class="fa fa-trash-o"></span></button>
                            <button type="button" class="btn btn-sm" id="btnSelectLogo">
                                <span class="icon-picture3"></span> <?php echo $text_select_image?>
                            </button>
                            <input type="hidden" name="logo" id="logo" value="<?php echo $item['logo']?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_address_line_1?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="addressline1" id="addressline1" placeholder="<?php echo $text_address_line_1?>"
                                   value="<?php echo $item['addressline1'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_address_line_2?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="addressline2" id="addressline2" placeholder="<?php echo $text_address_line_2?>"
                                   value="<?php echo $item['addressline2'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_phone?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="phone" id="phone" placeholder="<?php echo $text_phone?>"
                                   value="<?php echo $item['phone'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Hotline</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="hotline" id="hotline" placeholder="Hotline"
                                   value="<?php echo $item['hotline'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Fax</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="fax" id="fax" placeholder="Fax"
                                   value="<?php echo $item['fax'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Email</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="email" id="email" placeholder="Email"
                                   value="<?php echo $item['email'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Website</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="website" id="website" placeholder="Website"
                                   value="<?php echo $item['website'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">FB</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="facebook" id="facebook" placeholder="Facebook"
                                   value="<?php echo $item['facebook'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Bill footer</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="billfooter" id="billfooter" placeholder="Bill footer"
                                   value="<?php echo $item['billfooter'] ?>">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Currency</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="currency" id="currency" placeholder="Currency"
                                   value="<?php echo $item['currency'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Currency Format</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control input-sm"
                                   name="currencyprefix" id="currencyprefix" placeholder="Currency Prefix"
                                   value="<?php echo $item['currencyprefix'] ?>">
                        </div>

                        <div class="col-md-4">
                            <input type="text" class="form-control input-sm"
                                   name="currencysubfix" id="currencysubfix" placeholder="Currency Subfix"
                                   value="<?php echo $item['currencysubfix'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Software Version</label>
                        <label class="col-md-9 control-label" id="lb-softwareversion"><?php echo $item['version']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Storage Used</label>
                        <label class="col-md-9 control-label" id="lb-storageused"><?php echo $item['storageused']?>M</label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Last Backup Date</label>
                        <label class="col-md-7 control-label" id="lb-lastbackupdate">17-04-2017</label>
                        <!--<div class="col-md-2">
                            <button class="btn btn-default btn-sm form-control" type="button">Backup</button>
                        </div>-->
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Last Verified Date</label>
                        <label class="col-md-7 control-label" id="lb-lastbackupdate">17-04-2017</label>
                        <!--<div class="col-md-2">
                            <button class="btn btn-default btn-sm form-control" type="button">Verify</button>
                        </div>-->
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Current Financial Year End</label>
                        <label class="col-md-9 control-label" id="lb-currentfinancialyearend"><?php echo $item['currentfinancialyearend']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Locked Period</label>
                        <label class="col-md-9 control-label" id="lb-lockedperiod"><?php echo $item['lockedperiod']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Created Users</label>
                        <label class="col-md-9 control-label" id="lb-userlimt"><?php echo $item['countuser']?>/<?php echo $item['userlimt']?></label>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">Created Stock</label>
                        <label class="col-md-9 control-label" id="lb-stocklimt"><?php echo $item['countstore']?>/<?php echo $item['stocklimt']?></label>
                    </div>
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveSetting">Update</button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=common/dashboard'" type="button" class="btn btn-sm btn-default btn-bg"><?php echo $text_cancel?></button>
                </div>
            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->
<script type="text/javascript">
    $('#btnSaveSetting').click(function(){
        showLoading();
        $.post("?route=core/setting/save",$('#frmSetting').serialize(),function(data){
            endLoading();
            var obj = $.parseJSON(data)
            if(obj.errorstext != '')
            {
                toastr.error(obj.errorstext,"<?php echo $text_errors?>");
            }
            else
            {
                toastr.options.onHidden = function() { window.location.reload()};
                toastr.success('Setting has been save', '<?php echo $text_save_success?>', {timeOut: 1000});
            }

        });
    });
    $('#btnSelectLogo').click(function(){
        $('#modal-select-file').modal();
        var folder = "setting";
        $('#modal-select-file .modal-body').load('?route=core/uploadfile&folder='+folder+"&eid=logo&size=249x80&output=fixsize",function(){

        });
    });
    $('#btnRemoveLogo').click(function () {
        $('#frmSetting #imglogo').attr('src','');
        $('#frmSetting #logo').val('');
    });
</script>