<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th>No.</th>
                <th>Module Id</th>
				<th>Module Name</th>
				<th>Module Path</th>
				<th>Parent</th>
				<th>Icon</th>
				<th>Position</th>
				<th>Display</th>

                <th class="tool-title">Tool</th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($modules)) { foreach($modules as $module) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $module['moduleid'] ?></td>
				<td><div class="margin-left-<?php echo $module['level']*10 ?>"><?php echo $module['modulename'] ?></div></td>
				<td><?php echo $module['modulepath'] ?></td>
				<td><?php echo $this->document->getModule($module['moduleparent']) ?></td>
				<td><?php echo $module['moduleicon'] ?></td>
				<td><div class="margin-left-<?php echo $module['level']*10 ?>"><?php echo $module['position'] ?></div></td>
				<td><input type="checkbox" class="form-control input-sm chkisshow" value="1" moduleid="<?php echo $module['id']?>" <?php echo $module['isshow']?'checked':'';?>></td>
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnModuleSelect"
                            moduleid="<?php echo $module['id']?>"
							moduleid="<?php echo $module['moduleid']?>"
							modulename="<?php echo $module['modulename']?>"
							modulepath="<?php echo $module['modulepath']?>"
							moduleparent="<?php echo $module['moduleparent']?>"
							moduleicon="<?php echo $module['moduleicon']?>"
							position="<?php echo $module['position']?>"
							
                            ><span class="fa fa-check"></span> Select</button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_Module.showDeleteDialog(<?php echo $module['id']?>, '<?php echo $module['modulename'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/module/update&id=<?php echo $module[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/module/insert&parent=<?php echo $module['id'] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-plus"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileModule">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value="">Sort</option>
                    <option value="moduleid">Module Id</option>
					<option value="modulename">Module Name</option>
					<option value="modulepath">Module Path</option>
					<option value="moduleparent">Parent</option>
					<option value="moduleicon">Icon</option>
					<option value="position">Position</option>
					
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
                <button type="button" class="btn btn-success form-control" id="btnSortModule"><span class="fa fa-sort"></span> Sort</button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($modules)) { foreach($modules as $module) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>Module Id:</label> <?php echo $module['moduleid'] ?><br>
		<label>Module Name:</label> <?php echo $module['modulename'] ?><br>
		<label>Module Path:</label> <?php echo $module['modulepath'] ?><br>
		<label>Parent:</label> <?php echo $module['moduleparent'] ?><br>
		<label>Icon:</label> <?php echo $module['moduleicon'] ?><br>
		<label>Position:</label> <?php echo $module['position'] ?><br>
		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnModuleSelect"
                        moduleid="<?php echo $module['id']?>"
							moduleid="<?php echo $module['moduleid']?>"
							modulename="<?php echo $module['modulename']?>"
							modulepath="<?php echo $module['modulepath']?>"
							moduleparent="<?php echo $module['moduleparent']?>"
							moduleicon="<?php echo $module['moduleicon']?>"
							position="<?php echo $module['position']?>"
							
                        ><span class="fa fa-check"></span> Select</button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_Module.showDeleteDialog(<?php echo $module['id']?>, '<?php echo $module['modulename'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/module/update&id=<?php echo $module[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    elife_Module.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileModule #sortcol').val(sortcol);
        $('#fitermobileModule #sorttype').val(sorttype);
    
        $('#fitermobileModule #btnSortModule').click(function(){
            $('#frmModuleSearch #sorttype').val($('#fitermobileModule #sorttype').val());
            $('#frmModuleSearch #sortcol').val($('#fitermobileModule #sortcol').val());
            elife_Module.search();
        });
    $('#module-list th').each(function(e){
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
        $('#frmModuleSearch #sorttype').val('asc');
        $('#frmModuleSearch #sortcol').val($(this).attr('sortcol'));
        elife_Module.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmModuleSearch #sorttype').val('desc');
        $('#frmModuleSearch #sortcol').val($(this).attr('sortcol'));
        elife_Module.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmModuleSearch #sorttype').val('asc');
        $('#frmModuleSearch #sortcol').val($(this).attr('sortcol'));
        elife_Module.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>