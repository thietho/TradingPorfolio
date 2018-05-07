<div class="container">
    <div id="module-title" class="pull-left">Usertype List</div>
    <div id="module-path" class="pull-right"><?php echo $text_home?> / Usertype List</div>
    <div class="block">
        <div class="row">
            <form id="frmUsertypeSearch" class="form-horizontal frmSearch">
                <div class="col-md-12">
                    <div>
                        <table>
                            <tr>
                                <td><label><?php echo $text_searchby?>:</label></td>
                                <td class="colsearch">
                                    <select class="bs-select" id="searchcol" name="searchcol">
                                        <option value="usertypeid">User Type ID</option>
                                        <option value="usertypename">User Type Name</option>
                                        <option value="permission">Permission</option>
                                    </select>
                                </td>
                                <td id="searchview">
                                    <input type="text" class="form-control input-sm" id="searchvalue" name="searchvalue">
                                </td>
                                <td>
                                    <button id="btnSearch" class="btn btn-sm btn-default" type="button" onclick="elife_Usertype.search()"><span class="fa fa-search"></span></button>
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
                                <td><button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/usertype/insert'" type="button" class="btn btn-sm btn-danger"><span class="fa fa-plus"></span> <?php echo $text_add_new?></button></td>
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
        <div id="ctr-usertypeid">
			<input type="text" class="form-control input-sm" placeholder="User Type ID" id="usertypeid" name="usertypeid">
		</div>
		<div id="ctr-usertypename">
			<input type="text" class="form-control input-sm" placeholder="User Type Name" id="usertypename" name="usertypename">
		</div>
		<div id="ctr-usertypeparent">
			<input type="text" class="form-control input-sm" placeholder="User Type Parent" id="usertypeparent" name="usertypeparent">
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
                <div id="usertype-list"></div>

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
    function Usertype()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=core/usertype/loadData", $('#frmUsertypeSearch').serialize(), function(html){
                endLoading();
                $('#usertype-list').html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-usertype-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("<?php echo $text_do_you_want_to_delete?> " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=core/usertype/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { elife_Usertype.search(); };
                    toastr.success('Usertype has been deleted', '<?php echo $text_delete_success?>', {timeOut: 1000})
                }
            });
        };
        this.showTotal = function(total)
        {
            $('#frmUsertypeSearch #showtotal').html(total);
        }
    }


    var jFrmUsertypeSearch = $('#frmUsertypeSearch');
    var elife_Usertype = new Usertype();
    $(document).ready(function(){
        elife_Usertype.search();

        jFrmUsertypeSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmUsertypeSearch.find('.form-control').change(function () {
            elife_Usertype.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-usertype-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="elife_Usertype._delete()"><?php echo $text_ok?></button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal"><?php echo $text_cancel?></button>
            </div>
        </div>
    </div>
</div>