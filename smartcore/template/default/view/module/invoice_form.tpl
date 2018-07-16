
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
                <input type="hidden" id="invoiceid" name="invoiceid" value="<?php echo $item['invoiceid'] ?>">

                <div class="col-md-6 col-md-offset-3">
					<div class="form-group">
						<label class="col-md-3 control-label">Ngày</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm bs-datepicker"
                                       name="invoicedate" id="invoicedate" placeholder="Ngày"
                                       value="<?php echo $this->date->formatMySQLDate($item['invoicedate']) ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Loại</label>
						<div class="col-md-9">
							<select class="form-control input-sm" name="invoicetype" id="invoicetype">
								<?php foreach($this->document->invoicestype as $key => $val){ ?>
								<option value="<?php echo $key?>" <?php echo $key==$item['invoicetype']?'selected':'' ?> ><?php echo $val?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Số tiền</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="amount" id="amount" placeholder="Số tiền"
                                       value="<?php echo $item['amount'] ?>">
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