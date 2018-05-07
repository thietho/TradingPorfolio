<div class="container">
    <div id="module-title" class="pull-left">
        Profile
    </div>
    <div id="module-path" class="pull-right">
        <?php echo $text_home?> / <?php echo $text_card_list?> / Profile
    </div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmCard">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                <input type="hidden" id="cardid" name="cardid" value="<?php echo $item['cardid'] ?>">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_card_type?></label>
                        <div class="col-md-9">
                            <select id="cardtype" name="cardtype" class="bs-select">
                                <?php foreach($this->document->cardtype as $type => $name){ ?>
                                <option value="<?php echo $type?>"><?php echo $name?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_first_name?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="firstname" id="firstname" placeholder="<?php echo $text_first_name?>"
                                   value="<?php echo $item['firstname'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_last_name?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="lastname" id="lastname" placeholder="<?php echo $text_last_name?>"
                                   value="<?php echo $item['lastname'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_company_name?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="companyname" id="companyname" placeholder="<?php echo $text_company_name?>"
                                   value="<?php echo $item['companyname'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_taxcode?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="taxcode" id="taxcode" placeholder="<?php echo $text_tax_code?>"
                                   value="<?php echo $item['taxcode'] ?>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_image?></label>
                        <div class="col-md-9">
                            <input type="hidden" name="image" id="image" value="<?php echo $item['image']?>">
                            <img id="imgimage" width="auto" height="64" src="<?php echo DIR_USERIMAGE ?>autosize-0x64/<?php echo $item['image'] ?>" />

                            <button type="button" class="btn btn-sm btn-default btn-bg btn-success" id="btnSelectImage"><?php echo $text_select?></button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_price_level?></label>
                        <div class="col-md-9">
                            <select id="levelcode" name="levelcode" class="bs-select">
                                <option value=""></option>
                                <?php foreach($pricelevels as $pricelevel){ ?>
                                <option value="<?php echo $pricelevel['levelcode']?>"><?php echo $pricelevel['levelname']?></option>
                                <?php }?>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Email</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="email" id="email" placeholder="Email"
                                   value="<?php echo $item['email'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_telephone?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="telephone" id="telephone" placeholder="<?php echo $text_telephone?>"
                                   value="<?php echo $item['telephone'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_mobile_phone?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="mobilephone" id="mobilephone" placeholder="<?php echo $text_mobile_phone?>"
                                   value="<?php echo $item['mobilephone'] ?>">
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
                        <label class="col-md-3 control-label"><?php echo $text_birthdate?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm bs-datepicker"
                                   name="birthdate" id="birthdate" placeholder="<?php echo $text_birthdate?>"
                                   value="<?php echo $this->date->formatMySQLDate($item['birthdate']) ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_notes?></label>
                        <div class="col-md-9">
                            <textarea type="text" class="form-control input-sm"
                                   name="notes" id="notes" placeholder="<?php echo $text_notes?>"><?php echo $item['notes'] ?></textarea>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveCard">
                        <?php echo $item['id'] == '' ? $text_insert : $text_update ?>
                    </button>
                    <button id="btnCancelCard" type="button" class="btn btn-sm btn-default btn-bg"><?php echo $text_cancel?></button>
                </div>
            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->

<script type="application/javascript">
$('#frmCard #cardtype').val("<?php echo $item['cardtype']?>");
$('#frmCard #cardtype').selectpicker('refresh');
$('#frmCard #levelcode').val("<?php echo $item['levelcode']?>");
$('#frmCard #levelcode').selectpicker('refresh');
    <?php if($_GET['type'] != 'popup'){ ?>
        $('#btnSaveCard').click(function(){
            showLoading();
            $.post("?route=module/card/save",$('#frmCard').serialize(),function(data){
                endLoading();
                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"<?php echo $text_errors?>");
                }
                else
                {

                    toastr.options.onHidden = function() { window.history.back()};
                    toastr.success('Card has been save', '<?php echo $text_save_success?>', {timeOut: 1000});
                }

            });
        });
        $('#btnCancelCard').click(function(){
            //window.location.href='<?php echo HTTP_WEB ?>?route=module/card';
            window.history.back();
        });
    <?php } ?>
    $('#btnSelectImage').click(function(){
        $('#modal-select-file').modal();
        var folder = "card";
        if($('#frmCard #cardid').val() == '')
            folder += "/temp"+ Date.now() ;
        else
            folder += "/"+$('#frmCard #cardid').val();
        $('#modal-select-file .modal-body').load('?route=core/uploadfile&folder='+folder+"&eid=image",function(){

        });
    });
</script>