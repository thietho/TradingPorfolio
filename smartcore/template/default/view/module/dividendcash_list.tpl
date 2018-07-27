<div class="container">
    <div id="module-title" class="pull-left">Cổ tức tiền mặt List</div>
    <div id="module-path" class="pull-right">Home / Cổ tức tiền mặt List</div>
    <div class="block">
        <div class="row">
            <form id="frmDividendCashSearch" class="form-horizontal frmSearch">
                <div class="col-md-12">
                    <div>
                        <table>
                            <tr>
                                <td><label>Search by:</label></td>
                                <td class="colsearch">
                                    <select class="form-control input-sm" id="searchcol" name="searchcol">
                                        <option value="receivedate">Ngày nhận</option><option value="deadline">Ngày chốt quyền</option><option value="symbol">Mã chứng khoán</option><option value="accountid">Tài khoản nhận</option><option value="amount">Số tiền</option><option value="notes">Ghi chú</option><option value="createdate">Ngày tạo</option><option value="createby">Tạo bởi</option><option value="updatedate">Ngày cập nhật</option><option value="updateby">Cập nhật bởi</option><option value="deletedate">Ngày xóa</option><option value="deleteby">Xóa bởi</option>

                                    </select>
                                </td>
                                <td id="searchview">
                                    <input type="text" class="form-control input-sm" id="searchvalue" name="searchvalue">
                                </td>
                                <td>
                                    <button id="btnSearch" class="btn btn-sm btn-default" type="button" onclick="trading_DividendCash.search()"><span class="fa fa-search"></span></button>
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
                                <td><button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/dividendcash/insert'" type="button" class="btn btn-sm btn-danger"><span class="fa fa-plus"></span> Add new</button></td>
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
        <div id="ctr-receivedate">
			<input type="text" class="form-control input-sm" placeholder="Ngày nhận" id="receivedate" name="receivedate">
		</div>
		<div id="ctr-deadline">
			<input type="text" class="form-control input-sm" placeholder="Ngày chốt quyền" id="deadline" name="deadline">
		</div>
		<div id="ctr-symbol">
			<input type="text" class="form-control input-sm" placeholder="Mã chứng khoán" id="symbol" name="symbol">
		</div>
		<div id="ctr-accountid">
			<input type="text" class="form-control input-sm" placeholder="Tài khoản nhận" id="accountid" name="accountid">
		</div>
		<div id="ctr-amount">
			<input type="text" class="form-control input-sm" placeholder="Số tiền" id="amount" name="amount">
		</div>
		<div id="ctr-notes">
			<input type="text" class="form-control input-sm" placeholder="Ghi chú" id="notes" name="notes">
		</div>
		<div id="ctr-createdate">
			<input type="text" class="form-control input-sm" placeholder="Ngày tạo" id="createdate" name="createdate">
		</div>
		<div id="ctr-createby">
			<input type="text" class="form-control input-sm" placeholder="Tạo bởi" id="createby" name="createby">
		</div>
		<div id="ctr-updatedate">
			<input type="text" class="form-control input-sm" placeholder="Ngày cập nhật" id="updatedate" name="updatedate">
		</div>
		<div id="ctr-updateby">
			<input type="text" class="form-control input-sm" placeholder="Cập nhật bởi" id="updateby" name="updateby">
		</div>
		<div id="ctr-deletedate">
			<input type="text" class="form-control input-sm" placeholder="Ngày xóa" id="deletedate" name="deletedate">
		</div>
		<div id="ctr-deleteby">
			<input type="text" class="form-control input-sm" placeholder="Xóa bởi" id="deleteby" name="deleteby">
		</div>
		
    </div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <div class="col-md-12">

                <div class="clear-mobile"></div>
                <div id="dividendcash-list"></div>

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
    function DividendCash()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=module/dividendcash/loadData", $('#frmDividendCashSearch').serialize(), function(html){
                endLoading();
                $('#dividendcash-list').html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-dividendcash-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("Do you want to delete " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=module/dividendcash/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { trading_DividendCash.search(); };
                    toastr.success('DividendCash has been deleted', 'Delete success', {timeOut: 1000})
                }
            });
        };
        this.showTotal = function(total)
        {
            $('#frmDividendCashSearch #showtotal').html(total);
        }
    }


    var jFrmDividendCashSearch = $('#frmDividendCashSearch');
    var trading_DividendCash = new DividendCash();
    $(document).ready(function(){
        trading_DividendCash.search();

        jFrmDividendCashSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmDividendCashSearch.find('.form-control').change(function () {
            trading_DividendCash.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-dividendcash-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="trading_DividendCash._delete()">OK</button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>