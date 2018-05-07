<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th><?php echo $text_no?></th>
                <th class="sort-default" sortcol="usertypeid">User Type ID</th>
				<th class="sort-default" sortcol="usertypename">User Type Name</th>
				<th class="sort-default" sortcol="permission">Permission</th>
				
                <th class="tool-title"><?php echo $text_tool?></th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($usertypes)) { foreach($usertypes as $usertype) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $usertype['usertypeid'] ?></td>
				<td><?php echo $usertype['usertypename'] ?></td>
				<td><?php echo $usertype['permission'] ?></td>
				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnUsertypeSelect"
                            usertypeid="<?php echo $usertype['id']?>"
							usertypeid="<?php echo $usertype['usertypeid']?>"
							usertypename="<?php echo $usertype['usertypename']?>"
							usertypeparent="<?php echo $usertype['usertypeparent']?>"
							permission="<?php echo $usertype['permission']?>"
							
                            ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_Usertype.showDeleteDialog(<?php echo $usertype['id']?>, '<?php echo $usertype['usertypename'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/usertype/update&id=<?php echo $usertype[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileUsertype">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value=""><?php echo $text_sort?></option>
                    <option value="usertypeid">User Type ID</option>
					<option value="usertypename">User Type Name</option>
					<option value="usertypeparent">User Type Parent</option>
					<option value="permission">Permission</option>
					
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
                <button type="button" class="btn btn-success form-control" id="btnSortUsertype"><span class="fa fa-sort"></span> <?php echo $text_sort?></button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($usertypes)) { foreach($usertypes as $usertype) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>User Type ID:</label> <?php echo $usertype['usertypeid'] ?><br>
		<label>User Type Name:</label> <?php echo $usertype['usertypename'] ?><br>
		<label>Permission:</label> <?php echo $usertype['permission'] ?><br>
		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnUsertypeSelect"
                        usertypeid="<?php echo $usertype['id']?>"
							usertypeid="<?php echo $usertype['usertypeid']?>"
							usertypename="<?php echo $usertype['usertypename']?>"
							usertypeparent="<?php echo $usertype['usertypeparent']?>"
							permission="<?php echo $usertype['permission']?>"
							
                        ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_Usertype.showDeleteDialog(<?php echo $usertype['id']?>, '<?php echo $usertype['usertypename'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/usertype/update&id=<?php echo $usertype[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    elife_Usertype.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileUsertype #sortcol').val(sortcol);
        $('#fitermobileUsertype #sorttype').val(sorttype);
    
        $('#fitermobileUsertype #btnSortUsertype').click(function(){
            $('#frmUsertypeSearch #sorttype').val($('#fitermobileUsertype #sorttype').val());
            $('#frmUsertypeSearch #sortcol').val($('#fitermobileUsertype #sortcol').val());
            elife_Usertype.search();
        });
    $('#usertype-list th').each(function(e){
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
        $('#frmUsertypeSearch #sorttype').val('asc');
        $('#frmUsertypeSearch #sortcol').val($(this).attr('sortcol'));
        elife_Usertype.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmUsertypeSearch #sorttype').val('desc');
        $('#frmUsertypeSearch #sortcol').val($(this).attr('sortcol'));
        elife_Usertype.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmUsertypeSearch #sorttype').val('asc');
        $('#frmUsertypeSearch #sortcol').val($(this).attr('sortcol'));
        elife_Usertype.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>