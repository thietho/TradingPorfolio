
<div class="container">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        <?php echo $text_add_new?> Usertype
        <?php } else { ?>
        <?php echo $text_edit?> Usertype
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        <?php echo $text_home?> / Usertype list /
        <?php if($item['id'] == ""){ ?>
        <?php echo $text_add_new?> Usertype
        <?php } else { ?>
        <?php echo $text_edit?> Usertype
        <?php } ?>
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmUsertype">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6">
                    <div class="form-group">
						<label class="col-md-3 control-label">User Type ID</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="usertypeid" id="usertypeid" placeholder="User Type ID"
                                       value="<?php echo $item['usertypeid'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">User Type Name</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="usertypename" id="usertypename" placeholder="User Type Name"
                                       value="<?php echo $item['usertypename'] ?>">
						</div>
					</div>
                </div>
                <div class="col-md-6">
					<div class="form-group">
						<label class="col-md-3 control-label">Permission</label>
						<div class="col-md-9">
                            <ul class="permission">
                                <?php foreach($datapermission as $key => $module){ ?>
                                <li>
                                    <?php echo $module['modulename']?>
                                    <ul>
                                        <?php foreach($module['childs'] as $child){ ?>
                                        <li>
                                            <label><input type="checkbox" name="permission[]" value="<?php echo $child['moduleid']?>" <?php echo @in_array($child['moduleid'],$item['permission'])?'checked':'' ?> > <?php echo $child['modulename']?><span></span></label>
                                        </li>
                                        <?php } ?>
                                    </ul>

                                </li>
                                <?php } ?>
                            </ul>

						</div>
					</div>
					
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveUsertype">
                        <?php echo $item['id'] == '' ? $text_insert : $text_update ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/usertype'" type="button" class="btn btn-sm btn-default btn-bg"><?php echo $text_cancel?></button>
                </div>
            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->

<script type="application/javascript">

    <?php if($_GET['type'] != 'popup'){ ?>
        $('#btnSaveUsertype').click(function(){
            showLoading();
            $.post("?route=core/usertype/save",$('#frmUsertype').serialize(),function(data){
                endLoading();
                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"<?php echo $text_errors?>");
                }
                else
                {
                    toastr.options.onHidden = function() { window.location = '?route=core/usertype'};
                    toastr.success('Usertype has been save', '<?php echo $text_save_success?>', {timeOut: 1000});
                }

            });
        });
    <?php } ?>

</script>