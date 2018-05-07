<!-- START PAGE HEADING -->
<?php if($_GET['route'] == 'core/user/insert') { ?>
<div class="app-heading app-heading-bordered app-heading-page">
    <div class="icon icon-lg"><span class="icon-clipboard-text"></span></div>
    <div class="title">
        <h2>New user</h2>
        <p>User information management</p>
    </div>
</div>
<?php } else { ?>
<!-- START PAGE HEADING -->
<div class="app-heading app-heading-bordered app-heading-page">
    <div class="icon icon-lg"><span class="icon-clipboard-text"></span></div>
    <div class="title">
        <h2><?php echo $text_edit?> user</h2>
        <p>User information management</p>
    </div>
</div>
<?php } ?>



<!-- START PAGE CONTAINER -->
<div class="container container-boxed">
    <!-- START BLOCk -->
    <div class="block">
        <div class="row margin-top-15">
            <form id="frmform" class="form-horizontal form-bordered" role="form" enctype="multipart/form-data" method="post" name="frm">
                <input id="userid" type="hidden" name="userid" value="<?php echo $user['userid']?>"/>

                <div class="col-md-6 col-md-offset-3">
                    <div class="form-group">
                        <label class="col-md-4 control-label">User type</label>
                        <div class="col-md-8">
                            <select class="form-control input-control" name="usertypeid">
                                <?php foreach($usertypes as $usertype) { ?>
                                <option value="<?php echo $usertype['usertypeid'] ?>" <?php echo $user['usertypeid'] == $usertype['usertypeid'] ? 'selected' : '' ?>><?php echo $usertype['usertypename'] ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">Name</label>
                        <div class="col-md-8">

                            <input id="fullname" class="form-control input-control" placeholder="Name" name="fullname" value="<?php echo $user['fullname']?>" type="text">
                            <span class="fullname-required help-block hide"><?php echo $lang_err_fullname_required ?></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label"><?php echo $text_user_name?></label>
                        <div class="col-md-8">

                            <input id="username" type="text" class="form-control input-control" placeholder="<?php echo $text_user_name?>" name="username" maxlength="100"
                                   value="<?php echo $user['username']?>" <?php echo isset($this->request->get['userid']) ? 'readonly' : '' ?>>
                            <span class="username-required help-block hide"><?php echo $lang_err_username_required ?></span>
                            <span class="username-used help-block hide"><?php echo $lang_err_username_used ?></span>
                        </div>
                    </div>

                    <?php if($isInsert) { ?>
                    <div class="form-group">
                        <label class="col-md-4 control-label"><?php echo $text_password?></label>
                        <div class="col-md-8">
                            <input id="password" type="password" class="form-control input-control" placeholder="<?php echo $text_password?>" name="password" maxlength="100" value="">
                            <span class="password-required help-block hide"><?php echo $lang_err_password_required ?></span>
                            <span class="password-length help-block hide"><?php echo $lang_err_password_length ?></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label"><?php echo $text_confirm_password?></label>
                        <div class="col-md-8">
                            <input id="confirmpassword" type="password" class="form-control input-control" placeholder="<?php echo $text_confirm_password?>" name="confirmpassword" maxlength="100" value="">
                            <span class="confirmpassword-required help-block hide"><?php echo $lang_err_confirmpassword_required ?></span>
                            <span class="confirmpassword-length help-block hide"><?php echo $lang_err_password_length ?></span>
                            <span class="confirmpassword-match help-block hide"><?php echo $lang_err_password_match ?></span>
                        </div>
                    </div>
                    <?php } ?>


                    <div class="form-group">
                        <label class="col-md-4 control-label">Email</label>
                        <div class="col-md-8">
                            <input id="email" type="text" class="form-control input-control" placeholder="Email" name="email" maxlength="100" value="<?php echo $user['email']?>">
                            <span class="email-required help-block hide"><?php echo $lang_err_email_required ?></span>
                            <span class="email-invalid help-block hide"><?php echo $lang_err_email_invalid ?></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label"><?php echo $text_phone?></label>
                        <div class="col-md-8">
                            <input id="phone" type="text" class="form-control input-control" placeholder="<?php echo $text_phone?>" name="phone" maxlength="100" value="<?php echo $user['phone']?>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-4 control-label">Avatar</label>
                        <div class="col-md-8">

                            <!--
                            <img class="margin-right-10" width="50" src="<?php echo DIR_IMAGE ?>no-image.png">
                            <button type="button" class="btn btn-sm btn-primary btn-icon"><span class="fa fa-pencil"></span></button>
                            <button type="button" class="btn btn-sm btn-info btn-icon"><span class="fa fa-refresh"></span></button>
                            -->

                            <input id="imagepath" type="hidden" name="imagepath" value="<?php echo $user['imagepath'] ?>" />
                            <img id="imgimagepath" width="auto" height="64" src="<?php echo DIR_USERIMAGE ?>autosize-0x64/<?php echo $user['imagepath'] ?>" />



                            <button type="button" class="btn btn-sm btn-default btn-bg btn-success" id="btnSelectImage"><?php echo $text_select?></button>
                            <button type="button" class="btn btn-sm btn-info btn-icon" id="btnRemoveImage"><span class="fa fa-trash"></span></button>


                            <p>
                                <input id="avatar-qu-oldimagepath" type="hidden" imageupload="<?php echo $user['imagepath'] ?>" value="images/autosize-0x64/<?php echo $user['imagepath'] ?>">
                                <input id="avatar-qu-fileupload" type="file" style="display:none" name="files[]" data-url="<?php echo UPLOAD_SERVER ?>file_<?php echo SKINID ?>/file/quickupload.php" accept="image/*; capture=camera">
                            </p>

                        </div>
                    </div>


                </div>


            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg btn-success" onclick="save()"><?php echo $isInsert ? '<?php echo $text_insert?>' : '<?php echo $text_update?>' ?></button>
                    <button onclick="window.location = '?route=core/user'" type="button" class="btn btn-sm btn-default btn-bg"><?php echo $text_cancel?></button>
                </div>
            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->



<script type="application/javascript">
    var $jUserId = $('#userid');
    var $jUsername = $('#username');
    var $jFullname = $('#fullname');
    var $jEmail = $('#email');
    var $jPassword = $('#password');
    var $jConfirmPassword = $('#confirmpassword');

    $('#frmform #btnSelectImage').click(function(){
        $('#modal-select-file').modal();
        var folder = "user";
        if($('#frmMovies #id').val() == '')
            folder += "/temp"+ Date.now() ;
        else
            folder += "/"+$('#frmform #userid').val();
        $('#modal-select-file .modal-body').load('?route=core/uploadfile&folder='+folder+"&eid=imagepath",function(){

        });
    });
    $('#frmform #btnRemoveImage').click(function(){
        $('#frmform #imagepath').val('');
        $('#frmform #imgimagepath').attr('src',"<?php echo DIR_USERIMAGE ?>autosize-0x64/default/default.png");
    });
    function showError($jSelector, $classHelp) {
        $jSelector.parent().addClass('has-error');
        $jSelector.siblings("." + $classHelp).removeClass('hide');
        $jSelector.siblings("." + $classHelp).addClass('show');
    }

    function hideError($jSelector, $classHelp) {
        $jSelector.parent().removeClass('has-error');
        $jSelector.siblings("." + $classHelp).removeClass('show');
        $jSelector.siblings("." + $classHelp).css('hide');
    }


    function save() {
        //validate form
        if(validate_form()) {
            showLoading();
            $.post("?route=core/user/save", $("#frmform").serialize(), function($data) {
                endLoading();
                var $response = JSON.parse($data);
                var $errors = $response['errors'];
                if($response['status'] == 'failed') {
                    for (var $error_code in $errors) {
                        if ($errors.hasOwnProperty($error_code)) {
                            if($error_code == 'username') {
                                showError($jUsername, 'username-required');
                            }
                            if($error_code == 'fullname') {
                                showError($jFullname, 'fullname-required');
                            }
                            if($error_code == 'email-required') {
                                showError($jEmail, 'email-required');
                            }
                            if($error_code == 'email-invalid') {
                                showError($jEmail, 'email-invalid');
                            }

                            if($error_code == 'username-used') {
                                showError($jUsername, 'username-used');
                            }
                            if($error_code == 'password-required') {
                                showError($jPassword, 'password-required');
                            }
                            if($error_code == 'password-length') {
                                showError($jPassword, 'password-length');
                            }
                            if($error_code == 'confirmpassword-required') {
                                showError($jConfirmPassword, 'confirmpassword-required');
                            }
                            if($error_code == 'confirmpassword-match') {
                                showError($jConfirmPassword, 'confirmpassword-match');
                            }
                        }
                    }
                    $("html, body").animate({ scrollTop: 0 }, "fast");
                    toastr.error('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');

                } else {
                    //toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');
                    window.location.href = "?route=core/user";

                }
            });
        }
    }


    function validate_form() {
        var $isValid = true;
        var $userid = $jUserId.val().trim();
        var $username = $jUsername.val().trim();
        var $fullname = $jFullname.val().trim();
        var $email = $jEmail.val().trim();


        if(0 == $username.length) {
            showError($jUsername, 'username-required');
            $isValid = false;
        } else {
            hideError($jUsername, 'username-required');
        }

        if(0 == $fullname.length) {
            showError($jFullname, 'fullname-required');
            $isValid = false;
        } else {
            hideError($jFullname, 'fullname-required');
        }

        if(0 == $email.length) {
            showError($jEmail, 'email-required');
            $isValid = false;
        } else {
            hideError($jEmail, 'email-required');

            //check email valid
            if(!validateEmail($email)) {
                showError($jEmail, 'email-invalid');
                $isValid = false;
            } else {
                hideError($jEmail, 'email-invalid');
            }
        }

        //check for case insert new user
        if(0 == $userid.length) {
            var $password = $jPassword.val().trim();
            var $confirmpassword = $jConfirmPassword.val().trim();

            if(0 == $password.length) {
                showError($jPassword, 'password-required');
                $isValid = false;
            } else {
                hideError($jPassword, 'password-required');
            }

            if(5 > $password.length) {
                showError($jPassword, 'password-length');
                $isValid = false;
            } else {
                hideError($jPassword, 'password-length');
            }

            if(0 == $confirmpassword.length) {
                showError($jConfirmPassword, 'confirmpassword-required');
                $isValid = false;
            } else {
                hideError($jConfirmPassword, 'confirmpassword-required');
            }

            if(5 > $confirmpassword.length) {
                showError($jConfirmPassword, 'confirmpassword-length');
                $isValid = false;
            } else {
                hideError($jConfirmPassword, 'confirmpassword-length');
            }

            if($confirmpassword.length >= 5 && $password.length >= 5) {
                if($confirmpassword != $password) {
                    showError($jConfirmPassword, 'confirmpassword-match');
                    $isValid = false;
                } else {
                    hideError($jConfirmPassword, 'confirmpassword-match');
                }
            }

        }

        return $isValid;
    }



</script>







<!--
<section>
    <div class="section-header">
        <h3 class="text-standard text-uppercase"><strong><?php echo $lang_text_user_mangament ?></strong></h3>
    </div>
    <div class="section-body">
        <div class="row">
            <div class="col-md-3 pull-right clearfix">
                <div class="panel-heading text-right">
                    
                    <button type="button" class="btn btn-primary" onclick="save()"><span class="fa fa-save"></span> <?php echo $lang_text_save ?></button>
                    <button type="button" class="btn btn-danger" onclick="window.location = '?route=core/user'"><span class="fa fa-backward"></span> <?php echo $lang_text_cancel ?></button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-head">
                        <header class="col-md-12 error-message hidden"></header>
                    </div>
                </div>
            </div>

            <form id="frmform" class="form-horizontal form-bordered" role="form" enctype="multipart/form-data" method="post" name="frm">
                <input id="userid" type="hidden" name="userid" value="<?php echo $user['userid']?>"/>

                <div class="col-md-12">
                    <div class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><i class="fa fa-user" aria-hidden="true"></i>&nbsp;<?php echo $lang_text_user_info ?></h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse in" style="height: auto;">
                                <div class="panel-body">

                                    <div class="form-group">
                                        <div class="col-lg-2 col-md-2 col-sm-12">
                                            <label class="control-label required" for="username"><?php echo $lang_text_user_type ?></label>
                                        </div>
                                        <div class="col-lg-10 col-md-10 col-sm-12">
                                            <select id="usertypeid" name="usertypeid" class="form-control control-width-medium">
                                                <?php foreach($usertypes as $usertype) { ?>
                                                <option value="<?php echo $usertype['usertypeid'] ?>" <?php echo $user['usertypeid'] == $usertype['usertypeid'] ? 'selected' : '' ?>><?php echo $usertype['usertypename'] ?></option>
                                                <?php } ?>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-lg-2 col-md-2 col-sm-12">
                                            <label class="control-label required" for="username"><?php echo $lang_text_user_account ?></label>
                                        </div>
                                        <div class="col-lg-10 col-md-10 col-sm-12">
                                            <input id="username" class="form-control control-width-large" type="text" name="username" maxlength="100"
                                                   value="<?php echo $user['username']?>" <?php echo isset($this->request->get['userid']) ? 'readonly' : '' ?>>
                                            <span class="username-required help-block hidden"><?php echo $lang_err_username_required ?></span>
                                            <span class="username-used help-block hidden"><?php echo $lang_err_username_used ?></span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-lg-2 col-md-2 col-sm-12">
                                            <label class="control-label required" for="fulname"><?php echo $lang_text_user_name ?></label>
                                        </div>
                                        <div class="col-lg-10 col-md-10 col-sm-12">
                                            <input id="fullname" class="form-control control-width-large" type="text" name="fullname" maxlength="100" value="<?php echo $user['fullname']?>">
                                            <span class="fullname-required help-block hidden"><?php echo $lang_err_fullname_required ?></span>
                                        </div>
                                    </div>


                                    <?php if($isInsert) { ?>
                                    <div class="form-group">
                                        <div class="col-lg-2 col-md-2 col-sm-12">
                                            <label class="control-label required" for="password"><?php echo $lang_text_user_password ?></label>
                                        </div>
                                        <div class="col-lg-10 col-md-10 col-sm-12">
                                            <input id="password" class="form-control control-width-large" type="password" name="password" maxlength="100" value="">
                                            <span class="password-required help-block hidden"><?php echo $lang_err_password_required ?></span>
                                            <span class="password-length help-block hidden"><?php echo $lang_err_password_length ?></span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-lg-2 col-md-2 col-sm-12">
                                            <label class="control-label required" for="confirmpassword"><?php echo $lang_text_user_confirmpassword ?></label>
                                        </div>
                                        <div class="col-lg-10 col-md-10 col-sm-12 confirm">
                                            <input id="confirmpassword" class="form-control control-width-large" type="password" name="confirmpassword" maxlength="100" value="">
                                            <span class="confirmpassword-required help-block hidden"><?php echo $lang_err_confirmpassword_required ?></span>
                                            <span class="confirmpassword-length help-block hidden"><?php echo $lang_err_password_length ?></span>
                                            <span class="confirmpassword-match help-block hidden"><?php echo $lang_err_password_match ?></span>
                                        </div>
                                    </div>
                                    <?php } ?>


                                    <div class="form-group">
                                        <div class="col-lg-2 col-md-2 col-sm-12">
                                            <label class="control-label required" for="email"><?php echo $lang_text_user_email ?></label>
                                        </div>
                                        <div class="col-lg-10 col-md-10 col-sm-12">
                                            <input id="email" class="form-control control-width-large text-lowercase" type="text" name="email" maxlength="100" value="<?php echo $user['email']?>">
                                            <span class="email-required help-block hidden"><?php echo $lang_err_email_required ?></span>
                                            <span class="email-invalid help-block hidden"><?php echo $lang_err_email_invalid ?></span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-lg-2 col-md-2 col-sm-12">
                                            <label class="control-label" for="phone"><?php echo $lang_text_user_phone ?></label>
                                        </div>
                                        <div class="col-lg-10 col-md-10 col-sm-12">
                                            <input id="phone" class="form-control control-width-large" type="text" name="phone" maxlength="100" value="<?php echo $user['phone']?>">
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </form>
        </div>
    </div>
</section>
-->