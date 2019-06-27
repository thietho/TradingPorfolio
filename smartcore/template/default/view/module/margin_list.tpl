<div class="container">
    <div id="module-title" class="pull-left">Khoản vay List</div>
    <div id="module-path" class="pull-right">Home / Khoản vay List</div>
    <div class="block">
        <div class="row">
            <form id="frmMarginSearch" class="form-horizontal frmSearch">
                <div class="col-md-12">
                    <div>
                        <table>
                            <tr>
                                <td><label>Search by:</label></td>
                                <td class="colsearch">
                                    <select class="form-control input-sm" id="searchcol" name="searchcol">
                                        <option value="opendate">Ngày phụ lục</option><option value="closedate">Ngày thanh lý</option><option value="amount">Giá trị</option><option value="countdate">Ngày nắm giử</option><option value="rate">Lãi xuất</option><option value="totalpay">Tổng trả</option><option value="cardid">Người nhận</option><option value="accountid">Tài khoản nhận</option><option value="transactionid">Tạo từ giao dịch</option><option value="createdate">Ngày tạo</option><option value="createby">Tạo bởi</option><option value="updatedate">Ngày cập nhật</option><option value="updateby">Cập nhật bởi</option><option value="deletedate">Ngày xóa</option><option value="deleteby">Xóa bởi</option>

                                    </select>
                                </td>
                                <td id="searchview">
                                    <input type="text" class="form-control input-sm" id="searchvalue" name="searchvalue">
                                </td>
                                <td>
                                    <button id="btnSearch" class="btn btn-sm btn-default" type="button" onclick="trading_Margin.search()"><span class="fa fa-search"></span></button>
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
                                <td><button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/margin/insert'" type="button" class="btn btn-sm btn-danger"><span class="fa fa-plus"></span> Add new</button></td>
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
        <div id="ctr-opendate">
			<input type="text" class="form-control input-sm" placeholder="Ngày phụ lục" id="opendate" name="opendate">
		</div>
		<div id="ctr-closedate">
			<input type="text" class="form-control input-sm" placeholder="Ngày thanh lý" id="closedate" name="closedate">
		</div>
		<div id="ctr-amount">
			<input type="text" class="form-control input-sm" placeholder="Giá trị" id="amount" name="amount">
		</div>
		<div id="ctr-countdate">
			<input type="text" class="form-control input-sm" placeholder="Ngày nắm giử" id="countdate" name="countdate">
		</div>
		<div id="ctr-rate">
			<input type="text" class="form-control input-sm" placeholder="Lãi xuất" id="rate" name="rate">
		</div>
		<div id="ctr-totalpay">
			<input type="text" class="form-control input-sm" placeholder="Tổng trả" id="totalpay" name="totalpay">
		</div>
		<div id="ctr-cardid">
			<input type="text" class="form-control input-sm" placeholder="Người nhận" id="cardid" name="cardid">
		</div>
		<div id="ctr-accountid">
			<input type="text" class="form-control input-sm" placeholder="Tài khoản nhận" id="accountid" name="accountid">
		</div>
		<div id="ctr-transactionid">
			<input type="text" class="form-control input-sm" placeholder="Tạo từ giao dịch" id="transactionid" name="transactionid">
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
                <div id="margin-list"></div>

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
    function Margin()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=module/margin/loadData", $('#frmMarginSearch').serialize(), function(html){
                endLoading();
                $('#margin-list').html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-margin-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("Do you want to delete " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=module/margin/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { trading_Margin.search(); };
                    toastr.success('Margin has been deleted', 'Delete success', {timeOut: 1000})
                }
            });
        };
        this.showTotal = function(total)
        {
            $('#frmMarginSearch #showtotal').html(total);
        }
    }


    var jFrmMarginSearch = $('#frmMarginSearch');
    var trading_Margin = new Margin();
    $(document).ready(function(){
        trading_Margin.search();

        jFrmMarginSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmMarginSearch.find('.form-control').change(function () {
            trading_Margin.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-margin-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="trading_Margin._delete()">OK</button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>