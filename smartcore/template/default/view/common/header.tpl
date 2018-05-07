<div class="app-header">
    <ul class="app-header-buttons">
        <li class="visible-mobile"><a href="#" class="btn btn-link btn-icon" data-sidebar-toggle=".app-sidebar.dir-left"><span class="icon-menu"></span></a>
        </li>
        <li class="hidden-mobile"><a href="#" class="btn btn-link btn-icon" data-sidebar-minimize=".app-sidebar.dir-left"><span class="icon-list4"></span></a>
        </li>
    </ul>

    <ul class="app-header-buttons pull-right">
        <li>
            <div class="contact contact-rounded contact-bordered contact-lg contact-ps-controls"><img src="<?php echo DIR_IMAGE?>no-image.png" alt="John Doe">
                <div class="contact-container"><a href="#"><?php echo $card['fullname']?></a> <span><?php echo $this->document->getUserType($this->user->getUserTypeId())?></span>
                </div>
                <div class="contact-controls">
                    <div class="dropdown">
                        <button type="button" class="btn btn-default btn-icon" data-toggle="dropdown"><span class="icon-cog"></span>
                        </button>
                        <ul class="dropdown-menu dropdown-left">
                            <li><a href="?route=core/setting"><span class="icon-cog"></span><?php echo $text_setting?></a></li>
                            <li><a href="?route=core/profile&id=<?php echo $card['id']?>&type=editprofile"><span class="icon-users"></span> <?php echo $text_profile?></a></li>
                            <li><a href="?route=core/user/changepassword"><span class="icon-key"></span> <?php echo $text_change_password?> </a></li>
                            <li class="divider"></li>
                            <li><a href="<?php echo ROOT_HTTP_SERVER ?>logout.php"><span class="icon-exit-right"></span> <?php echo $text_log_out?></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </li>
    </ul>
</div>