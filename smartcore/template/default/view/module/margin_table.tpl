<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th>No.</th>
                <th class="sort-default" sortcol="opendate">Ngày phụ lục</th>
				<th class="sort-default" sortcol="closedate">Ngày thanh lý</th>
				<th class="sort-default" sortcol="amount">Giá trị</th>
				<th class="sort-default" sortcol="countdate">Ngày nắm giử</th>
				<th class="sort-default" sortcol="rate">Lãi xuất</th>
				<th class="sort-default" sortcol="totalpay">Tổng trả</th>
				<th class="sort-default" sortcol="cardid">Người nhận</th>
				<th class="sort-default" sortcol="accountid">Tài khoản nhận</th>
				<th class="sort-default" sortcol="transactionid">Tạo từ giao dịch</th>
				<th class="sort-default" sortcol="createdate">Ngày tạo</th>
				<th class="sort-default" sortcol="createby">Tạo bởi</th>
				<th class="sort-default" sortcol="updatedate">Ngày cập nhật</th>
				<th class="sort-default" sortcol="updateby">Cập nhật bởi</th>
				<th class="sort-default" sortcol="deletedate">Ngày xóa</th>
				<th class="sort-default" sortcol="deleteby">Xóa bởi</th>
				
                <th class="tool-title">Tool</th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($margins)) { foreach($margins as $margin) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $margin['opendate'] ?></td>
				<td><?php echo $margin['closedate'] ?></td>
				<td><?php echo $margin['amount'] ?></td>
				<td><?php echo $margin['countdate'] ?></td>
				<td><?php echo $margin['rate'] ?></td>
				<td><?php echo $margin['totalpay'] ?></td>
				<td><?php echo $margin['cardid'] ?></td>
				<td><?php echo $margin['accountid'] ?></td>
				<td><?php echo $margin['transactionid'] ?></td>
				<td><?php echo $margin['createdate'] ?></td>
				<td><?php echo $margin['createby'] ?></td>
				<td><?php echo $margin['updatedate'] ?></td>
				<td><?php echo $margin['updateby'] ?></td>
				<td><?php echo $margin['deletedate'] ?></td>
				<td><?php echo $margin['deleteby'] ?></td>
				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnMarginSelect"
                            marginid="<?php echo $margin['id']?>"
							opendate="<?php echo $margin['opendate']?>"
							closedate="<?php echo $margin['closedate']?>"
							amount="<?php echo $margin['amount']?>"
							countdate="<?php echo $margin['countdate']?>"
							rate="<?php echo $margin['rate']?>"
							totalpay="<?php echo $margin['totalpay']?>"
							cardid="<?php echo $margin['cardid']?>"
							accountid="<?php echo $margin['accountid']?>"
							transactionid="<?php echo $margin['transactionid']?>"
							createdate="<?php echo $margin['createdate']?>"
							createby="<?php echo $margin['createby']?>"
							updatedate="<?php echo $margin['updatedate']?>"
							updateby="<?php echo $margin['updateby']?>"
							deletedate="<?php echo $margin['deletedate']?>"
							deleteby="<?php echo $margin['deleteby']?>"
							
                            ><span class="fa fa-check"></span> Select</button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_Margin.showDeleteDialog(<?php echo $margin['id']?>, '<?php echo $margin['symbol'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/margin/update&id=<?php echo $margin[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileMargin">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value="">Sort</option>
                    <option value="opendate">Ngày phụ lục</option>
					<option value="closedate">Ngày thanh lý</option>
					<option value="amount">Giá trị</option>
					<option value="countdate">Ngày nắm giử</option>
					<option value="rate">Lãi xuất</option>
					<option value="totalpay">Tổng trả</option>
					<option value="cardid">Người nhận</option>
					<option value="accountid">Tài khoản nhận</option>
					<option value="transactionid">Tạo từ giao dịch</option>
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
                <button type="button" class="btn btn-success form-control" id="btnSortMargin"><span class="fa fa-sort"></span> Sort</button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($margins)) { foreach($margins as $margin) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>Ngày phụ lục:</label> <?php echo $margin['opendate'] ?><br>
		<label>Ngày thanh lý:</label> <?php echo $margin['closedate'] ?><br>
		<label>Giá trị:</label> <?php echo $margin['amount'] ?><br>
		<label>Ngày nắm giử:</label> <?php echo $margin['countdate'] ?><br>
		<label>Lãi xuất:</label> <?php echo $margin['rate'] ?><br>
		<label>Tổng trả:</label> <?php echo $margin['totalpay'] ?><br>
		<label>Người nhận:</label> <?php echo $margin['cardid'] ?><br>
		<label>Tài khoản nhận:</label> <?php echo $margin['accountid'] ?><br>
		<label>Tạo từ giao dịch:</label> <?php echo $margin['transactionid'] ?><br>
		<label>Ngày tạo:</label> <?php echo $margin['createdate'] ?><br>
		<label>Tạo bởi:</label> <?php echo $margin['createby'] ?><br>
		<label>Ngày cập nhật:</label> <?php echo $margin['updatedate'] ?><br>
		<label>Cập nhật bởi:</label> <?php echo $margin['updateby'] ?><br>
		<label>Ngày xóa:</label> <?php echo $margin['deletedate'] ?><br>
		<label>Xóa bởi:</label> <?php echo $margin['deleteby'] ?><br>
		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnMarginSelect"
                        marginid="<?php echo $margin['id']?>"
							opendate="<?php echo $margin['opendate']?>"
							closedate="<?php echo $margin['closedate']?>"
							amount="<?php echo $margin['amount']?>"
							countdate="<?php echo $margin['countdate']?>"
							rate="<?php echo $margin['rate']?>"
							totalpay="<?php echo $margin['totalpay']?>"
							cardid="<?php echo $margin['cardid']?>"
							accountid="<?php echo $margin['accountid']?>"
							transactionid="<?php echo $margin['transactionid']?>"
							createdate="<?php echo $margin['createdate']?>"
							createby="<?php echo $margin['createby']?>"
							updatedate="<?php echo $margin['updatedate']?>"
							updateby="<?php echo $margin['updateby']?>"
							deletedate="<?php echo $margin['deletedate']?>"
							deleteby="<?php echo $margin['deleteby']?>"
							
                        ><span class="fa fa-check"></span> Select</button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_Margin.showDeleteDialog(<?php echo $margin['id']?>, '<?php echo $margin['symbol'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/margin/update&id=<?php echo $margin[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    trading_Margin.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileMargin #sortcol').val(sortcol);
        $('#fitermobileMargin #sorttype').val(sorttype);
    
        $('#fitermobileMargin #btnSortMargin').click(function(){
            $('#frmMarginSearch #sorttype').val($('#fitermobileMargin #sorttype').val());
            $('#frmMarginSearch #sortcol').val($('#fitermobileMargin #sortcol').val());
            trading_Margin.search();
        });
    $('#margin-list th').each(function(e){
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
        $('#frmMarginSearch #sorttype').val('asc');
        $('#frmMarginSearch #sortcol').val($(this).attr('sortcol'));
        trading_Margin.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmMarginSearch #sorttype').val('desc');
        $('#frmMarginSearch #sortcol').val($(this).attr('sortcol'));
        trading_Margin.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmMarginSearch #sorttype').val('asc');
        $('#frmMarginSearch #sortcol').val($(this).attr('sortcol'));
        trading_Margin.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>