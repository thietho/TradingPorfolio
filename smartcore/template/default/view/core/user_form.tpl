
<div class="container">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        <?php echo $text_add_new?> User
        <?php } else { ?>
        <?php echo $text_edit?> User
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        <?php echo $text_home?> / User list /
        <?php if($item['id'] == ""){ ?>
        <?php echo $text_add_new?> User
        <?php } else { ?>
        <?php echo $text_edit?> User
        <?php } ?>
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmUser">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6 col-md-offset-3">

					<div class="form-group">
						<label class="col-md-3 control-label"><?php echo $text_usertype?></label>
						<div class="col-md-9">
                            <select class="bs-select" name="usertypeid" id="usertypeid">
                                <?php foreach($usertypes as $usertype){ ?>
                                <option value="<?php echo $usertype['usertypeid']?>" <?php echo ($usertype['usertypeid'] == $item['usertypeid'])?'selected':'' ?>><?php echo $usertype['usertypename']?></option>
                                <?php } ?>
                            </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label"><?php echo $text_user_name?></label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="username" id="username" placeholder="<?php echo $text_user_name?>"
                                       value="<?php echo $item['username'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label"><?php echo $text_password?></label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="password" id="password" placeholder="<?php echo $text_password?>"
                                       value="<?php echo $item['password'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label"><?php echo $text_full_name?></label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="fullname" id="fullname" placeholder="<?php echo $text_full_name?>"
                                       value="<?php echo $item['fullname'] ?>">
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
						<label class="col-md-3 control-label"><?php echo $text_status?></label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="status" id="status" placeholder="<?php echo $text_status?>"
                                       value="<?php echo $item['status'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Image Path</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="imagepath" id="imagepath" placeholder="Image Path"
                                       value="<?php echo $item['imagepath'] ?>">
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
						<label class="col-md-3 control-label">Active Date</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="activedate" id="activedate" placeholder="Active Date"
                                       value="<?php echo $item['activedate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Updated Date</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="updateddate" id="updateddate" placeholder="Updated Date"
                                       value="<?php echo $item['updateddate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Deleted Date</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="deleteddate" id="deleteddate" placeholder="Deleted Date"
                                       value="<?php echo $item['deleteddate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Active by</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="activeby" id="activeby" placeholder="Active by"
                                       value="<?php echo $item['activeby'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Updated by</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="updatedby" id="updatedby" placeholder="Updated by"
                                       value="<?php echo $item['updatedby'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Deleted by</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="deletedby" id="deletedby" placeholder="Deleted by"
                                       value="<?php echo $item['deletedby'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">User Ip</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="userip" id="userip" placeholder="User Ip"
                                       value="<?php echo $item['userip'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Permission</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="permission" id="permission" placeholder="Permission"
                                       value="<?php echo $item['permission'] ?>">
						</div>
					</div>
					
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveUser">
                        <?php echo $item['id'] == '' ? $text_insert : $text_update ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/user'" type="button" class="btn btn-sm btn-default btn-bg"><?php echo $text_cancel?></button>
                </div>
            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->

<script type="application/javascript">

    <?php if($_GET['type'] != 'popup'){ ?>
        $('#btnSaveUser').click(function(){
            showLoading();
            $.post("?route=core/user/save",$('#frmUser').serialize(),function(data){
                endLoading();
                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"<?php echo $text_errors?>");
                }
                else
                {
                    toastr.options.onHidden = function() { window.location = '?route=core/user'};
                    toastr.success('User has been save', '<?php echo $text_save_success?>', {timeOut: 1000});
                }

            });
        });
    <?php } ?>

</script>