<div class="app-heading app-heading-bordered app-heading-page">
    <div class="icon icon-lg"><span class="icon-clipboard-text"></span></div>
    <div class="title">
        <?php if($item['id'] == ""){ ?>
        <h2 >Add project</h2>
        <?php } else { ?>
        <h2 ><?php echo $text_edit?> project</h2>
        <?php }?>
        <p>Project management</p>
    </div>
</div>
<div class="container container-boxed">
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmProject">
                <input type="hidden" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6 col-md-offset-3">
                    <form class="form-horizontal">
                        <div class="form-group">
							<label class="col-md-3 control-label">Project name</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="projectname" placeholder="Project name"
                                       value="<?php echo $item['projectname'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Create date</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="createdate" placeholder="Create date"
                                       value="<?php echo $item['createdate'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label"><?php echo $text_description?></label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="description" placeholder="<?php echo $text_description?>"
                                       value="<?php echo $item['description'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Color</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="color" placeholder="Color"
                                       value="<?php echo $item['color'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Portfolioid</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="portfolioid" placeholder="Portfolioid"
                                       value="<?php echo $item['portfolioid'] ?>">
							</div>
						</div>
						
                    </form>
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveProject">
                        <?php echo $item['id'] == '' ? $text_insert : $text_update ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=test/project'" type="button" class="btn btn-sm btn-default btn-bg"><?php echo $text_cancel?></button>
                </div>
            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->

<script type="application/javascript">

    <?php if($_GET['type'] != 'popup'){ ?>
        $('#btnSaveProject').click(function(){
            showLoading();
            $.post("?route=test/project/save",$('#frmProject').serialize(),function(data){
                endLoading();
                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"<?php echo $text_errors?>");
                }
                else
                {
                    toastr.options.onHidden = function() { window.location = '?route=test/project'};
                    toastr.success('Project has been save', '<?php echo $text_save_success?>', {timeOut: 1000});
                }

            });
        });
    <?php } ?>

</script>