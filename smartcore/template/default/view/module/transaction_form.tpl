
<div class="container">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        Add new Giao dịch
        <?php } else { ?>
        Edit Giao dịch
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        Home / Giao dịch list /
        <?php if($item['id'] == ""){ ?>
        Add new Giao dịch
        <?php } else { ?>
        Edit Giao dịch
        <?php } ?>
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmTransaction">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-group">
						<label class="col-md-3 control-label">Mã giao dịch</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="transactionid" id="transactionid" placeholder="Mã giao dịch"
                                       value="<?php echo $item['transactionid'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Tài khoản</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="accountid" id="accountid" placeholder="Tài khoản"
                                       value="<?php echo $item['accountid'] ?>">
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
						<label class="col-md-3 control-label">Ngày giao dịch</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="transactiondate" id="transactiondate" placeholder="Ngày giao dịch"
                                       value="<?php echo $item['transactiondate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày nhận tiền(T+2)</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="receivemoneydate" id="receivemoneydate" placeholder="Ngày nhận tiền(T+2)"
                                       value="<?php echo $item['receivemoneydate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày nhận ck(T+3)</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="receivestockdate" id="receivestockdate" placeholder="Ngày nhận ck(T+3)"
                                       value="<?php echo $item['receivestockdate'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Mã ck</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="symbol" id="symbol" placeholder="Mã ck"
                                       value="<?php echo $item['symbol'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Tên ck</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="name" id="name" placeholder="Tên ck"
                                       value="<?php echo $item['name'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Loại giao dịch</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="type" id="type" placeholder="Loại giao dịch"
                                       value="<?php echo $item['type'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Giá vốn</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="costofsale" id="costofsale" placeholder="Giá vốn"
                                       value="<?php echo $item['costofsale'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Số lượng</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="volume" id="volume" placeholder="Số lượng"
                                       value="<?php echo $item['volume'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Giá</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="price" id="price" placeholder="Giá"
                                       value="<?php echo $item['price'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Phí giao dich</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="fee" id="fee" placeholder="Phí giao dich"
                                       value="<?php echo $item['fee'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Thuế</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="tax" id="tax" placeholder="Thuế"
                                       value="<?php echo $item['tax'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Số tiền giao dịch</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="total" id="total" placeholder="Số tiền giao dịch"
                                       value="<?php echo $item['total'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Lợi nhuận</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="profit" id="profit" placeholder="Lợi nhuận"
                                       value="<?php echo $item['profit'] ?>">
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
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveTransaction">
                        <?php echo $item['id'] == '' ? 'Insert' : 'Update' ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/transaction'" type="button" class="btn btn-sm btn-default btn-bg">Cancel</button>
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
        $('#btnSaveTransaction').click(function(){
            showLoading();
            $.post("?route=module/transaction/save",$('#frmTransaction').serialize(),function(data){

                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"Errors");
                    endLoading();
                }
                else
                {
                    toastr.options.onHidden = function() { window.location = '?route=module/transaction'};
                    toastr.success('Giao dịch has been save', 'Save success', {timeOut: 1000});
                }

            });
        });
    }

</script>