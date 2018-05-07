<form id="frmCardPermission">
    <div>
        <div class="form-group">
            <label class="col-md-2 control-label"><?php echo $text_full_name?></label>
            <label class="col-md-2 control-label"><?php echo $card['fullname']?></label>
            <label class="col-md-2 control-label"><?php echo $text_account?></label>
            <label class="col-md-2 control-label"><?php echo $user['username']?></label>
            <label class="col-md-2 control-label"><?php echo $text_usertype?></label>
            <label class="col-md-2 control-label"><?php echo $this->document->getUserType($user['usertypeid'])?></label>
        </div>
        <input type="hidden" name="username" value="<?php echo $user['username']?>">
        <div>
            <ul class="permission">
                <?php foreach($datapermission as $key => $module){ ?>
                <li>
                    <strong><?php echo $module['modulename']?></strong>
                    <ul>
                        <?php foreach($module['childs'] as $child){ ?>
                        <li>
                            <label><input type="checkbox" name="permission[]" value="<?php echo $child['moduleid']?>" <?php echo @in_array($child['moduleid'],$user['permission'])?'checked':'' ?> > <?php echo $child['modulename']?><span></span></label>
                        </li>
                        <?php } ?>
                    </ul>

                </li>
                <?php } ?>
            </ul>
        </div>
    </div>

</form>