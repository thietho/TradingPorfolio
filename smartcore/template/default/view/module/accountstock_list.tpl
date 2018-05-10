<div class="container">
    <div id="module-title" class="pull-left">Tài khoản chứng khoán List</div>
    <div id="module-path" class="pull-right">Home / Tài khoản chứng khoán List</div>
    <div class="block">
        <div class="row">
            <form id="frmAccountStockSearch" class="form-horizontal frmSearch">
                <div class="col-md-12">
                    <div>
                        <table>
                            <tr>
                                <td><label>Search by:</label></td>
                                <td class="colsearch">
                                    <select class="form-control input-sm" id="searchcol" name="searchcol">
                                        <option value="accountid">Tài khoản</option><option value="openat">Mở tại</option><option value="buyfee">Phí mua</option><option value="salefee">Phí bán</option><option value="marginrate">Lãi xuất margin</option><option value="cardid">Chủ tài khoản</option><option value="status">Trạng thái</option><option value="depositfee">Phí lưu ký ck</option>

                                    </select>
                                </td>
                                <td id="searchview">
                                    <input type="text" class="form-control input-sm" id="searchvalue" name="searchvalue">
                                </td>
                                <td>
                                    <button id="btnSearch" class="btn btn-sm btn-default" type="button" onclick="trading_AccountStock.search()"><span class="fa fa-search"></span></button>
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
                                <td><button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/accountstock/insert'" type="button" class="btn btn-sm btn-danger"><span class="fa fa-plus"></span> Add new</button></td>
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
        <div id="ctr-accountid">
			<input type="text" class="form-control input-sm" placeholder="Tài khoản" id="accountid" name="accountid">
		</div>
		<div id="ctr-openat">
			<input type="text" class="form-control input-sm" placeholder="Mở tại" id="openat" name="openat">
		</div>
		<div id="ctr-buyfee">
			<input type="text" class="form-control input-sm" placeholder="Phí mua" id="buyfee" name="buyfee">
		</div>
		<div id="ctr-salefee">
			<input type="text" class="form-control input-sm" placeholder="Phí bán" id="salefee" name="salefee">
		</div>
		<div id="ctr-marginrate">
			<input type="text" class="form-control input-sm" placeholder="Lãi xuất margin" id="marginrate" name="marginrate">
		</div>
		<div id="ctr-cardid">
			<input type="text" class="form-control input-sm" placeholder="Chủ tài khoản" id="cardid" name="cardid">
		</div>
		<div id="ctr-status">
			<input type="text" class="form-control input-sm" placeholder="Trạng thái" id="status" name="status">
		</div>
		<div id="ctr-depositfee">
			<input type="text" class="form-control input-sm" placeholder="Phí lưu ký ck" id="depositfee" name="depositfee">
		</div>
		
    </div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <div class="col-md-12">

                <div class="clear-mobile"></div>
                <div id="accountstock-list"></div>

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
    function AccountStock()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=module/accountstock/loadData", $('#frmAccountStockSearch').serialize(), function(html){
                endLoading();
                $('#accountstock-list').html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-accountstock-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("Do you want to delete " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=module/accountstock/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { trading_AccountStock.search(); };
                    toastr.success('AccountStock has been deleted', 'Delete success', {timeOut: 1000})
                }
            });
        };
        this.showTotal = function(total)
        {
            $('#frmAccountStockSearch #showtotal').html(total);
        }
    }


    var jFrmAccountStockSearch = $('#frmAccountStockSearch');
    var trading_AccountStock = new AccountStock();
    $(document).ready(function(){
        trading_AccountStock.search();

        jFrmAccountStockSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmAccountStockSearch.find('.form-control').change(function () {
            trading_AccountStock.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-accountstock-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="trading_AccountStock._delete()">OK</button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>