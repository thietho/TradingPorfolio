
<div class="container">
    <div id="module-title" class="pull-left">
        <?php echo $text_set_account?>
    </div>
    <div id="module-path" class="pull-right">
        <?php echo $text_home?> / <?php echo $text_card_list?> /
        <?php echo $text_set_account?>
    </div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmCardSetAccount">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                <input type="hidden" id="cardid" name="cardid" value="<?php echo $item['cardid'] ?>">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_card_type?></label>
                        <div class="col-md-9">
                            <label class="control-label"><?php echo $this->document->cardtype[$item['cardtype']]?></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_first_name?></label>
                        <div class="col-md-9">
                            <label class="control-label"><?php echo $item['firstname'] ?></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_last_name?></label>
                        <div class="col-md-9">
                            <label class="control-label"><?php echo $item['lastname'] ?></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Email</label>
                        <div class="col-md-9">
                            <label class="control-label"><?php echo $item['email'] ?></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_telephone?></label>
                        <div class="col-md-9">
                            <label class="control-label"><?php echo $item['telephone'] ?></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_mobile_phone?></label>
                        <div class="col-md-9">
                            <label class="control-label"><?php echo $item['mobilephone'] ?></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_address_line_1?></label>
                        <div class="col-md-9">
                            <label class="control-label"><?php echo $item['addressline1'] ?></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_address_line_2?></label>
                        <div class="col-md-9">
                            <label class="control-label"><?php echo $item['addressline2'] ?></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_image?></label>
                        <div class="col-md-9">
                            <img id="imgimage" width="auto" height="64" src="<?php echo DIR_USERIMAGE ?>autosize-0x64/<?php echo $item['image'] ?>" />
                        </div>
                    </div>
                </div>
                <?php if($allowadduser){ ?>
                <div class="col-md-6">

                    <?php if($item['account'] == ''){ ?>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_usertype?></label>
                        <div class="col-md-9">
                            <select class="bs-select" name="usertypeid">
                                <?php foreach($usertypes as $usertype) { ?>
                                <option value="<?php echo $usertype['usertypeid'] ?>" <?php echo $user['usertypeid'] == $usertype['usertypeid'] ? 'selected' : '' ?>><?php echo $usertype['usertypename'] ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_user_name?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="username" id="username" placeholder="<?php echo $text_user_name?>"
                                   value="<?php echo $item['username']?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_password?></label>
                        <div class="col-md-9">
                            <input type="password" class="form-control input-sm"
                                   name="password" id="password" placeholder="<?php echo $text_password?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_confirm_password?></label>
                        <div class="col-md-9">
                            <input type="password" class="form-control input-sm"
                                   name="confirmpassword" id="confirmpassword" placeholder="<?php echo $text_confirm_password?>">
                        </div>
                    </div>
                    <?php }else{ ?>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_usertype?></label>
                        <div class="col-md-9">
                            <select class="bs-select" name="usertypeidupdate">
                                <?php foreach($usertypes as $usertype) { ?>
                                <option value="<?php echo $usertype['usertypeid'] ?>" <?php echo $user['usertypeid'] == $usertype['usertypeid'] ? 'selected' : '' ?>><?php echo $usertype['usertypename'] ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_account?></label>
                        <div class="col-md-9">
                            <label class="control-label"><?php echo $item['account']?></label>
                        </div>
                    </div>
                    <?php } ?>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_store?></label>
                        <div class="col-md-9">
                            <button type="button" class="btn btn-small btn-success" id="btnSearchStore"><span class="fa fa-search"></span></button>
                            <ul id="list-store"></ul>
                        </div>
                        <input type="hidden" id="delcardstoreid" name="delcardstoreid">
                    </div>

                </div>
                <?php }else{ ?>
                <div class="col-md-6">
                    <?php echo $text_out_of_user?>
                </div>
                <?php }?>
            </form>
        </div>
        <?php if($allowadduser){ ?>
        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveCardSetAccount">
                        <?php echo $item['id'] == '' ? $text_insert : $text_update ?>
                    </button>
                    <button id="btnCancelCard" type="button" class="btn btn-sm btn-default btn-bg"><?php echo $text_cancel?></button>
                </div>
            </div>
        </div>
        <?php } ?>
    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->

<script type="application/javascript">
<?php if(count($cardstores)) foreach($cardstores as $cardstore){ ?>
    addStore("<?php echo $cardstore['id']?>","<?php echo $cardstore['storeid']?>","<?php echo $cardstore['storename']?>");
<?php } ?>

    $('#btnSaveCardSetAccount').click(function(){
        showLoading();
        $.post("?route=module/card/saveSetAccount",$('#frmCardSetAccount').serialize(),function(data){
            endLoading();
            var obj = $.parseJSON(data)
            if(obj.errorstext != '')
            {
                toastr.error(obj.errorstext,"<?php echo $text_errors?>");
            }
            else
            {
                toastr.options.onHidden = function() { window.location = '?route=module/card'};
                toastr.success('Card has been save', '<?php echo $text_save_success?>', {timeOut: 1000});
            }

        });
    });
    $('#btnCancelCard').click(function(){
        window.location.href='<?php echo HTTP_WEB ?>?route=module/card';
    });



    function addStore(id,storeid,name)
    {
        var str = '<li><input type="hidden" name="cardstoreid[]" value="'+id+'"><input type="hidden" name="storeid[]" value="'+storeid+'">'+name+'<button type="button" cardstoreid="'+id+'"  class="btn btn-small btn-danger btnRemoveStore"><span class="fa fa-trash"></span></button></li>';
        $('#list-store').append(str);

        $('.btnRemoveStore').click(function(){

            var list = $('#delcardstoreid').val();
            var cardstoreid = $(this).attr('cardstoreid');
            if(cardstoreid!='')
                list += cardstoreid+",";
            $('#delcardstoreid').val(list);
            $(this).parent().remove();


        });
    }
</script>
<div class="modal fade" id="modal-store-list" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-fw" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-default-header">List store</h4>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnAddCard" onclick="addCard()"><span class="fa fa-plus"></span> <?php echo $text_add_card?></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-store-form" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-fw" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-default-header">Store infomation</h4>
            </div>
            <div class="modal-body"></div>

        </div>
    </div>
</div>