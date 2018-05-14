<div class="container">
    <div id="module-title" class="pull-left">Giao dịch List</div>
    <div id="module-path" class="pull-right">Home / Giao dịch List</div>
    <div class="block">
        <div class="row">
            <form id="frmTransactionSearch" class="form-horizontal frmSearch">
                <div class="col-md-12">
                    <div>
                        <table>
                            <tr>
                                <td><label>Search by:</label></td>
                                <td class="colsearch">
                                    <select class="form-control input-sm" id="searchcol" name="searchcol">
                                        <option value="transactionid">Mã giao dịch</option><option value="accountid">Tài khoản</option><option value="cardid">Chủ tài khoản</option><option value="transactiondate">Ngày giao dịch</option><option value="receivemoneydate">Ngày nhận tiền(T+2)</option><option value="receivestockdate">Ngày nhận ck(T+3)</option><option value="symbol">Mã ck</option><option value="name">Tên ck</option><option value="type">Loại giao dịch</option><option value="costofsale">Giá vốn</option><option value="volume">Số lượng</option><option value="price">Giá</option><option value="fee">Phí giao dich</option><option value="tax">Thuế</option><option value="total">Số tiền giao dịch</option><option value="profit">Lợi nhuận</option><option value="notes">Ghi chú</option><option value="createdate">Ngày tạo</option><option value="createby">Tạo bởi</option><option value="updatedate">Ngày cập nhật</option><option value="updateby">Cập nhật bởi</option><option value="deletedate">Ngày xóa</option><option value="deleteby">Xóa bởi</option>

                                    </select>
                                </td>
                                <td id="searchview">
                                    <input type="text" class="form-control input-sm" id="searchvalue" name="searchvalue">
                                </td>
                                <td>
                                    <button id="btnSearch" class="btn btn-sm btn-default" type="button" onclick="trading_Transaction.search()"><span class="fa fa-search"></span></button>
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
                                <td><button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/transaction/insert'" type="button" class="btn btn-sm btn-danger"><span class="fa fa-plus"></span> Add new</button></td>
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
        <div id="ctr-transactionid">
			<input type="text" class="form-control input-sm" placeholder="Mã giao dịch" id="transactionid" name="transactionid">
		</div>
		<div id="ctr-accountid">
			<input type="text" class="form-control input-sm" placeholder="Tài khoản" id="accountid" name="accountid">
		</div>
		<div id="ctr-cardid">
			<input type="text" class="form-control input-sm" placeholder="Chủ tài khoản" id="cardid" name="cardid">
		</div>
		<div id="ctr-transactiondate">
			<input type="text" class="form-control input-sm" placeholder="Ngày giao dịch" id="transactiondate" name="transactiondate">
		</div>
		<div id="ctr-receivemoneydate">
			<input type="text" class="form-control input-sm" placeholder="Ngày nhận tiền(T+2)" id="receivemoneydate" name="receivemoneydate">
		</div>
		<div id="ctr-receivestockdate">
			<input type="text" class="form-control input-sm" placeholder="Ngày nhận ck(T+3)" id="receivestockdate" name="receivestockdate">
		</div>
		<div id="ctr-symbol">
			<input type="text" class="form-control input-sm" placeholder="Mã ck" id="symbol" name="symbol">
		</div>
		<div id="ctr-name">
			<input type="text" class="form-control input-sm" placeholder="Tên ck" id="name" name="name">
		</div>
		<div id="ctr-type">
			<input type="text" class="form-control input-sm" placeholder="Loại giao dịch" id="type" name="type">
		</div>
		<div id="ctr-costofsale">
			<input type="text" class="form-control input-sm" placeholder="Giá vốn" id="costofsale" name="costofsale">
		</div>
		<div id="ctr-volume">
			<input type="text" class="form-control input-sm" placeholder="Số lượng" id="volume" name="volume">
		</div>
		<div id="ctr-price">
			<input type="text" class="form-control input-sm" placeholder="Giá" id="price" name="price">
		</div>
		<div id="ctr-fee">
			<input type="text" class="form-control input-sm" placeholder="Phí giao dich" id="fee" name="fee">
		</div>
		<div id="ctr-tax">
			<input type="text" class="form-control input-sm" placeholder="Thuế" id="tax" name="tax">
		</div>
		<div id="ctr-total">
			<input type="text" class="form-control input-sm" placeholder="Số tiền giao dịch" id="total" name="total">
		</div>
		<div id="ctr-profit">
			<input type="text" class="form-control input-sm" placeholder="Lợi nhuận" id="profit" name="profit">
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
                <div id="transaction-list"></div>

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
    function Transaction()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=module/transaction/loadData", $('#frmTransactionSearch').serialize(), function(html){
                endLoading();
                $('#transaction-list').html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-transaction-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("Do you want to delete " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=module/transaction/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { trading_Transaction.search(); };
                    toastr.success('Transaction has been deleted', 'Delete success', {timeOut: 1000})
                }
            });
        };
        this.showTotal = function(total)
        {
            $('#frmTransactionSearch #showtotal').html(total);
        }
    }


    var jFrmTransactionSearch = $('#frmTransactionSearch');
    var trading_Transaction = new Transaction();
    $(document).ready(function(){
        trading_Transaction.search();

        jFrmTransactionSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmTransactionSearch.find('.form-control').change(function () {
            trading_Transaction.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-transaction-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="trading_Transaction._delete()">OK</button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>