<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th>No.</th>
                <th class="sort-default" sortcol="symbol">Mã chứng khoáng</th>
				<th class="sort-default" sortcol="name">Tên chứng khoáng</th>
				
                <th class="tool-title">Tool</th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($items)) { foreach($items as $item) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $item['symbol'] ?></td>
				<td><?php echo $item['name'] ?></td>
				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnItemSelect"
                            itemid="<?php echo $item['id']?>"
							symbol="<?php echo $item['symbol']?>"
							name="<?php echo $item['name']?>"
							
                            ><span class="fa fa-check"></span> Select</button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_Item.showDeleteDialog(<?php echo $item['id']?>, '<?php echo $item['symbol'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/item/update&id=<?php echo $item[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileItem">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value="">Sort</option>
                    <option value="symbol">Mã chứng khoáng</option>
					<option value="name">Tên chứng khoáng</option>
					
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
                <button type="button" class="btn btn-success form-control" id="btnSortItem"><span class="fa fa-sort"></span> Sort</button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($items)) { foreach($items as $item) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>Mã chứng khoáng:</label> <?php echo $item['symbol'] ?><br>
		<label>Tên chứng khoáng:</label> <?php echo $item['name'] ?><br>
		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnItemSelect"
                        itemid="<?php echo $item['id']?>"
							symbol="<?php echo $item['symbol']?>"
							name="<?php echo $item['name']?>"
							
                        ><span class="fa fa-check"></span> Select</button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="trading_Item.showDeleteDialog(<?php echo $item['id']?>, '<?php echo $item['symbol'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/item/update&id=<?php echo $item[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    trading_Item.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileItem #sortcol').val(sortcol);
        $('#fitermobileItem #sorttype').val(sorttype);
    
        $('#fitermobileItem #btnSortItem').click(function(){
            $('#frmItemSearch #sorttype').val($('#fitermobileItem #sorttype').val());
            $('#frmItemSearch #sortcol').val($('#fitermobileItem #sortcol').val());
            trading_Item.search();
        });
    $('#item-list th').each(function(e){
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
        $('#frmItemSearch #sorttype').val('asc');
        $('#frmItemSearch #sortcol').val($(this).attr('sortcol'));
        trading_Item.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmItemSearch #sorttype').val('desc');
        $('#frmItemSearch #sortcol').val($(this).attr('sortcol'));
        trading_Item.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmItemSearch #sorttype').val('asc');
        $('#frmItemSearch #sortcol').val($(this).attr('sortcol'));
        trading_Item.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>