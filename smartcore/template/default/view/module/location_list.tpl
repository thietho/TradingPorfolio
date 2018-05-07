<div class="container">
    <div id="module-title" class="pull-left">Location List</div>
    <div id="module-path" class="pull-right">Home / Location List</div>
    <div class="block">
        <div class="row">
            <form id="frmLocationSearch" class="form-horizontal frmSearch">
                <div class="col-md-12">
                    <div>
                        <table>
                            <tr>
                                <td><label>Search by:</label></td>
                                <td class="colsearch">
                                    <select class="bs-select" id="searchcol" name="searchcol">
                                        <option value="locationname">Location Name</option><option value="xval">X</option><option value="yval">Y</option><option value="parent">Parent</option><option value="sortorder">Sort Order</option>

                                    </select>
                                </td>
                                <td id="searchview">
                                    <input type="text" class="form-control input-sm" id="searchvalue" name="searchvalue">
                                </td>
                                <td>
                                    <button id="btnSearch" class="btn btn-sm btn-default" type="button" onclick="elife_Location.search()"><span class="fa fa-search"></span></button>
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
                                <td><button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/location/insert'" type="button" class="btn btn-sm btn-danger"><span class="fa fa-plus"></span> Add new</button></td>
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
        <div id="ctr-locationname">
			<input type="text" class="form-control input-sm" placeholder="Location Name" id="locationname" name="locationname">
		</div>
		<div id="ctr-xval">
			<input type="text" class="form-control input-sm" placeholder="X" id="xval" name="xval">
		</div>
		<div id="ctr-yval">
			<input type="text" class="form-control input-sm" placeholder="Y" id="yval" name="yval">
		</div>
		<div id="ctr-parent">
			<input type="text" class="form-control input-sm" placeholder="Parent" id="parent" name="parent">
		</div>
		<div id="ctr-sortorder">
			<input type="text" class="form-control input-sm" placeholder="Sort Order" id="sortorder" name="sortorder">
		</div>
		
    </div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <div class="col-md-12">

                <div class="clear-mobile"></div>
                <div id="location-list"></div>

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
    function Location()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=module/location/loadData", $('#frmLocationSearch').serialize(), function(html){
                endLoading();
                $('#location-list').html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-location-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("Do you want to delete " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=module/location/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { elife_Location.search(); };
                    toastr.success('Location has been deleted', 'Delete success', {timeOut: 1000})
                }
            });
        };
        this.showTotal = function(total)
        {
            $('#frmLocationSearch #showtotal').html(total);
        }
    }


    var jFrmLocationSearch = $('#frmLocationSearch');
    var elife_Location = new Location();
    $(document).ready(function(){
        elife_Location.search();

        jFrmLocationSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmLocationSearch.find('.form-control').change(function () {
            elife_Location.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-location-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="elife_Location._delete()">OK</button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>