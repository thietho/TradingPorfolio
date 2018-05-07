
<div class="container">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        Add new Module
        <?php } else { ?>
        Edit Module
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        Home / Module list /
        <?php if($item['id'] == ""){ ?>
        Add new Module
        <?php } else { ?>
        Edit Module
        <?php } ?>
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmModule">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-group">
						<label class="col-md-3 control-label">Module Id</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="moduleid" id="moduleid" placeholder="Module Id"
                                       value="<?php echo $item['moduleid'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Module Name</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="modulename" id="modulename" placeholder="Module Name"
                                       value="<?php echo $item['modulename'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Module Path</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="modulepath" id="modulepath" placeholder="Module Path"
                                       value="<?php echo $item['modulepath'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Parent</label>
						<div class="col-md-9">
                            <select class="form-control input-sm"
                                    name="moduleparent" id="moduleparent">
                                <option value="0"></option>
                                <?php foreach($modules as $module) { ?>
                                <option value="<?php echo $module['id']?>" <?php echo $module['id']==$item['moduleparent']?'selected':'';?>><?php echo $this->string->setLoopStr('-----',$module['level'])?><?php echo $module['modulename']?></option>
                                <?php } ?>
                            </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Icon</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="moduleicon" id="moduleicon" placeholder="Icon"
                                       value="<?php echo $item['moduleicon'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Position</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="position" id="position" placeholder="Position"
                                       value="<?php echo $item['position'] ?>">
						</div>
					</div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Show</label>
                        <div class="col-md-9">
                            <select class="form-control input-sm"
                                    name="isshow" id="isshow">
                                <option value="1" <?php echo $item['isshow']==1?'selected':''; ?>>Show</option>
                                <option value="0" <?php echo $item['isshow']==0?'selected':''; ?>>Hide</option>
                            </select>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveModule">
                        <?php echo $item['id'] == '' ? 'Insert' : 'Update' ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/module'" type="button" class="btn btn-sm btn-default btn-bg">Cancel</button>
                </div>
            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->

<script type="application/javascript">

    var type = "<?php echo $_GET['type']?>";
    	if(type != 'popup'){
        $('#btnSaveModule').click(function(){
            showLoading();
            $.post("?route=core/module/save",$('#frmModule').serialize(),function(data){

                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"Errors");
                    endLoading();
                }
                else
                {
                    toastr.options.onHidden = function() { window.location = '?route=core/module'};
                    toastr.success('Module has been save', 'Save success', {timeOut: 1000});
                }

            });
        });
    }

</script>