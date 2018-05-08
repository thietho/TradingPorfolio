
<div class="container">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        Add new Chứng Khoán
        <?php } else { ?>
        Edit Chứng Khoán
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        Home / Chứng Khoán list /
        <?php if($item['id'] == ""){ ?>
        Add new Chứng Khoán
        <?php } else { ?>
        Edit Chứng Khoán
        <?php } ?>
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmItem">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-group">
						<label class="col-md-3 control-label">Mã chứng khoáng</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="symbol" id="symbol" placeholder="Mã chứng khoáng"
                                       value="<?php echo $item['symbol'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Tên chứng khoáng</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="name" id="name" placeholder="Tên chứng khoáng"
                                       value="<?php echo $item['name'] ?>">
						</div>
					</div>
					
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveItem">
                        <?php echo $item['id'] == '' ? 'Insert' : 'Update' ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/item'" type="button" class="btn btn-sm btn-default btn-bg">Cancel</button>
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
        $('#btnSaveItem').click(function(){
            showLoading();
            $.post("?route=module/item/save",$('#frmItem').serialize(),function(data){

                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"Errors");
                    endLoading();
                }
                else
                {
                    toastr.options.onHidden = function() { window.location = '?route=module/item'};
                    toastr.success('Chứng Khoán has been save', 'Save success', {timeOut: 1000});
                }

            });
        });
    }

</script>