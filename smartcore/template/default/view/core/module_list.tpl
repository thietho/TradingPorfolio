<div class="container">
    <div id="module-title" class="pull-left">Module List</div>
    <div id="module-path" class="pull-right">Home / Module List</div>
    <div class="block">
        <div class="row">
            <form id="frmModuleSearch" class="form-horizontal frmSearch">
                <div class="col-md-12">
                    <div>
                        <table>
                            <tr>
                                <td><label>Search by:</label></td>
                                <td class="colsearch">
                                    <select class="form-control input-sm" id="searchcol" name="searchcol">
                                        <option value="moduleid">Module Id</option><option value="modulename">Module Name</option><option value="modulepath">Module Path</option><option value="moduleparent">Parent</option><option value="moduleicon">Icon</option><option value="position">Position</option>

                                    </select>
                                </td>
                                <td id="searchview">
                                    <input type="text" class="form-control input-sm" id="searchvalue" name="searchvalue">
                                </td>
                                <td>
                                    <button id="btnSearch" class="btn btn-sm btn-default" type="button" onclick="elife_Module.search()"><span class="fa fa-search"></span></button>
                                </td>
                                <td>
                                    #Found: <span id="showtotal"></span>
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
                                <td><button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=core/module/insert'" type="button" class="btn btn-sm btn-danger"><span class="fa fa-plus"></span> Add new</button></td>
                                <td><button type="button" class="btn btn-sm btn-default"><span class="fa fa-print"></span> Print</button></td>
                                <td><button type="button" class="btn btn-sm btn-default"><span class="fa fa-file-excel-o"></span> Excel</button></td>
                                <td>
                                    <select class="bs-select">
                                        <option value="">More Action...</option>
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
        <div id="ctr-moduleid">
			<input type="text" class="form-control input-sm" placeholder="Module Id" id="moduleid" name="moduleid">
		</div>
		<div id="ctr-modulename">
			<input type="text" class="form-control input-sm" placeholder="Module Name" id="modulename" name="modulename">
		</div>
		<div id="ctr-modulepath">
			<input type="text" class="form-control input-sm" placeholder="Module Path" id="modulepath" name="modulepath">
		</div>
		<div id="ctr-moduleparent">
			<input type="text" class="form-control input-sm" placeholder="Parent" id="moduleparent" name="moduleparent">
		</div>
		<div id="ctr-moduleicon">
			<input type="text" class="form-control input-sm" placeholder="Icon" id="moduleicon" name="moduleicon">
		</div>
		<div id="ctr-position">
			<input type="text" class="form-control input-sm" placeholder="Position" id="position" name="position">
		</div>
		
    </div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <div class="col-md-12">

                <div class="clear-mobile"></div>
                <div id="module-list"></div>

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
    function Module()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=core/module/loadData", $('#frmModuleSearch').serialize(), function(html){
                endLoading();
                $('#module-list').html(html);
                $('.chkisshow').unbind('click');
                $('.chkisshow').click(function () {

                    var id = $(this).attr('moduleid');
                    var value = 0;
                    if(this.checked){
                        value = 1;
                    }

                    elife_Module.updateShow(id,value);
                });
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-module-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("Do you want to delete " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=core/module/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { elife_Module.search(); };
                    toastr.success('Module has been deleted', 'Delete success', {timeOut: 1000})
                }
            });
        };
        this.showTotal = function(total)
        {
            $('#frmModuleSearch #showtotal').html(total);
        }
        this.updateShow = function (id,value) {
            $.get('?route=core/module/updateShow&id='+id+'&value='+value);
        }
    }


    var jFrmModuleSearch = $('#frmModuleSearch');
    var elife_Module = new Module();
    $(document).ready(function(){
        elife_Module.search();

        jFrmModuleSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmModuleSearch.find('.form-control').change(function () {
            elife_Module.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-module-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="elife_Module._delete()">OK</button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>