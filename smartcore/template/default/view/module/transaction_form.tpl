
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
                <input type="hidden" id="transactionid" name="transactionid" value="<?php echo $item['transactionid'] ?>">

                <div class="col-md-6 col-md-offset-3">

					<div class="form-group">
						<label class="col-md-3 control-label">Tài khoản</label>
						<div class="col-md-9">
							<select class="form-control input-sm" name="accountid" id="accountid">
								<?php foreach($accountstocks as $accountstock){ ?>
								<option value="<?php echo $accountstock['accountid']?>" <?php echo $accountstock['accountid']==$item['accountid']?'selected':''?>><?php echo $this->document->getCard($accountstock['cardid'])?> - <?php echo $this->document->getCard($accountstock['openat'])?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày giao dịch</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm bs-datepicker"
                                       name="transactiondate" id="transactiondate" placeholder="Ngày giao dịch"
                                       value="<?php echo $this->date->formatMySQLDate($item['transactiondate']) ?>">
						</div>
					</div>

					<div class="form-group">
						<label class="col-md-3 control-label">Mã ck</label>
						<div class="col-md-9">
							<select class="form-control input-sm" name="symbol" id="symbol">
								<option value=""></option>
								<?php foreach($itemcks as $ck){ ?>
								<option value="<?php echo $ck['symbol'] ?>" <?php echo $ck['symbol']==$item['symbol']?'selected':''?>><?php echo $ck['symbol'].' - '.$ck['name']?></option>
								<?php } ?>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-md-3 control-label">Loại giao dịch</label>
						<div class="col-md-9">

                            <select class="form-control input-sm" name="type" id="type">
                                <?php foreach($this->document->transactiontype as $key => $val){ ?>
                                <option value="<?php echo $key;?>" <?php echo $key==$item['type']?'selected':''?>><?php echo $val?></option>
                                <?php } ?>
                            </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Giá vốn</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="costofsale" id="costofsale" placeholder="Giá vốn"
                                       value="<?php echo $item['costofsale'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Số lượng</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="volume" id="volume" placeholder="Số lượng"
                                       value="<?php echo $item['volume'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Giá</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="price" id="price" placeholder="Giá"
                                       value="<?php echo $item['price'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Phí giao dich</label>
						<div class="col-md-9">
							<div class="input-group input-group-sm">
								<input type="text" class="form-control number" name="fee" id="fee" placeholder="Phí giao dich"  value="<?php echo $item['fee'] ?>">
								<span class="input-group-addon">%</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Thuế</label>
						<div class="col-md-9">
							<div class="input-group input-group-sm">
								<input type="text" class="form-control number" name="tax" id="tax" placeholder="Thuế"  value="<?php echo $item['tax'] ?>">
								<span class="input-group-addon">%</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Số tiền giao dịch</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="total" id="total" placeholder="Số tiền giao dịch"
                                       value="<?php echo $item['total'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Lợi nhuận</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
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