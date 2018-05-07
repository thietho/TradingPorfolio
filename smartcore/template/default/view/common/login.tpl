<!-- START APP CONTAINER -->
<div class="app-container" style="width: 100%; height: 100%; background: url('<?php echo DIR_IMAGE ?>bg-login.jpg') center center no-repeat; background-size:cover">
    <div class="app-login-box">
        <div class="app-login-box-user">
            <img src="<?php echo DIR_IMAGE ?>logo.png">
        </div>
        
        <div class="app-login-box-title">
            <div class="title">Already a member?</div>
            <div class="subtitle">Sign in to your account</div>
        </div>
        <div class="app-login-box-container">
            <form action="" method="post">
                <div class="form-group">
                    <input type="text" class="form-control" name="username" placeholder="<?php echo $text_user_name?>">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" name="password" placeholder="<?php echo $text_password?>">
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-12 col-xs-12">
                            <button class="btn btn-success btn-block" type="submit">Sign In</button>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                            <div class="app-checkbox">
                                <label><input type="checkbox" name="cookie" value="1"> Stay signed in</label>
                            </div>
                        </div>
                        <div class="col-md-6 col-xs-6">
                            <div class="app-checkbox btn-link">
                                <a onclick="window.location.href='<?php echo MAIN_HTTP_SERVER ?>forgot-password.php'" type="button" class="pull-right">Forgot password?</a>
                            </div>
                        </div>
                    </div>

                </div>
                <?php if($error != ''){ ?>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-12 col-xs-12 text-danger">
                            <?php echo $error?>
                        </div>
                    </div>
                </div>
                <?php }?>
            </form>
        </div>
        <div class="app-login-box-footer">&copy; POS 2017. All rights reserved.</div>
    </div>
</div>
<!-- END APP CONTAINER -->