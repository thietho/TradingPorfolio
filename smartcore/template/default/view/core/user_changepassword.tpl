<div class="app-heading app-heading-bordered app-heading-page">
    <div class="icon icon-lg"><span class="icon-key"></span></div>
    <div class="title">
        <h2><?php echo $item['fullname']?></h2>
        <p><?php echo $text_change_password?></p>
    </div>

</div>

<div class="container container-boxed">

    <!-- START BLOCk -->
    <div class="block">
        <div class="row margin-top-15">
            <form class="form-horizontal" id="frmUserChangePassword">

                <div class="row">
                    <div class="col-md-6 col-md-offset-3">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-md-4 control-label">Current Password</label>
                                <div class="col-md-8">
                                    <input type="password" class="form-control" name="oldpassword" maxlength="30">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label">New Password</label>
                                <div class="col-md-8">
                                    <input type="password" class="form-control" name="password" maxlength="30">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label"><?php echo $text_confirm_password?></label>
                                <div class="col-md-8">
                                    <input type="password" class="form-control" name="confirmpassword" maxlength="30">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 col-md-offset-3 margin-top-30">
                        <div class="text-center">
                            <button id="btnChangePassword" type="button" class="btn btn-default btn-bg btn-info">Update</button>
                            <button onclick="window.history.back(-1)" type="button" class="btn btn-default btn-bg"><?php echo $text_cancel?></button>
                        </div>
                    </div>
                </div>

            </form>

        </div>

    </div>
    <!-- END BLOCk -->
</div>
<script type="text/javascript">


$('#btnChangePassword').click(function(){
    showLoading();
    $.post("?route=core/user/actionchangepass",$('#frmUserChangePassword').serialize(),function(data){
        endLoading();
        var obj = $.parseJSON(data)
        if(obj.errorstext != '')
        {
            toastr.error(obj.errorstext,"<?php echo $text_errors?>");
        }
        else
        {
            toastr.options.onHidden = function() { history.back() }
            toastr.success('Password has been change', '<?php echo $text_save_success?>', {timeOut: 1000})
        }

    });
});



</script>