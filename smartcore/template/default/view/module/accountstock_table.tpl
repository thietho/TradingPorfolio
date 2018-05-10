<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th>No.</th>
                <th class="sort-default" sortcol="accountid">Tài khoản</th>
				<th class="sort-default" sortcol="openat">Mở tại</th>
				<th class="sort-default" sortcol="buyfee">Phí mua</th>
				<th class="sort-default" sortcol="salefee">Phí bán</th>
				<th class="sort-default" sortcol="marginrate">Lãi xuất margin</th>
				<th class="sort-default" sortcol="cardid">Chủ tài khoản</th>
				<th class="sort-default" sortcol="status">Trạng thái</th>
				<th class="sort-default" sortcol="depositfee">Phí lưu ký ck</th>
				
                <th class="tool-title">Tool</th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($accountstocks)) { foreach($accountstocks as $accountstock) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $accountstock['accountid'] ?></td>
				<td><?php echo $accountstock['openat'] ?></td>
				<td><?php echo $accountstock['buyfee'] ?></td>
				<td><?php echo $accountstock['salefee'] ?></td>
				<td><?php echo $accountstock['marginrate'] ?></td>
				<td><?php echo $accountstock['cardid'] ?></td>
				<td><?php echo $accountstock['status'] ?></td>
				<td><?php echo $accountstock['depositfee'] ?></td>
				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnAccountStockSelect"
                            accountstockid="<?php echo $accountstock['id']?>"
							accountid="<?php echo $accountstock['accountid']?>"
							openat="<?php echo $accountstock['openat']?>"
							buyfee="<?php echo $accountstock['buyfee']?>"
							salefee="<?php echo $accountstock['salefee']?>"
							marginrate="<?php echo $accountstock['marginrate']?>"
							cardid="<?php echo $accountstock['cardid']?>"
							status="<?php echo $accountstock['status']?>"
							depositfee="<?php echo $accountstock['depositfee']?>"
							
                            ><span class="fa fa-check"></span> Select</button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_AccountStock.showDeleteDialog(<?php echo $accountstock['id']?>, '<?php echo $accountstock['accountid'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/accountstock/update&id=<?php echo $accountstock[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileAccountStock">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value="">Sort</option>
                    <option value="accountid">Tài khoản</option>
					<option value="openat">Mở tại</option>
					<option value="buyfee">Phí mua</option>
					<option value="salefee">Phí bán</option>
					<option value="marginrate">Lãi xuất margin</option>
					<option value="cardid">Chủ tài khoản</option>
					<option value="status">Trạng thái</option>
					<option value="depositfee">Phí lưu ký ck</option>
					
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
                <button type="button" class="btn btn-success form-control" id="btnSortAccountStock"><span class="fa fa-sort"></span> Sort</button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($accountstocks)) { foreach($accountstocks as $accountstock) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>Tài khoản:</label> <?php echo $accountstock['accountid'] ?><br>
		<label>Mở tại:</label> <?php echo $accountstock['openat'] ?><br>
		<label>Phí mua:</label> <?php echo $accountstock['buyfee'] ?><br>
		<label>Phí bán:</label> <?php echo $accountstock['salefee'] ?><br>
		<label>Lãi xuất margin:</label> <?php echo $accountstock['marginrate'] ?><br>
		<label>Chủ tài khoản:</label> <?php echo $accountstock['cardid'] ?><br>
		<label>Trạng thái:</label> <?php echo $accountstock['status'] ?><br>
		<label>Phí lưu ký ck:</label> <?php echo $accountstock['depositfee'] ?><br>
		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnAccountStockSelect"
                        accountstockid="<?php echo $accountstock['id']?>"
							accountid="<?php echo $accountstock['accountid']?>"
							openat="<?php echo $accountstock['openat']?>"
							buyfee="<?php echo $accountstock['buyfee']?>"
							salefee="<?php echo $accountstock['salefee']?>"
							marginrate="<?php echo $accountstock['marginrate']?>"
							cardid="<?php echo $accountstock['cardid']?>"
							status="<?php echo $accountstock['status']?>"
							depositfee="<?php echo $accountstock['depositfee']?>"
							
                        ><span class="fa fa-check"></span> Select</button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_AccountStock.showDeleteDialog(<?php echo $accountstock['id']?>, '<?php echo $accountstock['accountid'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/accountstock/update&id=<?php echo $accountstock[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    trading_AccountStock.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileAccountStock #sortcol').val(sortcol);
        $('#fitermobileAccountStock #sorttype').val(sorttype);
    
        $('#fitermobileAccountStock #btnSortAccountStock').click(function(){
            $('#frmAccountStockSearch #sorttype').val($('#fitermobileAccountStock #sorttype').val());
            $('#frmAccountStockSearch #sortcol').val($('#fitermobileAccountStock #sortcol').val());
            trading_AccountStock.search();
        });
    $('#accountstock-list th').each(function(e){
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
        $('#frmAccountStockSearch #sorttype').val('asc');
        $('#frmAccountStockSearch #sortcol').val($(this).attr('sortcol'));
        trading_AccountStock.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmAccountStockSearch #sorttype').val('desc');
        $('#frmAccountStockSearch #sortcol').val($(this).attr('sortcol'));
        trading_AccountStock.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmAccountStockSearch #sorttype').val('asc');
        $('#frmAccountStockSearch #sortcol').val($(this).attr('sortcol'));
        trading_AccountStock.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>