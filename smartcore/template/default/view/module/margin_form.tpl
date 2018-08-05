
<div class="container">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        Add new Khoản vay
        <?php } else { ?>
        Edit Khoản vay
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        Home / Khoản vay list /
        <?php if($item['id'] == ""){ ?>
        Add new Khoản vay
        <?php } else { ?>
        Edit Khoản vay
        <?php } ?>
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmMargin">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-group">
						<label class="col-md-3 control-label">Ngày phụ lục</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm bs-datepicker"
                                       name="opendate" id="opendate" placeholder="Ngày phụ lục"
                                       value="<?php echo $this->date->formatMySQLDate($item['opendate']) ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày thanh lý</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm bs-datepicker"
                                       name="closedate" id="closedate" placeholder="Ngày thanh lý"
                                       value="<?php echo $this->date->formatMySQLDate($item['closedate']) ?>">
						</div>
					</div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tài khoản vay</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="accountid" id="accountid" placeholder="Tài khoản vay"
                                   value="<?php echo $item['accountid'] ?>">
                        </div>
                    </div>
					<div class="form-group">
						<label class="col-md-3 control-label">Giá trị</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="amount" id="amount" placeholder="Giá trị"
                                       value="<?php echo $item['amount'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày nắm giử</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="countdate" id="countdate" placeholder="Ngày nắm giử"
                                       value="<?php echo $item['countdate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Lãi xuất</label>
						<div class="col-md-9">
							<div class="input-group input-group-sm">
								<input type="text" class="form-control number" name="rate" id="rate" placeholder="Lãi xuất"  value="<?php echo $item['rate'] ?>">
								<span class="input-group-addon">%</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Tổng trả</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="totalpay" id="totalpay" placeholder="Tổng trả"
                                       value="<?php echo $item['totalpay'] ?>">
						</div>
					</div>


					<div class="form-group">
						<label class="col-md-3 control-label">Tạo từ giao dịch</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="transactionid" id="transactionid" placeholder="Tạo từ giao dịch"
                                       value="<?php echo $item['transactionid'] ?>">
						</div>
					</div>
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveMargin">
                        <?php echo $item['id'] == '' ? 'Insert' : 'Update' ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/margin'" type="button" class="btn btn-sm btn-default btn-bg">Cancel</button>
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
        $('#btnSaveMargin').click(function(){
            showLoading();
            $.post("?route=module/margin/save",$('#frmMargin').serialize(),function(data){

                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"Errors");
                    endLoading();
                }
                else
                {
                    toastr.options.onHidden = function() { window.location = '?route=module/margin'};
                    toastr.success('Khoản vay has been save', 'Save success', {timeOut: 1000});
                }

            });
        });
    }

</script>