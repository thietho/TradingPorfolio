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
				<th class="sort-default" sortcol="amount">Số tiền</th>
				<th class="sort-default" sortcol="notes">Ghi chú</th>

				
                <th class="tool-title">Tool</th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($dividendcashs)) { foreach($dividendcashs as $dividendcash) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $this->date->formatMySQLDate($dividendcash['receivedate']) ?></td>
				<td><?php echo $this->date->formatMySQLDate($dividendcash['deadline']) ?></td>
				<td><?php echo $dividendcash['symbol'] ?></td>
				<td><?php echo $dividendcash['accountid']?> - <?php echo $this->document->getCard($this->document->getAccountstock($dividendcash['accountid'])) ?></td>
				<td class="number"><?php echo $this->string->numberFormate($dividendcash['amount']) ?></td>
				<td><?php echo $dividendcash['notes'] ?></td>

				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnDividendCashSelect"
                            dividendcashid="<?php echo $dividendcash['id']?>"
							receivedate="<?php echo $dividendcash['receivedate']?>"
							deadline="<?php echo $dividendcash['deadline']?>"
							symbol="<?php echo $dividendcash['symbol']?>"
							accountid="<?php echo $dividendcash['accountid']?>"
							amount="<?php echo $dividendcash['amount']?>"
							notes="<?php echo $dividendcash['notes']?>"
							createdate="<?php echo $dividendcash['createdate']?>"
							createby="<?php echo $dividendcash['createby']?>"
							updatedate="<?php echo $dividendcash['updatedate']?>"
							updateby="<?php echo $dividendcash['updateby']?>"
							deletedate="<?php echo $dividendcash['deletedate']?>"
							deleteby="<?php echo $dividendcash['deleteby']?>"
							
                            ><span class="fa fa-check"></span> Select</button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_DividendCash.showDeleteDialog(<?php echo $dividendcash['id']?>, '<?php echo $dividendcash['symbol'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/dividendcash/update&id=<?php echo $dividendcash[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileDividendCash">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value="">Sort</option>
                    <option value="receivedate">Ngày nhận</option>
					<option value="deadline">Ngày chốt quyền</option>
					<option value="symbol">Mã chứng khoán</option>
					<option value="accountid">Tài khoản nhận</option>
					<option value="amount">Số tiền</option>
					<option value="notes">Ghi chú</option>

					
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
                <button type="button" class="btn btn-success form-control" id="btnSortDividendCash"><span class="fa fa-sort"></span> Sort</button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($dividendcashs)) { foreach($dividendcashs as $dividendcash) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>Ngày nhận:</label> <?php echo $dividendcash['receivedate'] ?><br>
		<label>Ngày chốt quyền:</label> <?php echo $dividendcash['deadline'] ?><br>
		<label>Mã chứng khoán:</label> <?php echo $dividendcash['symbol'] ?><br>
		<label>Tài khoản nhận:</label> <?php echo $dividendcash['accountid'] ?><br>
		<label>Số tiền:</label> <?php echo $dividendcash['amount'] ?><br>
		<label>Ghi chú:</label> <?php echo $dividendcash['notes'] ?><br>

		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnDividendCashSelect"
                        dividendcashid="<?php echo $dividendcash['id']?>"
							receivedate="<?php echo $dividendcash['receivedate']?>"
							deadline="<?php echo $dividendcash['deadline']?>"
							symbol="<?php echo $dividendcash['symbol']?>"
							accountid="<?php echo $dividendcash['accountid']?>"
							amount="<?php echo $dividendcash['amount']?>"
							notes="<?php echo $dividendcash['notes']?>"
							createdate="<?php echo $dividendcash['createdate']?>"
							createby="<?php echo $dividendcash['createby']?>"
							updatedate="<?php echo $dividendcash['updatedate']?>"
							updateby="<?php echo $dividendcash['updateby']?>"
							deletedate="<?php echo $dividendcash['deletedate']?>"
							deleteby="<?php echo $dividendcash['deleteby']?>"
							
                        ><span class="fa fa-check"></span> Select</button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_DividendCash.showDeleteDialog(<?php echo $dividendcash['id']?>, '<?php echo $dividendcash['symbol'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/dividendcash/update&id=<?php echo $dividendcash[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    trading_DividendCash.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileDividendCash #sortcol').val(sortcol);
        $('#fitermobileDividendCash #sorttype').val(sorttype);
    
        $('#fitermobileDividendCash #btnSortDividendCash').click(function(){
            $('#frmDividendCashSearch #sorttype').val($('#fitermobileDividendCash #sorttype').val());
            $('#frmDividendCashSearch #sortcol').val($('#fitermobileDividendCash #sortcol').val());
            trading_DividendCash.search();
        });
    $('#dividendcash-list th').each(function(e){
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
        $('#frmDividendCashSearch #sorttype').val('asc');
        $('#frmDividendCashSearch #sortcol').val($(this).attr('sortcol'));
        trading_DividendCash.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmDividendCashSearch #sorttype').val('desc');
        $('#frmDividendCashSearch #sortcol').val($(this).attr('sortcol'));
        trading_DividendCash.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmDividendCashSearch #sorttype').val('asc');
        $('#frmDividendCashSearch #sortcol').val($(this).attr('sortcol'));
        trading_DividendCash.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>