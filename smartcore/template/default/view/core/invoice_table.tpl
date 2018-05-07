<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th><?php echo $text_no?></th>
                <th class="sort-default" sortcol="invoicedate"><?php echo $text_invoice_date?></th>
                <th class="sort-default" sortcol="createdate">Create Date</th>
                <th class="sort-default" sortcol="createdate">Create by</th>
                <th class="sort-default" sortcol="createdate">Tye</th>
                <th class="sort-default" sortcol="invoiceid"><?php echo $text_invoice_id?></th>
                <th>Account</th>
				<th class="sort-default" sortcol="cardname">Người nhận</th>
				<th class="sort-default" sortcol="notes">Ghi chú</th>
				<th class="sort-default" sortcol="amount"><?php echo $text_amount?></th>
                <th>Duyệt</th>
                <th class="tool-title"><?php echo $text_tool?></th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($invoices)) { foreach($invoices as $invoice) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $this->date->formatMySQLDate($invoice['invoicedate']) ?></td>
                <td><?php echo $invoice['createdate'] ?></td>
                <td><?php echo $invoice['createby'] ?></td>
                <td><?php echo $invoice['methodtype'] ?></td>
                <td><?php echo $invoice['invoiceid'] ?></td>
				<td><?php echo $invoice['accountid'] ?> - <?php echo $this->document->getAccount($invoice['accountid'])?></td>
				<td><?php echo $invoice['cardname'] ?></td>
                <td>
                    <?php echo $invoice['notes'] ?>
                    <?php echo $invoice['orderid'] ?>
                </td>
				<td class="number"><?php echo $this->document->currencyFormate($invoice['amount']) ?></td>
                <td>
                    <?php echo $this->document->invoicestatus[$invoice['status']] ?>
                </td>
				
                <td class="text-center">

                    <?php if($this->user->checkPermission($invoice['invoicetype'].'Del')){ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="Invoice.showDeleteDialog(<?php echo $invoice['id']?>, '<?php echo $invoice['invoiceid'] ?>')"><span class="fa fa-trash"></span></button>
                    <?php } ?>

                    <?php if($this->user->checkPermission($invoice['invoicetype'].'Print')){ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5" onclick="Invoice.print(<?php echo $invoice['id']?>)"><span class="fa fa-print"></span></button>
                    <?php } ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5" onclick="Invoice.restore(<?php echo $invoice['id']?>)"><span class="fa fa-repeat"></span></button>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileInvoice">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value=""><?php echo $text_sort?></option>
                    <option value="invoiceid"><?php echo $text_invoice_id?></option>
					<option value="invoicetype"><?php echo $text_invoice_type?></option>
					<option value="invoicedate"><?php echo $text_invoice_date?></option>
					<option value="createby">Create By</option>
					<option value="createdate">Create Date</option>
					<option value="cardid"><?php echo $text_card_id?></option>
					<option value="cardname"><?php echo $text_card_name?></option>
					<option value="address"><?php echo $text_address?></option>
					<option value="email">Email</option>
					<option value="phone"><?php echo $text_phone?></option>
					<option value="methodtype"><?php echo $text_method_type?></option>
					<option value="paymentmethod"><?php echo $text_payment_method?></option>
					<option value="accountid"><?php echo $text_account_id?></option>
					<option value="orderid"><?php echo $text_orderid?></option>
					<option value="cardid"><?php echo $text_card_id?></option>
					<option value="income">Income</option>
					<option value="expense">Expense</option>
					<option value="storeid">Store Id</option>
					
                </select>
            </div>
            <div class="col-md-6">
                <select id="sorttype" class="form-control">
                    <option value=""></option>
                    <option value="asc">ASC</option>
                    <option value="desc">DESC</option>
                </select>
            </div>
            <div class="col-md-6">
                <button type="button" class="btn btn-success form-control" id="btnSortInvoice"><span class="fa fa-sort"></span> <?php echo $text_sort?></button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($invoices)) { foreach($invoices as $invoice) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label><?php echo $text_invoice_id?>:</label> <?php echo $invoice['invoiceid'] ?><br>
		<label><?php echo $text_invoice_type?>:</label> <?php echo $invoice['invoicetype'] ?><br>
		<label><?php echo $text_invoice_date?>:</label> <?php echo $invoice['invoicedate'] ?><br>
		<label>Create By:</label> <?php echo $invoice['createby'] ?><br>
		<label>Create <?php echo $text_date?>:</label> <?php echo $invoice['createdate'] ?><br>
		<label><?php echo $text_card_id?>:</label> <?php echo $invoice['cardid'] ?><br>
		<label><?php echo $text_card_name?>:</label> <?php echo $invoice['cardname'] ?><br>
		<label><?php echo $text_address?>:</label> <?php echo $invoice['address'] ?><br>
		<label>Email:</label> <?php echo $invoice['email'] ?><br>
		<label><?php echo $text_phone?>:</label> <?php echo $invoice['phone'] ?><br>
		<label><?php echo $text_method_type?>:</label> <?php echo $invoice['methodtype'] ?><br>
		<label><?php echo $text_payment_method?>:</label> <?php echo $invoice['paymentmethod'] ?><br>
		<label><?php echo $text_account_id?>:</label> <?php echo $invoice['accountid'] ?><br>
		<label><?php echo $text_orderid?>:</label> <?php echo $invoice['orderid'] ?><br>
		<label><?php echo $text_card_id?>:</label> <?php echo $invoice['cardid'] ?><br>
		<label>Income:</label> <?php echo $this->string->numberFormate($invoice['amount']) ?><br>

		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnInvoiceSelect"
                        invoiceid="<?php echo $invoice['id']?>"
							invoiceid="<?php echo $invoice['invoiceid']?>"
							invoicetype="<?php echo $invoice['invoicetype']?>"
							invoicedate="<?php echo $invoice['invoicedate']?>"
							createby="<?php echo $invoice['createby']?>"
							createdate="<?php echo $invoice['createdate']?>"
							cardid="<?php echo $invoice['cardid']?>"
							cardname="<?php echo $invoice['cardname']?>"
							address="<?php echo $invoice['address']?>"
							email="<?php echo $invoice['email']?>"
							phone="<?php echo $invoice['phone']?>"
							methodtype="<?php echo $invoice['methodtype']?>"
							paymentmethod="<?php echo $invoice['paymentmethod']?>"
							accountid="<?php echo $invoice['accountid']?>"
							orderid="<?php echo $invoice['orderid']?>"
							cardid="<?php echo $invoice['cardid']?>"
							amount="<?php echo $invoice['amount']?>"
                            storeid="<?php echo $invoice['storeid']?>"
							
                        ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="Invoice.showDeleteDialog(<?php echo $invoice['id']?>, '<?php echo $invoice[''] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/invoice/update&id=<?php echo $invoice[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    Invoice.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileInvoice #sortcol').val(sortcol);
        $('#fitermobileInvoice #sorttype').val(sorttype);
    
        $('#fitermobileInvoice #btnSortInvoice').click(function(){
            $('#frmInvoiceSearch #sorttype').val($('#fitermobileInvoice #sorttype').val());
            $('#frmInvoiceSearch #sortcol').val($('#fitermobileInvoice #sortcol').val());
            Invoice.search();
        });
    $('#invoice-list th').each(function(e){
        if($(this).attr('sortcol') == sortcol)
        {
            $(this).removeClass('sort-default');
            switch(sorttype)
            {
                case 'asc':
                    $(this).addClass('sort-asc');
                    break;
                case 'desc':
                    $(this).addClass('sort-desc');
                    break;
            }
        }
    });
    $('.sort-default').click(function(){
        $('#frmInvoiceSearch #sorttype').val('asc');
        $('#frmInvoiceSearch #sortcol').val($(this).attr('sortcol'));
        Invoice.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmInvoiceSearch #sorttype').val('desc');
        $('#frmInvoiceSearch #sortcol').val($(this).attr('sortcol'));
        Invoice.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmInvoiceSearch #sorttype').val('asc');
        $('#frmInvoiceSearch #sortcol').val($(this).attr('sortcol'));
        Invoice.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });

    $('.invoicestatus').change(function () {
        var invoiceid = $(this).attr('invoiceid');
        var status = $(this).val();
        Invoice.updateStatus(invoiceid,status)
    });
</script>