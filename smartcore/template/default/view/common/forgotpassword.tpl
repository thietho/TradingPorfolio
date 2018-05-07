<!-- START APP CONTAINER -->
<div class="app-container" style="width: 100%; height: 100%; background: url('<?php echo DIR_IMAGE ?>bg-1.jpg') center center no-repeat; background-size:cover">
    <div class="app-login-box">
        <div class="app-login-box-title margin-top-30">
            <div class="title">Forgot your password?</div>
            <div class="subtitle">Please enter your registered email address, the system will automatic send a new password to your email.</div>
        </div>
        <div class="app-login-box-container">

            <form action="" method="post">
                <div class="input-group">
                    <span class="input-group-addon icon-envelope"></span>
                    <input type="text" class="form-control" placeholder="Email" name="email">
                </div>

                <?php if(isset($error)) { ?>
                <div id="error" class="form-group">
                    <span class="text-danger"><?php echo $error ?></span>
                </div>
                <?php } ?>

                <div class="form-group">
                    <div class="row">
                        <div class="col-md-12 col-xs-12">
                            <button class="btn btn-lg btn-success btn-block margin-top-10" type="submit">Reset Password</button>
                        </div>
                    </div>
                </div>
            </form>


        </div>
        <div class="app-login-box-footer">&copy; FMRA 2016. All rights reserved.</div>
    </div>
</div>
<!-- END APP CONTAINER -->


<!-- MODAL SMALL -->
<div class="modal fade" id="modal-small" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <div class="sweet-alert showSweetAlert visible" data-custom-class="" data-has-cancel-button="false" data-has-confirm-button="true" data-allow-outside-click="false" data-has-done-function="false" data-animation="pop" data-timer="null" style="display: block; margin-top: 0px;">
            <div class="sa-icon sa-success animate" style="display: block;">
                <span class="sa-line sa-tip animateSuccessTip"></span>
                <span class="sa-line sa-long animateSuccessLong"></span>
                <div class="sa-placeholder"></div>
                <div class="sa-fix"></div>
            </div>
            <h2>Successfull!</h2>
            <p style="display: block;">Please check email to get new password</p>
            <div class="sa-button-container">
                <div class="sa-confirm-button-container">
                    <button onclick="window.location.href='<?php echo MAIN_HTTP_SERVER ?>'" class="confirm" tabindex="1" style="display: inline-block; box-shadow: rgba(140, 212, 245, 0.8) 0px 0px 2px, rgba(0, 0, 0, 0.0470588) 0px 0px 0px 1px inset; background-color: rgb(140, 212, 245);"><?php echo $text_ok?></button>
                    <div class="la-ball-fall">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END MODAL SMALL -->


<script type="text/javascript">
    var ok = "<?php echo $ok ?>";
    if(ok == 'true') {
        $('#modal-small').modal();
    }
</script>