<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th><?php echo $text_no?></th>
                <th class="sort-default" sortcol="userid">User Id</th>
				<th class="sort-default" sortcol="usertypeid">User Type Name</th>
				<th class="sort-default" sortcol="username"><?php echo $text_user_name?></th>
				<th class="sort-default" sortcol="password"><?php echo $text_password?></th>
				<th class="sort-default" sortcol="fullname"><?php echo $text_full_name?></th>
				<th class="sort-default" sortcol="email">Email</th>
				<th class="sort-default" sortcol="status"><?php echo $text_status?></th>
				<th class="sort-default" sortcol="imagepath">Image Path</th>
				<th class="sort-default" sortcol="phone"><?php echo $text_phone?></th>
				<th class="sort-default" sortcol="activedate">Active Date</th>
				<th class="sort-default" sortcol="updateddate">Updated Date</th>
				<th class="sort-default" sortcol="deleteddate">Deleted Date</th>
				<th class="sort-default" sortcol="activeby">Active by</th>
				<th class="sort-default" sortcol="updatedby">Updated by</th>
				<th class="sort-default" sortcol="deletedby">Deleted by</th>
				<th class="sort-default" sortcol="userip">User Ip</th>
				<th class="sort-default" sortcol="permission">Permission</th>
				
                <th class="tool-title"><?php echo $text_tool?></th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($users)) { foreach($users as $user) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $user['userid'] ?></td>
				<td><?php echo $user['usertypeid'] ?></td>
				<td><?php echo $user['username'] ?></td>
				<td><?php echo $user['password'] ?></td>
				<td><?php echo $user['fullname'] ?></td>
				<td><?php echo $user['email'] ?></td>
				<td><?php echo $user['status'] ?></td>
				<td><?php echo $user['imagepath'] ?></td>
				<td><?php echo $user['phone'] ?></td>
				<td><?php echo $user['activedate'] ?></td>
				<td><?php echo $user['updateddate'] ?></td>
				<td><?php echo $user['deleteddate'] ?></td>
				<td><?php echo $user['activeby'] ?></td>
				<td><?php echo $user['updatedby'] ?></td>
				<td><?php echo $user['deletedby'] ?></td>
				<td><?php echo $user['userip'] ?></td>
				<td><?php echo $user['permission'] ?></td>
				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnUserSelect"
                            userid="<?php echo $user['id']?>"
							userid="<?php echo $user['userid']?>"
							usertypeid="<?php echo $user['usertypeid']?>"
							username="<?php echo $user['username']?>"
							password="<?php echo $user['password']?>"
							fullname="<?php echo $user['fullname']?>"
							email="<?php echo $user['email']?>"
							status="<?php echo $user['status']?>"
							imagepath="<?php echo $user['imagepath']?>"
							phone="<?php echo $user['phone']?>"
							activedate="<?php echo $user['activedate']?>"
							updateddate="<?php echo $user['updateddate']?>"
							deleteddate="<?php echo $user['deleteddate']?>"
							activeby="<?php echo $user['activeby']?>"
							updatedby="<?php echo $user['updatedby']?>"
							deletedby="<?php echo $user['deletedby']?>"
							userip="<?php echo $user['userip']?>"
							permission="<?php echo $user['permission']?>"
							
                            ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_User.showDeleteDialog(<?php echo $user['id']?>, '<?php echo $user['username'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/user/update&id=<?php echo $user[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileUser">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value=""><?php echo $text_sort?></option>
                    <option value="userid">User Id</option>
					<option value="usertypeid">User Type Name</option>
					<option value="username"><?php echo $text_user_name?></option>
					<option value="password"><?php echo $text_password?></option>
					<option value="fullname"><?php echo $text_full_name?></option>
					<option value="email">Email</option>
					<option value="status"><?php echo $text_status?></option>
					<option value="imagepath">Image Path</option>
					<option value="phone"><?php echo $text_phone?></option>
					<option value="activedate">Active Date</option>
					<option value="updateddate">Updated Date</option>
					<option value="deleteddate">Deleted Date</option>
					<option value="activeby">Active by</option>
					<option value="updatedby">Updated by</option>
					<option value="deletedby">Deleted by</option>
					<option value="userip">User Ip</option>
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
                <button type="button" class="btn btn-success form-control" id="btnSortUser"><span class="fa fa-sort"></span> <?php echo $text_sort?></button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($users)) { foreach($users as $user) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>User Id:</label> <?php echo $user['userid'] ?><br>
		<label>User Type Name:</label> <?php echo $user['usertypeid'] ?><br>
		<label><?php echo $text_user_name?>:</label> <?php echo $user['username'] ?><br>
		<label>Password:</label> <?php echo $user['password'] ?><br>
		<label><?php echo $text_full_name?>:</label> <?php echo $user['fullname'] ?><br>
		<label>Email:</label> <?php echo $user['email'] ?><br>
		<label><?php echo $text_status?>:</label> <?php echo $user['status'] ?><br>
		<label>Image Path:</label> <?php echo $user['imagepath'] ?><br>
		<label><?php echo $text_phone?>:</label> <?php echo $user['phone'] ?><br>
		<label>Active <?php echo $text_date?>:</label> <?php echo $user['activedate'] ?><br>
		<label>Updated <?php echo $text_date?>:</label> <?php echo $user['updateddate'] ?><br>
		<label>Deleted <?php echo $text_date?>:</label> <?php echo $user['deleteddate'] ?><br>
		<label>Active by:</label> <?php echo $user['activeby'] ?><br>
		<label>Updated by:</label> <?php echo $user['updatedby'] ?><br>
		<label>Deleted by:</label> <?php echo $user['deletedby'] ?><br>
		<label>User Ip:</label> <?php echo $user['userip'] ?><br>
		<label>Permission:</label> <?php echo $user['permission'] ?><br>
		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnUserSelect"
                        userid="<?php echo $user['id']?>"
							userid="<?php echo $user['userid']?>"
							usertypeid="<?php echo $user['usertypeid']?>"
							username="<?php echo $user['username']?>"
							password="<?php echo $user['password']?>"
							fullname="<?php echo $user['fullname']?>"
							email="<?php echo $user['email']?>"
							status="<?php echo $user['status']?>"
							imagepath="<?php echo $user['imagepath']?>"
							phone="<?php echo $user['phone']?>"
							activedate="<?php echo $user['activedate']?>"
							updateddate="<?php echo $user['updateddate']?>"
							deleteddate="<?php echo $user['deleteddate']?>"
							activeby="<?php echo $user['activeby']?>"
							updatedby="<?php echo $user['updatedby']?>"
							deletedby="<?php echo $user['deletedby']?>"
							userip="<?php echo $user['userip']?>"
							permission="<?php echo $user['permission']?>"
							
                        ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_User.showDeleteDialog(<?php echo $user['id']?>, '<?php echo $user['username'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/user/update&id=<?php echo $user[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    elife_User.showTotal("<?php echo $this->string->numberFormate($total)?> items");
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileUser #sortcol').val(sortcol);
        $('#fitermobileUser #sorttype').val(sorttype);
    
        $('#fitermobileUser #btnSortUser').click(function(){
            $('#frmUserSearch #sorttype').val($('#fitermobileUser #sorttype').val());
            $('#frmUserSearch #sortcol').val($('#fitermobileUser #sortcol').val());
            elife_User.search();
        });
    $('#user-list th').each(function(e){
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
        $('#frmUserSearch #sorttype').val('asc');
        $('#frmUserSearch #sortcol').val($(this).attr('sortcol'));
        elife_User.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmUserSearch #sorttype').val('desc');
        $('#frmUserSearch #sortcol').val($(this).attr('sortcol'));
        elife_User.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmUserSearch #sorttype').val('asc');
        $('#frmUserSearch #sortcol').val($(this).attr('sortcol'));
        elife_User.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>