<div class="desktop-show">
    <table class="table table-striped table-bordered">
        <thead>
        <tr >
            <th>User type</th>
            <th class="sort-asc">Name</th>
            <th class="sort-asc"><?php echo $text_user_name?></th>
            <th class="sort-asc">Photo</th>
            <th class="sort-asc">Active</th>
            <th class="tool-title-2">Control</th>
        </tr>
        </thead>
        <tbody>


        <?php if(isset($users)) { foreach($users as $user) { ?>
        <tr>
            <td><?php echo $user['usertypeid'] ?></td>
            <td><?php echo $user['fullname'] ?></td>
            <td><?php echo $user['username'] ?></td>
            <td>
                <?php if($user['imagepath'] == '') { ?>
                <img width="50" src="<?php echo DIR_IMAGE ?>no-image.png">
                <?php } else { ?>
                <img width="50" src="<?php echo DIR_USERIMAGE ?>fixsize-50x50/<?php echo $user['imagepath'] ?>">
                <?php } ?>
            </td>
            <td>
                <label class="switch switch-sm media-middle">
                    <?php if($user['status'] == 'active') { ?>
                    <input type="checkbox" userid="<?php echo $user['userid'] ?>" class="user_status" checked>
                    <?php } else { ?>
                    <input type="checkbox" userid="<?php echo $user['userid'] ?>" class="user_status">
                    <?php } ?>
                </label>
            </td>
            <td>
                <button onclick="window.location.href='?route=core/user/update&userid=<?php echo $user[userid]?>'" type="button" class="btn btn-sm btn-default btn-icon btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                <button onclick="user.selectCard('<?php echo $user[username]?>')" type="button" class="btn btn-sm btn-default btn-icon btn-info margin-0 margin-right-5"><span class="fa fa-credit-card"></span></button>
                <button type="button" onclick="user.showDeleteDialog('<?php echo $user[userid]?>', '<?php echo $user[fullname]?>')"
                        class="btn btn-sm btn-default btn-icon btn-danger margin-0 margin-right-5" >
                    <span class="fa fa-trash"></span>
                </button>

                <button type="button" onclick="user.showResetPassForm('<?php echo $user[userid] ?>', '<?php echo $user[username] ?>')"
                        class="btn btn-sm btn-primary btn-default margin-0 margin-right-5">
                    <span class="fa fa-key"></span> Reset password
                </button>
            </td>
        </tr>
        <?php } } ?>


        </tbody>
    </table>
</div>
<div class="mobile-show">
    <?php if(isset($users)) { foreach($users as $user) { ?>
    <div class="itemrow">
        <?php if($user['imagepath'] == '') { ?>
        <img width="50" src="<?php echo DIR_IMAGE ?>no-image.png">
        <?php } else { ?>
        <img width="50" src="<?php echo DIR_USERIMAGE ?>fixsize-50x50/<?php echo $user['imagepath'] ?>">
        <?php } ?><br>

        <label class="switch switch-sm media-middle">
            <?php if($user['status'] == 'active') { ?>
            <input type="checkbox" userid="<?php echo $user['userid'] ?>" class="user_status" checked>
            <?php } else { ?>
            <input type="checkbox" userid="<?php echo $user['userid'] ?>" class="user_status">
            <?php } ?>
        </label><br/>

        <label><?php echo $user['fullname'] ?></label> <br>
        <label>User type:</label> <?php echo $user['usertypeid'] ?><br>
        <label>Username:</label> <?php echo $user['username'] ?><br>






        <div class="clear-mobile"></div>
        <div class="pull-left">
            <button onclick="window.location.href='?route=core/user/update&userid=<?php echo $user[userid]?>'" type="button" class="btn btn-sm btn-default btn-icon btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <button type="button" class="btn btn-sm btn-default btn-icon btn-info margin-0 margin-right-5"><span class="fa fa-id-card"></span></button>

            <button type="button" onclick="user.showDeleteDialog('<?php echo $user[userid]?>', '<?php echo $user[fullname]?>')"
                    class="btn btn-sm btn-default btn-icon btn-danger margin-0 margin-right-5" >
                <span class="fa fa-trash"></span>
            </button>

            <button type="button" onclick="user.showResetPassForm('<?php echo $user[userid] ?>', '<?php echo $user[username] ?>')"
                    class="btn btn-sm btn-primary btn-default margin-0 margin-right-5">
                <span class="fa fa-key"></span> Reset password
            </button>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>
<?php echo $pagination?>