
<div class="container">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        Add new Thu chi
        <?php } else { ?>
        Edit Thu chi
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        Home / Thu chi list /
        <?php if($item['id'] == ""){ ?>
        Add new Thu chi
        <?php } else { ?>
        Edit Thu chi
        <?php } ?>
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmInvoice">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-group">
						<label class="col-md-3 control-label">Mã phiếu</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="invoiceid" id="invoiceid" placeholder="Mã phiếu"
                                       value="<?php echo $item['invoiceid'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="invoicedate" id="invoicedate" placeholder="Ngày"
                                       value="<?php echo $item['invoicedate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Giao dịch</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="transactionid" id="transactionid" placeholder="Giao dịch"
                                       value="<?php echo $item['transactionid'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Khoản vay</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="marginid" id="marginid" placeholder="Khoản vay"
                                       value="<?php echo $item['marginid'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Cổ tức</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="dividendid" id="dividendid" placeholder="Cổ tức"
                                       value="<?php echo $item['dividendid'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Loại</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="invoicetype" id="invoicetype" placeholder="Loại"
                                       value="<?php echo $item['invoicetype'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Số tiền</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="amount" id="amount" placeholder="Số tiền"
                                       value="<?php echo $item['amount'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ghi chú</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="notes" id="notes" placeholder="Ghi chú"
                                       value="<?php echo $item['notes'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày tạo</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="createdate" id="createdate" placeholder="Ngày tạo"
                                       value="<?php echo $item['createdate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Tạo bởi</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="createby" id="createby" placeholder="Tạo bởi"
                                       value="<?php echo $item['createby'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày cập nhật</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="updatedate" id="updatedate" placeholder="Ngày cập nhật"
                                       value="<?php echo $item['updatedate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Cập nhật bởi</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="updateby" id="updateby" placeholder="Cập nhật bởi"
                                       value="<?php echo $item['updateby'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày xóa</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="deletedate" id="deletedate" placeholder="Ngày xóa"
                                       value="<?php echo $item['deletedate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Xóa bởi</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="deleteby" id="deleteby" placeholder="Xóa bởi"
                                       value="<?php echo $item['deleteby'] ?>">
						</div>
					</div>
					
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveInvoice">
                        <?php echo $item['id'] == '' ? 'Insert' : 'Update' ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/invoice'" type="button" class="btn btn-sm btn-default btn-bg">Cancel</button>
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
        $('#btnSaveInvoice').click(function(){
            showLoading();
            $.post("?route=module/invoice/save",$('#frmInvoice').serialize(),function(data){

                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"Errors");
                    endLoading();
                }
                else
                {
                    toastr.options.onHidden = function() { window.location = '?route=module/invoice'};
                    toastr.success('Thu chi has been save', 'Save success', {timeOut: 1000});
                }

            });
        });
    }

</script>