<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th>No.</th>
                <th class="sort-default" sortcol="invoiceid">Mã phiếu</th>
				<th class="sort-default" sortcol="invoicedate">Ngày</th>
				<th class="sort-default" sortcol="transactionid">Giao dịch</th>
				<th class="sort-default" sortcol="marginid">Khoản vay</th>
				<th class="sort-default" sortcol="dividendid">Cổ tức</th>
				<th class="sort-default" sortcol="invoicetype">Loại</th>
				<th class="sort-default" sortcol="amount">Số tiền</th>
				<th class="sort-default" sortcol="notes">Ghi chú</th>
                <th class="tool-title">Tool</th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($invoices)) { foreach($invoices as $invoice) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $invoice['invoiceid'] ?></td>
				<td><?php echo $this->date->formatMySQLDate($invoice['invoicedate']) ?></td>
				<td><?php echo $invoice['transactionid'] ?></td>
				<td><?php echo $invoice['marginid'] ?></td>
				<td><?php echo $invoice['dividendid'] ?></td>
				<td><?php echo $invoice['invoicetype'] ?></td>
				<td class="number"><?php echo $this->string->numberFormate($invoice['amount']) ?></td>
				<td><?php echo $invoice['notes'] ?></td>
				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnInvoiceSelect"
                            invoiceid="<?php echo $invoice['id']?>"
							invoiceid="<?php echo $invoice['invoiceid']?>"
							invoicedate="<?php echo $invoice['invoicedate']?>"
							transactionid="<?php echo $invoice['transactionid']?>"
							marginid="<?php echo $invoice['marginid']?>"
							dividendid="<?php echo $invoice['dividendid']?>"
							invoicetype="<?php echo $invoice['invoicetype']?>"
							amount="<?php echo $invoice['amount']?>"
							notes="<?php echo $invoice['notes']?>"
							createdate="<?php echo $invoice['createdate']?>"
							createby="<?php echo $invoice['createby']?>"
							updatedate="<?php echo $invoice['updatedate']?>"
							updateby="<?php echo $invoice['updateby']?>"
							deletedate="<?php echo $invoice['deletedate']?>"
							deleteby="<?php echo $invoice['deleteby']?>"
							
                            ><span class="fa fa-check"></span> Select</button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_Invoice.showDeleteDialog(<?php echo $invoice['id']?>, '<?php echo $invoice['invoiceid'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/invoice/update&id=<?php echo $invoice[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
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
                    <option value="">Sort</option>
                    <option value="invoiceid">Mã phiếu</option>
					<option value="invoicedate">Ngày</option>
					<option value="transactionid">Giao dịch</option>
					<option value="marginid">Khoản vay</option>
					<option value="dividendid">Cổ tức</option>
					<option value="invoicetype">Loại</option>
					<option value="amount">Số tiền</option>
					<option value="notes">Ghi chú</option>
					<option value="createdate">Ngày tạo</option>
					<option value="createby">Tạo bởi</option>
					<option value="updatedate">Ngày cập nhật</option>
					<option value="updateby">Cập nhật bởi</option>
					<option value="deletedate">Ngày xóa</option>
					<option value="deleteby">Xóa bởi</option>
					
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
                <button type="button" class="btn btn-success form-control" id="btnSortInvoice"><span class="fa fa-sort"></span> Sort</button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($invoices)) { foreach($invoices as $invoice) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>Mã phiếu:</label> <?php echo $invoice['invoiceid'] ?><br>
		<label>Ngày:</label> <?php echo $invoice['invoicedate'] ?><br>
		<label>Giao dịch:</label> <?php echo $invoice['transactionid'] ?><br>
		<label>Khoản vay:</label> <?php echo $invoice['marginid'] ?><br>
		<label>Cổ tức:</label> <?php echo $invoice['dividendid'] ?><br>
		<label>Loại:</label> <?php echo $invoice['invoicetype'] ?><br>
		<label>Số tiền:</label> <?php echo $invoice['amount'] ?><br>
		<label>Ghi chú:</label> <?php echo $invoice['notes'] ?><br>
		<label>Ngày tạo:</label> <?php echo $invoice['createdate'] ?><br>
		<label>Tạo bởi:</label> <?php echo $invoice['createby'] ?><br>
		<label>Ngày cập nhật:</label> <?php echo $invoice['updatedate'] ?><br>
		<label>Cập nhật bởi:</label> <?php echo $invoice['updateby'] ?><br>
		<label>Ngày xóa:</label> <?php echo $invoice['deletedate'] ?><br>
		<label>Xóa bởi:</label> <?php echo $invoice['deleteby'] ?><br>
		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnInvoiceSelect"
                        invoiceid="<?php echo $invoice['id']?>"
							invoiceid="<?php echo $invoice['invoiceid']?>"
							invoicedate="<?php echo $invoice['invoicedate']?>"
							transactionid="<?php echo $invoice['transactionid']?>"
							marginid="<?php echo $invoice['marginid']?>"
							dividendid="<?php echo $invoice['dividendid']?>"
							invoicetype="<?php echo $invoice['invoicetype']?>"
							amount="<?php echo $invoice['amount']?>"
							notes="<?php echo $invoice['notes']?>"
							createdate="<?php echo $invoice['createdate']?>"
							createby="<?php echo $invoice['createby']?>"
							updatedate="<?php echo $invoice['updatedate']?>"
							updateby="<?php echo $invoice['updateby']?>"
							deletedate="<?php echo $invoice['deletedate']?>"
							deleteby="<?php echo $invoice['deleteby']?>"
							
                        ><span class="fa fa-check"></span> Select</button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_Invoice.showDeleteDialog(<?php echo $invoice['id']?>, '<?php echo $invoice['invoiceid'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/invoice/update&id=<?php echo $invoice[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    trading_Invoice.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileInvoice #sortcol').val(sortcol);
        $('#fitermobileInvoice #sorttype').val(sorttype);
    
        $('#fitermobileInvoice #btnSortInvoice').click(function(){
            $('#frmInvoiceSearch #sorttype').val($('#fitermobileInvoice #sorttype').val());
            $('#frmInvoiceSearch #sortcol').val($('#fitermobileInvoice #sortcol').val());
            trading_Invoice.search();
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
        trading_Invoice.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmInvoiceSearch #sorttype').val('desc');
        $('#frmInvoiceSearch #sortcol').val($(this).attr('sortcol'));
        trading_Invoice.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmInvoiceSearch #sorttype').val('asc');
        $('#frmInvoiceSearch #sortcol').val($(this).attr('sortcol'));
        trading_Invoice.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>