
<div class="container">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        Add new Cổ tức cổ phiếu
        <?php } else { ?>
        Edit Cổ tức cổ phiếu
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        Home / Cổ tức cổ phiếu list /
        <?php if($item['id'] == ""){ ?>
        Add new Cổ tức cổ phiếu
        <?php } else { ?>
        Edit Cổ tức cổ phiếu
        <?php } ?>
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmDividendStock">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
				<input type="hidden" id="tranid" name="tranid" value="<?php echo $item['tranid'] ?>">
				<input type="hidden" id="transactionid" name="transactionid" value="<?php echo $item['transactionid'] ?>">

                <div class="col-md-6 col-md-offset-3">
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày nhận</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm bs-datepicker"
								   name="receivedate" id="receivedate" placeholder="Ngày nhận"
								   value="<?php echo $this->date->formatMySQLDate($item['receivedate']) ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày chốt quyền</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm bs-datepicker"
								   name="deadline" id="deadline" placeholder="Ngày chốt quyền"
								   value="<?php echo $this->date->formatMySQLDate($item['deadline']) ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Mã chứng khoán</label>
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
						<label class="col-md-3 control-label">Tài khoản nhận</label>
						<div class="col-md-9">

							<select class="form-control input-sm" name="accountid" id="accountid">
								<?php foreach($accountstocks as $accountstock){ ?>
								<option value="<?php echo $accountstock['accountid']?>" <?php echo $accountstock['accountid']==$item['accountid']?'selected':''?>><?php echo $this->document->getCard($accountstock['cardid'])?> - <?php echo $this->document->getCard($accountstock['openat'])?></option>
								<?php } ?>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-md-3 control-label">Giá phát hành</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="price" id="price" placeholder="Giá phát hành"
                                       value="<?php echo $item['price'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Tỷ lệ phát hành</label>
						<div class="col-md-9">
							<div class="input-group input-group-sm">
								<input type="text" class="form-control number" name="dividendrate" id="dividendrate" placeholder="Tỷ lệ phát hành"  value="<?php echo $item['dividendrate'] ?>">
								<span class="input-group-addon">%</span>
							</div>

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Số lượng mua</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="quantity" id="quantity" placeholder="Số lượng mua"
                                       value="<?php echo $item['quantity'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Số lượng được mua</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="quantityallowbuy" id="quantityallowbuy" placeholder="Số lượng được mua"
                                       value="<?php echo $item['quantityallowbuy'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Số cổ phiếu được nhận</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="quantityallowreceive" id="quantityallowreceive" placeholder="Số cổ phiếu được nhận"
                                       value="<?php echo $item['quantityallowreceive'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Ghi chú</label>
						<div class="col-md-9">
                            <textarea class="form-control input-sm"
									  name="notes" id="notes" placeholder="Ghi chú"><?php echo $item['notes'] ?></textarea>
						</div>
					</div>

					
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveDividendStock">
                        <?php echo $item['id'] == '' ? 'Insert' : 'Update' ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/dividendstock'" type="button" class="btn btn-sm btn-default btn-bg">Cancel</button>
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
        $('#btnSaveDividendStock').click(function(){
            showLoading();
            $.post("?route=module/transaction/save",{
				id:$('#frmDividendStock #tranid').val(),
                transactionid:$('#frmDividendStock #transactionid').val(),
                type:"B",
                accountid:$('#frmDividendStock #accountid').val(),
                transactiondate:$('#frmDividendStock #receivedate').val(),
                symbol:$('#frmDividendStock #symbol').val(),
                volume:$('#frmDividendStock #quantity').val(),
                price:$('#frmDividendStock #price').val(),
                fee:0,
                total:Number(stringtoNumber($('#frmDividendStock #quantity').val()))*Number(stringtoNumber($('#frmDividendStock #price').val()))
			},function (transaction) {
                var objtransaction = $.parseJSON(transaction)
                $('#frmDividendStock #transactionid').val(objtransaction.transactionid);
                $.post("?route=module/dividendstock/save",$('#frmDividendStock').serialize(),function(data){
                    var obj = $.parseJSON(data)
                    if(obj.errorstext != '')
                    {
                        toastr.error(obj.errorstext,"Errors");
                        endLoading();
                    }
                    else
                    {

                        toastr.options.onHidden = function() { window.location = '?route=module/dividendstock'};
                        toastr.success('Cổ tức cổ phiếu has been save', 'Save success', {timeOut: 1000});
                    }

                });
            });

        });
    }

</script>