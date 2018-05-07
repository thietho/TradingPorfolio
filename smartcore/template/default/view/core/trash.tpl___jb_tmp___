<div class="container">
    <div id="module-title" class="pull-left"><?php echo $this->document->invoicetype[$invoicetype]?> <?php echo $text_list?></div>
    <div id="module-path" class="pull-right"><?php echo $text_home?> / <?php echo $this->documnet->invoicetype[$invoicetype]?> list</div>
    <div class="block">
        <div class="row">
            <form id="frmInvoiceSearch" class="form-horizontal frmSearch">
                <div class="col-md-12">
                    <div>
                        <table>
                            <tr>
                                <td><label><?php echo $text_searchby?>:</label></td>
                                <td class="colsearch">
                                    <select class="bs-select" id="searchcol" name="searchcol">
                                        <option value=""><?php echo $text_all?></option>
                                        <option value="invoiceid"><?php echo $text_invoice_id?></option>

                                        <option value="date"><?php echo $text_date?></option>
                                        <option value="cardname"><?php echo $text_card_name?></option>
                                        <option value="methodtype"><?php echo $text_method_type?></option>
                                        <option value="accountidto"><?php echo $text_account_id?> From</option>
                                        <option value="accountidfrom"><?php echo $text_account_id?> To</option>
                                        <option value="orderid"><?php echo $text_orderid?></option>
                                        <option value="status"><?php echo $text_status?></option>

                                    </select>
                                    <input type="hidden" id="invoicetype" name="invoicetype" value="<?php echo $invoicetype?>">
                                </td>
                                <td id="searchview">
                                    <input type="text" class="form-control input-sm" id="searchvalue" name="searchvalue">
                                </td>
                                <td>
                                    <button id="btnSearch" class="btn btn-sm btn-default" type="button" onclick="Invoice.search()"><span class="fa fa-search"></span></button>
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
                                <?php if($this->user->checkPermission($invoicetype.'Add')){ ?>
                                <td><button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/invoice/insert&invoicetype=<?php echo $invoicetype?>'" type="button" class="btn btn-sm btn-danger"><span class="fa fa-plus"></span> <?php echo $text_add_new?></button></td>
                                <?php } ?>
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
        <div id="ctr-invoiceid">
            <input type="text" class="form-control input-sm" placeholder="<?php echo $text_invoice_id?>" id="invoiceid" name="invoiceid">
        </div>
        <div id="ctr-invoicetype">
            <select id="invoicetype" name="invoicetype">
                <option value=""></option>
                <?php foreach($this->document->invoicetype as $type => $name){ ?>
                <option value="<?php echo $type?>"><?php echo $name?></option>
                <?php } ?>
            </select>
        </div>
        <div id="ctr-date">
            <input type="text" class="form-control input-sm bs-datepicker" placeholder="From Date" id="frominvoicedate" name="frominvoicedate">
            <input type="text" class="form-control input-sm bs-datepicker" placeholder="To Date" id="toinvoicedate" name="toinvoicedate">
        </div>
        <div id="ctr-cardname"><input type="text" class="form-control input-sm" placeholder="<?php echo $text_card_name?>" id="cardname" name="cardname"></div>
        <div id="ctr-methodtype">
            <select id="methodtype">
                <option value=""></option>
                <?php foreach($this->document->methodtype as $methodtype => $name){ ?>
                <option value="<?php echo $methodtype?>"><?php echo $name?></option>
                <?php } ?>
            </select>
            <select name="paymentmethod" id="paymentmethod"></select>
        </div>
        <div id="ctr-accountidto">
            <input type="text" class="form-control input-sm" placeholder="<?php echo $text_account_id?>" id="accountidto" name="accountidto">
        </div>
        <div id="ctr-accountidfrom">
            <input type="text" class="form-control input-sm" placeholder="<?php echo $text_account_id?>" id="accountidfrom" name="accountidfrom">
        </div>
        <div id="ctr-orderid">
            <input type="text" class="form-control input-control" placeholder="<?php echo $text_orderid?>" id="orderid" name="orderid">
        </div>
        <div id="ctr-status">
            <select class="form-control input-sm" id="status" name="status">
                <option value=""></option>
                <?php foreach($this->document->invoicestatus as $key=>$val){ ?>
                <option value="<?php echo $key?>" <?php echo $invoice['status'] == $key?'selected':''?>><?php echo $val?></option>
                <?php } ?>
            </select>
        </div>
    </div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <div class="col-md-12">

                <div class="clear-mobile"></div>
                <div id="invoice-list"></div>

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
        if($(this).val()=='')
        {
            $('#searchview').html('');
            Invoice.search();
        } else {
            $('#searchview').html($('#ctr-'+$(this).val()).html());
            if($(this).val() == 'invoicetype')
            {
                $('#frmInvoiceSearch #invoicetype').selectpicker('val');
                $('.bootstrap-select').addClass('bs-select');
            }
            if($(this).val() == 'date')
            {
                app_plugins.loaded();
            }
            if($(this).val() == 'methodtype')
            {
                $('#frmInvoiceSearch #methodtype').selectpicker('val');
                $('#frmInvoiceSearch #paymentmethod').selectpicker('val');
                $('.bootstrap-select').addClass('bs-select')

                $('#frmInvoiceSearch #methodtype').change(function(){
                    $.getJSON("?route=module/paymentmethod/getPaymentMethods&col=methodtype&val="+$(this).val(),function(data){
                        var str = "";
                        for(i in data)
                        {
                            str +='<option value="'+ data[i].paymentmethod +'">'+ data[i].paymentmethod +'</option>';
                        }
                        $('#frmInvoiceSearch #paymentmethod').html(str);
                        $('#frmInvoiceSearch #paymentmethod').selectpicker('refresh');
                        //$('#frmInvoiceSearch #paymentmethod').val('<?php echo $item["paymentmethod"]?>');
                    });
                });
            }
        }

    });
    function Invoice()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=core/trash/loadData", $('#frmInvoiceSearch').serialize(), function(html){
                endLoading();
                $('#invoice-list').html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-invoice-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("<?php echo $text_do_you_want_to_delete?> " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=core/trash/destroy&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { Invoice.search(); };
                    toastr.success('Invoice has been deleted', '<?php echo $text_delete_success?>', {timeOut: 1000})
                }
            });
        };
        this.restore = function(id)
        {
            $.get('?route=core/trash/restore&id=' + id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { Invoice.search(); };
                    toastr.success('Invoice has been restore', 'Invoice has been restore', {timeOut: 1000})
                }
            });
        };
        this.showTotal = function(total)
        {
            $('#frmInvoiceSearch #showtotal').html(total);
        }
        this.print = function (id) {
            /*$.getJSON("?route=module/invoice/getInvoice&id="+id,function (data) {
             var strjson = JSON.stringify(data);

             $.post("<?php echo ROOT_HTTP_SERVER?>pdf/datajson.php",data,function (html) {
             if(data.invoicetype == 'expense')
             var new_window = window.open("<?php echo ROOT_HTTP_SERVER?>pdf/expense.php?data="+html);
             else
             var new_window = window.open("<?php echo ROOT_HTTP_SERVER?>pdf/income.php?data="+html);
             })
             })*/
            showLoading();
            $.get("?route=module/invoice/view&id="+id,function (data) {
                endLoading();
                PrintHtml(data);
            });
        }
        this.updateStatus = function (invoiceid,status) {
            $.post("?route=module/invoice/updateStatus",{
                invoiceid:invoiceid,
                status:status
            },function (data) {
                Invoice.search();
            });
        }
    }


    var jFrmInvoiceSearch = $('#frmInvoiceSearch');
    var Invoice = new Invoice();
    $(document).ready(function(){
        Invoice.search();

        jFrmInvoiceSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmInvoiceSearch.find('.form-control').change(function () {
            Invoice.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-invoice-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="Invoice._delete()"><?php echo $text_ok?></button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal"><?php echo $text_cancel?></button>
            </div>
        </div>
    </div>
</div>