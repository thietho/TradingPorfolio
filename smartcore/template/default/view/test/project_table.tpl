<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th><?php echo $text_no?></th>
                <th class="sort-default" sortcol="projectname">Project name</th>
				<th class="sort-default" sortcol="createdate">Create date</th>
				<th class="sort-default" sortcol="description"><?php echo $text_description?></th>
				<th class="sort-default" sortcol="color">Color</th>
				<th class="sort-default" sortcol="portfolioid">Portfolioid</th>
				
                <th class="tool-title"><?php echo $text_tool?></th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($projects)) { foreach($projects as $project) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $project['projectname'] ?></td>
				<td><?php echo $project['createdate'] ?></td>
				<td><?php echo $project['description'] ?></td>
				<td><?php echo $project['color'] ?></td>
				<td><?php echo $project['portfolioid'] ?></td>
				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnProjectSelect"
                            projectid="<?php echo $project['id']?>"
							projectname="<?php echo $project['projectname']?>"
							createdate="<?php echo $project['createdate']?>"
							description="<?php echo $project['description']?>"
							color="<?php echo $project['color']?>"
							portfolioid="<?php echo $project['portfolioid']?>"
							
                            ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_Project.showDeleteDialog(<?php echo $project['id']?>, '<?php echo $project['projectname'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=test/project/update&id=<?php echo $project[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileProject">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value=""><?php echo $text_sort?></option>
                    <option value="projectname">Project name</option>
					<option value="createdate">Create date</option>
					<option value="description"><?php echo $text_description?></option>
					<option value="color">Color</option>
					<option value="portfolioid">Portfolioid</option>
					
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
                <button type="button" class="btn btn-success form-control" id="btnSortProject"><span class="fa fa-sort"></span> <?php echo $text_sort?></button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($projects)) { foreach($projects as $project) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>Project name:</label> <?php echo $project['projectname'] ?><br>
		<label>Create date:</label> <?php echo $project['createdate'] ?><br>
		<label><?php echo $text_description?>:</label> <?php echo $project['description'] ?><br>
		<label>Color:</label> <?php echo $project['color'] ?><br>
		<label>Portfolioid:</label> <?php echo $project['portfolioid'] ?><br>
		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnProjectSelect"
                        projectid="<?php echo $project['id']?>"
							projectname="<?php echo $project['projectname']?>"
							createdate="<?php echo $project['createdate']?>"
							description="<?php echo $project['description']?>"
							color="<?php echo $project['color']?>"
							portfolioid="<?php echo $project['portfolioid']?>"
							
                        ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_Project.showDeleteDialog(<?php echo $project['id']?>, '<?php echo $project['projectname'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=test/project/update&id=<?php echo $project[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileProject #sortcol').val(sortcol);
        $('#fitermobileProject #sorttype').val(sorttype);
    
        $('#fitermobileProject #btnSortProject').click(function(){
            $('#frmProjectSearch #sorttype').val($('#fitermobileProject #sorttype').val());
            $('#frmProjectSearch #sortcol').val($('#fitermobileProject #sortcol').val());
            elife_Project.search();
        });
    $('#project-list th').each(function(e){
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
        $('#frmProjectSearch #sorttype').val('asc');
        $('#frmProjectSearch #sortcol').val($(this).attr('sortcol'));
        elife_Project.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmProjectSearch #sorttype').val('desc');
        $('#frmProjectSearch #sortcol').val($(this).attr('sortcol'));
        elife_Project.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmProjectSearch #sorttype').val('asc');
        $('#frmProjectSearch #sortcol').val($(this).attr('sortcol'));
        elife_Project.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>