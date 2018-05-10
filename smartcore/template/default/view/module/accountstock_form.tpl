
<div class="container">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        Add new Tài khoản chứng khoán
        <?php } else { ?>
        Edit Tài khoản chứng khoán
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        Home / Tài khoản chứng khoán list /
        <?php if($item['id'] == ""){ ?>
        Add new Tài khoản chứng khoán
        <?php } else { ?>
        Edit Tài khoản chứng khoán
        <?php } ?>
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmAccountStock">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-group">
						<label class="col-md-3 control-label">Tài khoản</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="accountid" id="accountid" placeholder="Tài khoản"
                                       value="<?php echo $item['accountid'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Mở tại</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="openat" id="openat" placeholder="Mở tại"
                                       value="<?php echo $item['openat'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Phí mua</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="buyfee" id="buyfee" placeholder="Phí mua"
                                       value="<?php echo $item['buyfee'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Phí bán</label>
						<div class="col-md-9">
							<div class="input-group input-group-sm">
								<input type="text" class="form-control number" placeholder="Phí bán" name="salefee" id="salefee" placeholder="Phí bán"  value="<?php echo $item['salefee'] ?>">
								<span class="input-group-addon">%</span>
							</div>
						</div>


					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Lãi xuất margin</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="marginrate" id="marginrate" placeholder="Lãi xuất margin"
                                       value="<?php echo $item['marginrate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Chủ tài khoản</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="cardid" id="cardid" placeholder="Chủ tài khoản"
                                       value="<?php echo $item['cardid'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Trạng thái</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="status" id="status" placeholder="Trạng thái"
                                       value="<?php echo $item['status'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Phí lưu ký ck</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="depositfee" id="depositfee" placeholder="Phí lưu ký ck"
                                       value="<?php echo $item['depositfee'] ?>">
						</div>
					</div>
					
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveAccountStock">
                        <?php echo $item['id'] == '' ? 'Insert' : 'Update' ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/accountstock'" type="button" class="btn btn-sm btn-default btn-bg">Cancel</button>
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
        $('#btnSaveAccountStock').click(function(){
            showLoading();
            $.post("?route=module/accountstock/save",$('#frmAccountStock').serialize(),function(data){

                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"Errors");
                    endLoading();
                }
                else
                {
                    toastr.options.onHidden = function() { window.location = '?route=module/accountstock'};
                    toastr.success('Tài khoản chứng khoán has been save', 'Save success', {timeOut: 1000});
                }

            });
        });
    }

</script>