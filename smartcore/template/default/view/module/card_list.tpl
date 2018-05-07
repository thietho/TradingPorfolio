
<div class="container">
    <div id="module-title" class="pull-left"><?php echo $text_card_list?></div>
    <div id="module-path" class="pull-right"><?php echo $text_home?> / <?php echo $text_card_list?></div>
    <div class="block">
        <div class="row">
            <form id="frmCardSearch" class="form-horizontal frmSearch">
                <div class="col-md-12">
                    <div>
                        <table>
                            <tr>
                                <td><label><?php echo $text_searchby?>:</label></td>
                                <td>
                                    <select id="searchcol" name="searchcol">
                                        <option value=""><?php echo $text_all?></option>
                                        <option value="cardid"><?php echo $text_card_id?></option>


                                        <option value="fullname"><?php echo $text_full_name?></option>
                                        <option value="email">Email</option>
                                        <option value="telephone"><?php echo $text_telephone?></option>
                                        <option value="mobilephone"><?php echo $text_mobile_phone?></option>

                                    </select>
                                </td>
                                <td id="searchview">
                                    <input type="text" class="form-control input-sm" id="searchvalue" name="searchvalue">
                                </td>
                                <td>
                                    <button id="btnSearch" class="btn btn-sm btn-default" type="button" onclick="elife_Card.searchAll()"><span class="fa fa-search"></span></button>
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
                                <?php if($this->user->checkPermission("cardAdd")){ ?>
                                <td><button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/card/insert'" type="button" class="btn btn-sm btn-danger"><span class="fa fa-plus"></span> <?php echo $text_add_new?></button></td>
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
        <div id="ctr-cardid">
            <input type="text" class="form-control input-sm" placeholder="<?php echo $text_card_id?>" id="cardid" name="cardid">
        </div>
        <div id="ctr-cardtype">
            <select id="cardtype" name="cardtype">
                <option value=""></option>
                <?php foreach($this->document->cardtype as $type => $name){ ?>
                <option value="<?php echo $type?>"><?php echo $name?></option>
                <?php } ?>
            </select>
        </div>
        <div id="ctr-firstname"><input type="text" class="form-control input-sm" placeholder="<?php echo $text_first_name?>" id="firstname" name="firstname"></div>
        <div id="ctr-lastname"><input type="text" class="form-control input-sm" placeholder="<?php echo $text_last_name?>" id="lastname" name="lastname"></div>
        <div id="ctr-fullname"><input type="text" class="form-control input-sm" placeholder="<?php echo $text_full_name?>" id="fullname" name="fullname"></div>
        <div id="ctr-email"><input type="text" class="form-control input-sm" placeholder="Email" id="email" name="email"></div>
        <div id="ctr-telephone">
            <input type="text" class="input-sm" placeholder="<?php echo $text_telephone?>" id="telephone" name="telephone">
        </div>

    </div>
    <!-- START BLOCk -->
    <?php
    $view = 'customer';
    if($_GET['view'])
        $view = $_GET['view'];

    ?>
    <div class="block">
        <div class="row">
            <div class="col-md-12">
                <div class="clear-mobile"></div>
                <div>
                    <ul class="nav nav-tabs nav-justified">
                        <?php foreach($this->document->cardtype as $code => $name){ ?>
                        <li class="<?php echo ($code==$view)?'active':''?>" cardlist="<?php echo $code?>"><a href="#card-list-<?php echo $code?>" data-toggle="tab" aria-expanded="<?php echo ($code==$view)?'true':''?>"><?php echo $name?></a></li>
                        <?php } ?>
                    </ul>
                    <div class="tab-content tab-content-bordered">
                        <?php foreach($this->document->cardtype as $code => $name){ ?>
                        <div class="tab-pane <?php echo ($code==$view)?'active':''?>" id="card-list-<?php echo $code?>"></div>
                        <?php } ?>
                    </div>
                </div>
                <div id="card-list"></div>

            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->


<script type="application/javascript" defer>
    $(document).ready(function(){
        $('#searchcol').selectpicker('refresh');
        $('.bootstrap-select').addClass('bs-select');

        $('#<?php echo $view?>').tab('show');
    });
    $('#searchcol').change(function(){
        if($(this).val()=='')
        {
            $('#searchview').html('');
            elife_Card.searchAll();
        } else {
            $('#searchview').html($('#ctr-'+$(this).val()).html());
            if($(this).val() == 'cardtype')
            {
                $('#frmCardSearch #cardtype').selectpicker('val');
                $('.bootstrap-select').addClass('bs-select')
            }
        }


    });
    $('.nav-tabs li').click(function () {
        if($('#card-list-'+$(this).attr('cardlist')).html()== ''){
            elife_Card.search($(this).attr('cardlist'));
        }

    });
    function Card()
    {
        this.id = 0;
        this.cardid = '';
        this.searchAll = function () {
            this.search($('.nav-tabs .active').attr('cardlist'));
        }
        this.search = function(cardtype)
        {
            showLoading();
            $.get("?route=module/card/loadData&cardtype="+cardtype, $('#frmCardSearch').serialize(), function(html){
                endLoading();
                $('#card-list-'+cardtype).html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;

            showLoading()
            $.get("?route=module/card/validateDel&id="+id,function (data) {
                endLoading();
                if(data == 'true'){
                    var jModalLocationDelete = $('#modal-card-delete');
                    jModalLocationDelete.modal();
                    jModalLocationDelete.find('.modal-header').html("<?php echo $text_do_you_want_to_delete?> " + name + "?");
                }else {
                    var jModalLocationDelete = $('#modal-card-delete-exist');
                    jModalLocationDelete.modal();
                    jModalLocationDelete.find('.modal-header').html("This card may have many orders & payment related, we advise you please do not delete it");
                }
            });

        };

        this._delete = function()
        {
            $.get('?route=module/card/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { elife_Card.searchAll(); };
                    toastr.success('Card has been deleted', '<?php echo $text_delete_success?>', {timeOut: 1000})
                }
            });
        };
        this.history = function(cardid)
        {
            $('#modal-card-history').modal();
            $('#modal-card-history .modal-body').load('?route=module/card/history&cardid='+cardid+'&type=popup');
        }
        this.viewImport = function(orderid){
            $('#modal-order-view').modal();
            $('#modal-order-view #modal-default-header').html('Import View');
            $('#modal-order-view .modal-body').load('?route=module/import/view&orderid='+orderid+'&type=popup');
        }
        this.viewSale = function(orderid){
            $('#modal-order-view').modal();
            $('#modal-order-view #modal-default-header').html('Sale View');
            $('#modal-order-view .modal-body').load('?route=module/sale/view&orderid='+orderid+'&type=popup');
        }
        this.showTotal = function(total)
        {
            $('#frmCardSearch #showtotal').html(total);
        }
        this.view = function (id) {
            $('#modal-card-view').modal();
            $('#modal-card-view .modal-body').load('?route=module/card/view&id='+id+'&type=popup');
        }
        this.loadLocations = function (cardid) {
            this.cardid = cardid;
            $.getJSON("?route=module/card/getCardLocations&col=cardid&val="+cardid,function (data) {
                var str = '';
                for (i in data)
                {
                    str += "<tr>";
                    str += '<td class="text-center">'+ (Number(i)+1) +'</td>';
                    str += '<td>'+data[i].locationname+'</td>';
                    str += '<td>'+data[i].contactname+'</td>';
                    str += '<td>'+data[i].phone+'</td>';
                    str += '<td>'+data[i].email+'</td>';
                    str += '<td>'+data[i].addressline1+'</td>';
                    str += '<td>'+data[i].addressline2+'</td>';
                    str += '<td class="text-center">' +
                    <?php if($this->user->checkPermission("cardLocationDel")){ ?>
                            '<button type="button" class="btn btn-sm btn-default" onclick="elife_Card.removeLocation('+data[i].id+',\''+data[i].locationname+'\')"><span class="fa fa-trash-o"></span></button>' +
                    <?php } ?>
                    <?php if($this->user->checkPermission("cardLocationEdit")){ ?>
                            '<button type="button" class="btn btn-sm btn-default" onclick="elife_Card.showLocationForm(\''+data[i].id+'\',\''+cardid+'\')"><span class="fa fa-edit"></span></button>' +
                    <?php } ?>
                            '</td>';
                    str += '</tr>';
                }
                $('#listlocations').html(str);
            });
        }
        this.showLocationForm = function (locationid,cardid) {
            $('#modal-card-locationform').modal();
            $('#modal-card-locationform .modal-body').load('?route=module/card/getCardLocationForm&id='+locationid+'&cardid='+cardid+'&type=popup');
        }
        this.saveLocation = function () {
            $.post('?route=module/card/saveCardLocation',$('#frmCardLocation').serialize(),function (data) {
                elife_Card.loadLocations(elife_Card.cardid);
                $('#modal-card-locationform').modal('hide');
            });
        }
        this.removeLocation = function (locationid,name) {
            var ans = confirm('Are you sure delete '+name);
            if(ans){
                $.get('?route=module/card/removeLocation&id='+locationid,function (data) {
                    elife_Card.loadLocations(elife_Card.cardid);
                })
            }

        }
        this.editPermission = function (cardid) {
            $('#modal-card-formpermission').modal();
            $('#modal-card-formpermission .modal-body').load('?route=module/card/permissionForm&cardid='+cardid);
        }
        this.savePermission = function () {
            $.post('?route=module/card/savePermission',$('#frmCardPermission').serialize(), function (data) {
                $('#modal-card-formpermission').modal('hide');
            });
        }
    }


    var jFrmCardSearch = $('#frmCardSearch');
    var elife_Card = new Card();
    $(document).ready(function(){
        elife_Card.searchAll();

        jFrmCardSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmCardSearch.find('.form-control').change(function () {
            elife_Card.searchAll();
        });
        $('#btnPrint').click(function () {
            showLoading();
            var data = $('#modal-card-history .modal-body').html();
            endLoading();
            PrintHtml(data);


        });
        $("#btnExportExecl").click(function (e) {
            showLoading();
            var data = $('#modal-card-history .modal-body').html();
            download(data,'cardhistory.xls','xls');
            endLoading();
        });
    });
    function editOrder()
    {
        switch($('#ordertype').val())
        {
            case 'IPO':
            case 'IPC':
            case 'IIN':
            case 'IRO':
                window.open('?route=module/import/update&id='+$('#id').val());
                break;
            case 'ESA':
                window.open('?route=module/sale&id='+$('#id').val());
                break;
        }




    }

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-card-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="elife_Card._delete()"><?php echo $text_ok?></button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal"><?php echo $text_cancel?></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-card-delete-exist" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-lg" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal">Ok, I got it</button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal" onclick="elife_Card._delete()">I still want to try to delete it</button>

            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-card-history" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-fw" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-default-header">History</h4>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnPrint"><span class="fa fa-print"></span></button>
                <button type="button" class="btn btn-default" id="btnExportExecl"><span class="fa fa-file-excel-o"></span></button>
                <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $text_close?></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-card-view" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-fw" role="document">
        <div class="modal-content">
            <div class="modal-body"></div>
            <div class="modal-footer">
                <?php if($this->user->checkPermission("cardLocationAdd")){ ?>
                <button type="button" class="btn btn-default" onclick="elife_Card.showLocationForm('',elife_Card.cardid)"><span class="fa fa-plus"></span> <?php echo $text_add_location?></button>
                <?php } ?>
                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="fa fa-remove"></span> <?php echo $text_close?></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-card-locationform" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-fw" role="document">
        <div class="modal-content">
            <div class="modal-body"></div>
            <div class="modal-footer">

                <button type="button" class="btn btn-default" onclick="elife_Card.saveLocation()"><span class="fa fa-save"></span> Save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="fa fa-remove"></span> <?php echo $text_close?></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-card-formpermission" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-default-header"><?php echo $text_edit?> Permission</h4>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="elife_Card.savePermission()"><span class="fa fa-save"></span> Save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="fa fa-remove"></span> <?php echo $text_close?></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-order-view" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-fw" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-default-header">Import View</h4>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="editOrder()">Edit</button>
                <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $text_close?></button>
            </div>
        </div>
    </div>
</div>
