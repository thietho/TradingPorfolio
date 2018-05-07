<div class="container">
    <div id="module-title" class="pull-left">User List</div>
    <div id="module-path" class="pull-right"><?php echo $text_home?> / User List</div>
    <div class="block">
        <div class="row">
            <form id="frmUserSearch" class="form-horizontal frmSearch">
                <div class="col-md-12">
                    <div>
                        <table>
                            <tr>
                                <td><label><?php echo $text_searchby?>:</label></td>
                                <td class="colsearch">
                                    <select class="bs-select" id="searchcol" name="searchcol">
                                        <option value="userid">User Id</option><option value="usertypeid">User Type Name</option><option value="username"><?php echo $text_user_name?></option><option value="password"><?php echo $text_password?></option><option value="fullname"><?php echo $text_full_name?></option><option value="email">Email</option><option value="status"><?php echo $text_status?></option><option value="imagepath">Image Path</option><option value="phone"><?php echo $text_phone?></option><option value="activedate">Active Date</option><option value="updateddate">Updated Date</option><option value="deleteddate">Deleted Date</option><option value="activeby">Active by</option><option value="updatedby">Updated by</option><option value="deletedby">Deleted by</option><option value="userip">User Ip</option><option value="permission">Permission</option>

                                    </select>
                                </td>
                                <td id="searchview">
                                    <input type="text" class="form-control input-sm" id="searchvalue" name="searchvalue">
                                </td>
                                <td>
                                    <button id="btnSearch" class="btn btn-sm btn-default" type="button" onclick="elife_User.search()"><span class="fa fa-search"></span></button>
                                </td>
                                <td>
                                    #<?php echo $text_found?>: <span id="showtotal"></span>
                                </td>
                            </tr>
                        </table>


                    </div>
                    <input type="hidden" id="sorttype" name="sorttype" value="">
                    <input type="hidden" id="sortcol" name="sortcol" value="">
                    <input type="hidden" name="type" value="<?php echo $_GET['type']?>">
                    <?php if($_GET['type'] != 'popup'){ ?>
                    <div>
                        <table>
                            <tr>
                                <td><button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/user/insert'" type="button" class="btn btn-sm btn-danger"><span class="fa fa-plus"></span> <?php echo $text_add_new?></button></td>
                                <td><button type="button" class="btn btn-sm btn-default"><span class="fa fa-print"></span> <?php echo $text_print?></button></td>
                                <td><button type="button" class="btn btn-sm btn-default"><span class="fa fa-file-excel-o"></span> Excel</button></td>
                                <td>
                                    <select class="bs-select">
                                        <option value=""><?php echo $text_more_action?>...</option>
                                    </select>
                                </td>
                                <td></td>
                            </tr>
                        </table>




                    </div>
                    <?php } ?>
                </div>
            </form>
        </div>
    </div>
    <div style="display: none">
        <div id="ctr-userid">
			<input type="text" class="form-control input-sm" placeholder="User Id" id="userid" name="userid">
		</div>
		<div id="ctr-usertypeid">
			<input type="text" class="form-control input-sm" placeholder="User Type Name" id="usertypeid" name="usertypeid">
		</div>
		<div id="ctr-username">
			<input type="text" class="form-control input-sm" placeholder="<?php echo $text_user_name?>" id="username" name="username">
		</div>
		<div id="ctr-password">
			<input type="text" class="form-control input-sm" placeholder="<?php echo $text_password?>" id="password" name="password">
		</div>
		<div id="ctr-fullname">
			<input type="text" class="form-control input-sm" placeholder="<?php echo $text_full_name?>" id="fullname" name="fullname">
		</div>
		<div id="ctr-email">
			<input type="text" class="form-control input-sm" placeholder="Email" id="email" name="email">
		</div>
		<div id="ctr-status">
			<input type="text" class="form-control input-sm" placeholder="<?php echo $text_status?>" id="status" name="status">
		</div>
		<div id="ctr-imagepath">
			<input type="text" class="form-control input-sm" placeholder="Image Path" id="imagepath" name="imagepath">
		</div>
		<div id="ctr-phone">
			<input type="text" class="form-control input-sm" placeholder="<?php echo $text_phone?>" id="phone" name="phone">
		</div>
		<div id="ctr-activedate">
			<input type="text" class="form-control input-sm" placeholder="Active Date" id="activedate" name="activedate">
		</div>
		<div id="ctr-updateddate">
			<input type="text" class="form-control input-sm" placeholder="Updated Date" id="updateddate" name="updateddate">
		</div>
		<div id="ctr-deleteddate">
			<input type="text" class="form-control input-sm" placeholder="Deleted Date" id="deleteddate" name="deleteddate">
		</div>
		<div id="ctr-activeby">
			<input type="text" class="form-control input-sm" placeholder="Active by" id="activeby" name="activeby">
		</div>
		<div id="ctr-updatedby">
			<input type="text" class="form-control input-sm" placeholder="Updated by" id="updatedby" name="updatedby">
		</div>
		<div id="ctr-deletedby">
			<input type="text" class="form-control input-sm" placeholder="Deleted by" id="deletedby" name="deletedby">
		</div>
		<div id="ctr-userip">
			<input type="text" class="form-control input-sm" placeholder="User Ip" id="userip" name="userip">
		</div>
		<div id="ctr-permission">
			<input type="text" class="form-control input-sm" placeholder="Permission" id="permission" name="permission">
		</div>
		
    </div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <div class="col-md-12">

                <div class="clear-mobile"></div>
                <div id="user-list"></div>

            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->


<script type="application/javascript">
    $(document).ready(function(){
        $('#searchcol').change();
    });
    $('#searchcol').change(function(){
        $('#searchview').html($('#ctr-'+$(this).val()).html());
    });
    function User()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=core/user/loadData", $('#frmUserSearch').serialize(), function(html){
                endLoading();
                $('#user-list').html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-user-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("<?php echo $text_do_you_want_to_delete?> " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=core/user/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { elife_User.search(); };
                    toastr.success('User has been deleted', '<?php echo $text_delete_success?>', {timeOut: 1000})
                }
            });
        };
        this.showTotal = function(total)
        {
            $('#frmUserSearch #showtotal').html(total);
        }
    }


    var jFrmUserSearch = $('#frmUserSearch');
    var elife_User = new User();
    $(document).ready(function(){
        elife_User.search();

        jFrmUserSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmUserSearch.find('.form-control').change(function () {
            elife_User.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-user-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="elife_User._delete()"><?php echo $text_ok?></button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal"><?php echo $text_cancel?></button>
            </div>
        </div>
    </div>
</div>