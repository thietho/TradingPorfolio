<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th>No.</th>
                <th class="sort-default" sortcol="transactionid">Mã giao dịch</th>
				<th class="sort-default" sortcol="accountid">Tài khoản</th>
				<th class="sort-default" sortcol="cardid">Chủ tài khoản</th>
				<th class="sort-default" sortcol="transactiondate">Ngày giao dịch</th>
				<th class="sort-default" sortcol="receivemoneydate">Ngày nhận tiền(T+2)</th>
				<th class="sort-default" sortcol="receivestockdate">Ngày nhận ck(T+3)</th>
				<th class="sort-default" sortcol="symbol">Mã ck</th>

				<th class="sort-default" sortcol="type">Loại giao dịch</th>
				<th class="sort-default" sortcol="costofsale">Giá vốn</th>
				<th class="sort-default" sortcol="volume">Số lượng</th>
				<th class="sort-default" sortcol="price">Giá</th>
				<th class="sort-default" sortcol="fee">Phí giao dich</th>
				<th class="sort-default" sortcol="tax">Thuế</th>
				<th class="sort-default" sortcol="total">Số tiền giao dịch</th>
				<th class="sort-default" sortcol="total">Cost of sale</th>
				<th class="sort-default" sortcol="profit">Lợi nhuận</th>
				<th class="sort-default" sortcol="notes">Ghi chú</th>
                <th class="tool-title">Tool</th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($transactions)) { foreach($transactions as $transaction) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $transaction['transactionid'] ?></td>
				<td><?php echo $transaction['accountid'] ?></td>
				<td><?php echo $this->document->getCard($transaction['cardid']) ?></td>
				<td><?php echo $this->date->formatMySQLDate($transaction['transactiondate']) ?></td>
				<td><?php echo $this->date->formatMySQLDate($transaction['receivemoneydate']) ?></td>
				<td><?php echo $this->date->formatMySQLDate($transaction['receivestockdate']) ?></td>
				<td><?php echo $transaction['symbol'] ?></td>

				<td><?php echo $this->document->transactiontype[$transaction['type']] ?></td>
				<td class="number">
					<?php echo $transaction['type']=='B'?$this->string->numberFormate($transaction['total']/$transaction['volume']):'0' ?>
				</td>
				<td class="number"><?php echo $this->string->numberFormate($transaction['volume']) ?></td>
				<td class="number"><?php echo $this->string->numberFormate($transaction['price']) ?></td>
				<td class="number"><?php echo $this->string->numberFormate($transaction['fee']/100*$transaction['volume']*$transaction['price']) ?></td>
				<td class="number"><?php echo $this->string->numberFormate($transaction['tax']/100*$transaction['volume']*$transaction['price']) ?></td>
				<td class="number"><?php echo $this->string->numberFormate($transaction['total']) ?></td>
				<td class="number"><?php echo $transaction['type']=='S'?$this->string->numberFormate($transaction['costofsale']*$transaction['volume']):0 ?></td>
				<td class="number"><?php echo $this->string->numberFormate($transaction['profit']) ?></td>
				<td><?php echo $transaction['notes'] ?></td>
				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnTransactionSelect"
                            transactionid="<?php echo $transaction['id']?>"
							transactionid="<?php echo $transaction['transactionid']?>"
							accountid="<?php echo $transaction['accountid']?>"
							cardid="<?php echo $transaction['cardid']?>"
							transactiondate="<?php echo $transaction['transactiondate']?>"
							receivemoneydate="<?php echo $transaction['receivemoneydate']?>"
							receivestockdate="<?php echo $transaction['receivestockdate']?>"
							symbol="<?php echo $transaction['symbol']?>"
							name="<?php echo $transaction['name']?>"
							type="<?php echo $transaction['type']?>"
							costofsale="<?php echo $transaction['costofsale']?>"
							volume="<?php echo $transaction['volume']?>"
							price="<?php echo $transaction['price']?>"
							fee="<?php echo $transaction['fee']?>"
							tax="<?php echo $transaction['tax']?>"
							total="<?php echo $transaction['total']?>"
							profit="<?php echo $transaction['profit']?>"
							notes="<?php echo $transaction['notes']?>"
							createdate="<?php echo $transaction['createdate']?>"
							createby="<?php echo $transaction['createby']?>"
							updatedate="<?php echo $transaction['updatedate']?>"
							updateby="<?php echo $transaction['updateby']?>"
							deletedate="<?php echo $transaction['deletedate']?>"
							deleteby="<?php echo $transaction['deleteby']?>"
							
                            ><span class="fa fa-check"></span> Select</button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_Transaction.showDeleteDialog(<?php echo $transaction['id']?>, '<?php echo $transaction['transactionid'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/transaction/update&id=<?php echo $transaction[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileTransaction">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value="">Sort</option>
                    <option value="transactionid">Mã giao dịch</option>
					<option value="accountid">Tài khoản</option>
					<option value="cardid">Chủ tài khoản</option>
					<option value="transactiondate">Ngày giao dịch</option>
					<option value="receivemoneydate">Ngày nhận tiền(T+2)</option>
					<option value="receivestockdate">Ngày nhận ck(T+3)</option>
					<option value="symbol">Mã ck</option>
					<option value="name">Tên ck</option>
					<option value="type">Loại giao dịch</option>
					<option value="costofsale">Giá vốn</option>
					<option value="volume">Số lượng</option>
					<option value="price">Giá</option>
					<option value="fee">Phí giao dich</option>
					<option value="tax">Thuế</option>
					<option value="total">Số tiền giao dịch</option>
					<option value="profit">Lợi nhuận</option>
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
                <button type="button" class="btn btn-success form-control" id="btnSortTransaction"><span class="fa fa-sort"></span> Sort</button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($transactions)) { foreach($transactions as $transaction) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>Mã giao dịch:</label> <?php echo $transaction['transactionid'] ?><br>
		<label>Tài khoản:</label> <?php echo $transaction['accountid'] ?><br>
		<label>Chủ tài khoản:</label> <?php echo $transaction['cardid'] ?><br>
		<label>Ngày giao dịch:</label> <?php echo $transaction['transactiondate'] ?><br>
		<label>Ngày nhận tiền(T+2):</label> <?php echo $transaction['receivemoneydate'] ?><br>
		<label>Ngày nhận ck(T+3):</label> <?php echo $transaction['receivestockdate'] ?><br>
		<label>Mã ck:</label> <?php echo $transaction['symbol'] ?><br>
		<label>Tên ck:</label> <?php echo $transaction['name'] ?><br>
		<label>Loại giao dịch:</label> <?php echo $transaction['type'] ?><br>
		<label>Giá vốn:</label> <?php echo $transaction['costofsale'] ?><br>
		<label>Số lượng:</label> <?php echo $transaction['volume'] ?><br>
		<label>Giá:</label> <?php echo $transaction['price'] ?><br>
		<label>Phí giao dich:</label> <?php echo $transaction['fee'] ?><br>
		<label>Thuế:</label> <?php echo $transaction['tax'] ?><br>
		<label>Số tiền giao dịch:</label> <?php echo $transaction['total'] ?><br>
		<label>Lợi nhuận:</label> <?php echo $transaction['profit'] ?><br>
		<label>Ghi chú:</label> <?php echo $transaction['notes'] ?><br>
		<label>Ngày tạo:</label> <?php echo $transaction['createdate'] ?><br>
		<label>Tạo bởi:</label> <?php echo $transaction['createby'] ?><br>
		<label>Ngày cập nhật:</label> <?php echo $transaction['updatedate'] ?><br>
		<label>Cập nhật bởi:</label> <?php echo $transaction['updateby'] ?><br>
		<label>Ngày xóa:</label> <?php echo $transaction['deletedate'] ?><br>
		<label>Xóa bởi:</label> <?php echo $transaction['deleteby'] ?><br>
		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnTransactionSelect"
                        transactionid="<?php echo $transaction['id']?>"
							transactionid="<?php echo $transaction['transactionid']?>"
							accountid="<?php echo $transaction['accountid']?>"
							cardid="<?php echo $transaction['cardid']?>"
							transactiondate="<?php echo $transaction['transactiondate']?>"
							receivemoneydate="<?php echo $transaction['receivemoneydate']?>"
							receivestockdate="<?php echo $transaction['receivestockdate']?>"
							symbol="<?php echo $transaction['symbol']?>"
							name="<?php echo $transaction['name']?>"
							type="<?php echo $transaction['type']?>"
							costofsale="<?php echo $transaction['costofsale']?>"
							volume="<?php echo $transaction['volume']?>"
							price="<?php echo $transaction['price']?>"
							fee="<?php echo $transaction['fee']?>"
							tax="<?php echo $transaction['tax']?>"
							total="<?php echo $transaction['total']?>"
							profit="<?php echo $transaction['profit']?>"
							notes="<?php echo $transaction['notes']?>"
							createdate="<?php echo $transaction['createdate']?>"
							createby="<?php echo $transaction['createby']?>"
							updatedate="<?php echo $transaction['updatedate']?>"
							updateby="<?php echo $transaction['updateby']?>"
							deletedate="<?php echo $transaction['deletedate']?>"
							deleteby="<?php echo $transaction['deleteby']?>"
							
                        ><span class="fa fa-check"></span> Select</button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_Transaction.showDeleteDialog(<?php echo $transaction['id']?>, '<?php echo $transaction['transactionid'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/transaction/update&id=<?php echo $transaction[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    trading_Transaction.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileTransaction #sortcol').val(sortcol);
        $('#fitermobileTransaction #sorttype').val(sorttype);
    
        $('#fitermobileTransaction #btnSortTransaction').click(function(){
            $('#frmTransactionSearch #sorttype').val($('#fitermobileTransaction #sorttype').val());
            $('#frmTransactionSearch #sortcol').val($('#fitermobileTransaction #sortcol').val());
            trading_Transaction.search();
        });
    $('#transaction-list th').each(function(e){
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
        $('#frmTransactionSearch #sorttype').val('asc');
        $('#frmTransactionSearch #sortcol').val($(this).attr('sortcol'));
        trading_Transaction.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmTransactionSearch #sorttype').val('desc');
        $('#frmTransactionSearch #sortcol').val($(this).attr('sortcol'));
        trading_Transaction.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmTransactionSearch #sorttype').val('asc');
        $('#frmTransactionSearch #sortcol').val($(this).attr('sortcol'));
        trading_Transaction.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>