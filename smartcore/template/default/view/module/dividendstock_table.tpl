<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th>No.</th>
                <th class="sort-default" sortcol="receivedate">Ngày nhận</th>
				<th class="sort-default" sortcol="deadline">Ngày chốt quyền</th>
				<th class="sort-default" sortcol="symbol">Mã chứng khoán</th>
				<th class="sort-default" sortcol="accountid">Tài khoản nhận</th>
				<th class="sort-default" sortcol="transactionid">Mã giao dịch</th>
				<th class="sort-default" sortcol="price">Giá phát hành</th>
				<th class="sort-default" sortcol="dividendrate">Tỷ lệ phát hành</th>
				<th class="sort-default" sortcol="quantity">Số lượng mua</th>
				<th class="sort-default" sortcol="quantityallowbuy">Số lượng được mua</th>
				<th class="sort-default" sortcol="quantityallowreceive">Số cổ phiếu được nhận</th>
				<th>Số tiền mua</th>
				<th class="sort-default" sortcol="notes">Ghi chú</th>

				
                <th class="tool-title">Tool</th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($dividendstocks)) { foreach($dividendstocks as $dividendstock) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $this->date->formatMySQLDate($dividendstock['receivedate']) ?></td>
				<td><?php echo $this->date->formatMySQLDate($dividendstock['deadline']) ?></td>
				<td><?php echo $dividendstock['symbol'] ?></td>
				<td><?php echo $dividendstock['accountid']?> - <?php echo $this->document->getCard($this->document->getAccountstock($dividendstock['accountid'])) ?></td>
				<td><?php echo $dividendstock['transactionid'] ?></td>
				<td class="number"><?php echo $this->string->numberFormate($dividendstock['price']) ?></td>
				<td class="number"><?php echo $this->string->numberFormate($dividendstock['dividendrate']) ?></td>
				<td class="number"><?php echo $this->string->numberFormate($dividendstock['quantity']) ?></td>
				<td class="number"><?php echo $this->string->numberFormate($dividendstock['quantityallowbuy']) ?></td>
				<td class="number"><?php echo $this->string->numberFormate($dividendstock['quantityallowreceive']) ?></td>
				<td class="number"><?php echo $this->string->numberFormate($dividendstock['price']*$dividendstock['quantity']) ?></td>
				<td><?php echo $dividendstock['notes'] ?></td>

				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnDividendStockSelect"
                            dividendstockid="<?php echo $dividendstock['id']?>"
							receivedate="<?php echo $dividendstock['receivedate']?>"
							deadline="<?php echo $dividendstock['deadline']?>"
							symbol="<?php echo $dividendstock['symbol']?>"
							accountid="<?php echo $dividendstock['accountid']?>"
							transactionid="<?php echo $dividendstock['transactionid']?>"
							price="<?php echo $dividendstock['price']?>"
							dividendrate="<?php echo $dividendstock['dividendrate']?>"
							quantity="<?php echo $dividendstock['quantity']?>"
							quantityallowbuy="<?php echo $dividendstock['quantityallowbuy']?>"
							quantityallowreceive="<?php echo $dividendstock['quantityallowreceive']?>"
							notes="<?php echo $dividendstock['notes']?>"
							createdate="<?php echo $dividendstock['createdate']?>"
							createby="<?php echo $dividendstock['createby']?>"
							updatedate="<?php echo $dividendstock['updatedate']?>"
							updateby="<?php echo $dividendstock['updateby']?>"
							deletedate="<?php echo $dividendstock['deletedate']?>"
							deleteby="<?php echo $dividendstock['deleteby']?>"
							
                            ><span class="fa fa-check"></span> Select</button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_DividendStock.showDeleteDialog(<?php echo $dividendstock['id']?>, '<?php echo $dividendstock['symbol'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/dividendstock/update&id=<?php echo $dividendstock[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileDividendStock">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value="">Sort</option>
                    <option value="receivedate">Ngày nhận</option>
					<option value="deadline">Ngày chốt quyền</option>
					<option value="symbol">Mã chứng khoán</option>
					<option value="accountid">Tài khoản nhận</option>
					<option value="transactionid">Mã giao dịch</option>
					<option value="price">Giá phát hành</option>
					<option value="dividendrate">Tỷ lệ phát hành</option>
					<option value="quantity">Số lượng mua</option>
					<option value="quantityallowbuy">Số lượng được mua</option>
					<option value="quantityallowreceive">Số cổ phiếu được nhận</option>
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
                <button type="button" class="btn btn-success form-control" id="btnSortDividendStock"><span class="fa fa-sort"></span> Sort</button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($dividendstocks)) { foreach($dividendstocks as $dividendstock) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>Ngày nhận:</label> <?php echo $dividendstock['receivedate'] ?><br>
		<label>Ngày chốt quyền:</label> <?php echo $dividendstock['deadline'] ?><br>
		<label>Mã chứng khoán:</label> <?php echo $dividendstock['symbol'] ?><br>
		<label>Tài khoản nhận:</label> <?php echo $dividendstock['accountid'] ?><br>
		<label>Mã giao dịch:</label> <?php echo $dividendstock['transactionid'] ?><br>
		<label>Giá phát hành:</label> <?php echo $dividendstock['price'] ?><br>
		<label>Tỷ lệ phát hành:</label> <?php echo $dividendstock['dividendrate'] ?><br>
		<label>Số lượng mua:</label> <?php echo $dividendstock['quantity'] ?><br>
		<label>Số lượng được mua:</label> <?php echo $dividendstock['quantityallowbuy'] ?><br>
		<label>Số cổ phiếu được nhận:</label> <?php echo $dividendstock['quantityallowreceive'] ?><br>
		<label>Ghi chú:</label> <?php echo $dividendstock['notes'] ?><br>

		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnDividendStockSelect"
                        dividendstockid="<?php echo $dividendstock['id']?>"
							receivedate="<?php echo $dividendstock['receivedate']?>"
							deadline="<?php echo $dividendstock['deadline']?>"
							symbol="<?php echo $dividendstock['symbol']?>"
							accountid="<?php echo $dividendstock['accountid']?>"
							transactionid="<?php echo $dividendstock['transactionid']?>"
							price="<?php echo $dividendstock['price']?>"
							dividendrate="<?php echo $dividendstock['dividendrate']?>"
							quantity="<?php echo $dividendstock['quantity']?>"
							quantityallowbuy="<?php echo $dividendstock['quantityallowbuy']?>"
							quantityallowreceive="<?php echo $dividendstock['quantityallowreceive']?>"
							notes="<?php echo $dividendstock['notes']?>"
							createdate="<?php echo $dividendstock['createdate']?>"
							createby="<?php echo $dividendstock['createby']?>"
							updatedate="<?php echo $dividendstock['updatedate']?>"
							updateby="<?php echo $dividendstock['updateby']?>"
							deletedate="<?php echo $dividendstock['deletedate']?>"
							deleteby="<?php echo $dividendstock['deleteby']?>"
							
                        ><span class="fa fa-check"></span> Select</button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_DividendStock.showDeleteDialog(<?php echo $dividendstock['id']?>, '<?php echo $dividendstock['symbol'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/dividendstock/update&id=<?php echo $dividendstock[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    trading_DividendStock.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileDividendStock #sortcol').val(sortcol);
        $('#fitermobileDividendStock #sorttype').val(sorttype);
    
        $('#fitermobileDividendStock #btnSortDividendStock').click(function(){
            $('#frmDividendStockSearch #sorttype').val($('#fitermobileDividendStock #sorttype').val());
            $('#frmDividendStockSearch #sortcol').val($('#fitermobileDividendStock #sortcol').val());
            trading_DividendStock.search();
        });
    $('#dividendstock-list th').each(function(e){
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
        $('#frmDividendStockSearch #sorttype').val('asc');
        $('#frmDividendStockSearch #sortcol').val($(this).attr('sortcol'));
        trading_DividendStock.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmDividendStockSearch #sorttype').val('desc');
        $('#frmDividendStockSearch #sortcol').val($(this).attr('sortcol'));
        trading_DividendStock.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmDividendStockSearch #sorttype').val('asc');
        $('#frmDividendStockSearch #sortcol').val($(this).attr('sortcol'));
        trading_DividendStock.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>