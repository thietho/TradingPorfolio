<div class="container">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        <?php echo $text_add_new_card?>
        <?php } else { ?>
        <?php echo $text_edit_card?>
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        <?php echo $text_home?> / <?php echo $text_card_list?> /
        <?php if($item['id'] == ""){ ?>
        <?php echo $text_add_new_card?>
        <?php } else { ?>
        <?php echo $text_edit_card?>
        <?php } ?>
    </div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmCard">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                <input type="hidden" id="cardid" name="cardid" value="<?php echo $item['cardid'] ?>">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_card_type?></label>
                        <div class="col-md-9">
                            <select id="cardtype" name="cardtype" class="form-control input-sm">
                                <?php foreach($this->document->cardtype as $type => $name){ ?>
                                <option value="<?php echo $type?>"><?php echo $name?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_full_name?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="fullname" id="fullname" placeholder="<?php echo $text_full_name?>"
                                   value="<?php echo $item['fullname'] ?>">
                        </div>
                    </div>
                    <div class="form-group companyname">
                        <label class="col-md-3 control-label"><?php echo $text_company_name?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="companyname" id="companyname" placeholder="<?php echo $text_company_name?>"
                                   value="<?php echo $item['companyname'] ?>">
                        </div>
                    </div>
                    <div class="form-group taxcode">
                        <label class="col-md-3 control-label"><?php echo $text_taxcode?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="taxcode" id="taxcode" placeholder="<?php echo $text_taxcode?>"
                                   value="<?php echo $item['taxcode'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tài khoản ngân hàng</label>
                        <div class="col-md-9">
                            <textarea class="form-control input-sm"
                                      name="bankinfo" id="bankinfo"><?php echo $item['bankinfo'] ?></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_image?></label>
                        <div class="col-md-9">
                            <input type="hidden" name="image" id="image" value="<?php echo $item['image']?>">
                            <img id="imgimage" width="auto" height="64" src="<?php echo DIR_USERIMAGE ?>autosize-0x64/<?php echo $item['image'] ?>" />

                            <button type="button" class="btn btn-sm btn-default btn-bg btn-success" id="btnSelectImage"><?php echo $text_select?></button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_price_level?></label>
                        <div class="col-md-9">
                            <select id="levelcode" name="levelcode" class="form-control input-sm">
                                <option value=""></option>
                                <?php foreach($pricelevels as $pricelevel){ ?>
                                <option value="<?php echo $pricelevel['levelcode']?>"><?php echo $pricelevel['levelname']?></option>
                                <?php }?>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Email</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="email" id="email" placeholder="Email"
                                   value="<?php echo $item['email'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_telephone?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="telephone" id="telephone" placeholder="<?php echo $text_telephone?>"
                                   value="<?php echo $item['telephone'] ?>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_address_line_1?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="addressline1" id="addressline1" placeholder="<?php echo $text_address_line_1?>"
                                   value="<?php echo $item['addressline1'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_address_line_2?></label>
                        <div class="col-md-9">
                            <select name="addressline2" id="addressline2" class="form-control input-sm">
                                <option value="0">--Khu Vực--</option>
                                <?php foreach($locations as $location){ ?>
                                <option value="<?php echo $location['id']?>"><?php echo $this->string->setLoopStr('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',$location['level'])?><?php echo $location['locationname']?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_birthdate?></label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm bs-datepicker"
                                   name="birthdate" id="birthdate" placeholder="<?php echo $text_birthdate?>"
                                   value="<?php echo $this->date->formatMySQLDate($item['birthdate']) ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_notes?></label>
                        <div class="col-md-9">
                            <textarea type="text" class="form-control input-sm"
                                   name="notes" id="notes" placeholder="<?php echo $text_notes?>"><?php echo $item['notes'] ?></textarea>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <h3>Thông tin giao hàng</h3>
                    <table class="table table-striped table-bordered">
                        <tr>
                            <th><?php echo $text_loction_name?></th>
                            <th><?php echo $text_contact_name?></th>
                            <th><?php echo $text_phone?></th>
                            <th>Email</th>
                            <th><?php echo $text_address_line_1?></th>
                            <th><?php echo $text_address_line_2?></th>
                            <th></th>
                        </tr>
                        <tbody id="locationlist">

                        </tbody>
                    </table>
                    <button type="button" class="btn btn-sm btn-success" id="btnAddCardLocation"><span class="fa fa-plus"></span>Thêm địa chỉ giao hàng</button>
                    <input type="hidden" name="listlocationremove" id="listlocationremove">
                </div>
                <div class="col-md-12">
                    <h3>Cung cấp sản phẩm</h3>
                    <table>
                        <tr>
                            <td>
                                <input type="text" class="form-control input-sm" id="txt_productcode" style="width: 300px" placeholder="Enter <<?php echo $text_item_number?>> or <<?php echo $text_barcode?>>" autocomplete="off">
                                <input type="hidden" id="productcode">
                            </td>
                            <td>
                                <input type="text" id="import" class="form-control input-sm number" placeholder="Giá nhập" style="width: 200px">
                            </td>
                            <td><label id="lbl_unit"></label></td>
                            <td><button type="button" class="btn btn-sm btn-success" id="btnAddCardProduct"><span class="fa fa-plus"></span></button></td>
                        </tr>
                    </table>



                    <table class="table table-striped table-bordered">
                        <tr>
                            <th><?php echo $text_product_code?></th>
                            <th><?php echo $text_product?></th>
                            <th>Giá nhập</th>
                            <th>Đơn vị</th>
                            <th></th>
                        </tr>
                        <tbody id="productlist">

                        </tbody>
                    </table>

                    <input type="hidden" name="listproductremove" id="listproductremove">
                </div>

            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveCard">
                        <?php echo $item['id'] == '' ? $text_insert : $text_update ?>
                    </button>
                    <button id="btnCancelCard" type="button" class="btn btn-sm btn-default btn-bg"><?php echo $text_cancel?></button>
                </div>
            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->
<table id="" style="display: none">
    <tbody id="cardlocationtemplate">
    <tr id="row{index}">
        <td>
            <input type="text" class="form-control input-sm locationname" name="location[locationname][{index}]" id="locationname-{index}" placeholder="<?php echo $text_loction_name?>">
            <input type="hidden" name="location[id][{index}]" id="id-{index}">
        </td>
        <td>
            <input type="text" class="form-control input-sm" name="location[contactname][{index}]" id="contactname-{index}" placeholder="<?php echo $text_contact_name?>">
        </td>
        <td>
            <input type="text" class="form-control input-sm" name="location[phone][{index}]" id="phone-{index}" placeholder="<?php echo $text_phone?>">
        </td>
        <td>
            <input type="text" class="form-control input-sm" name="location[email][{index}]" id="email-{index}" placeholder="Email">
        </td>
        <td>
            <input type="text" class="form-control input-sm" name="location[addressline1][{index}]" id="addressline1-{index}" placeholder="<?php echo $text_address_line_1?>">
        </td>
        <td>
            <select name="location[addressline2][{index}]" id="addressline2-{index}" class="form-control input-sm">
                <option value="0">--Khu Vực--</option>
                <?php foreach($locations as $location){ ?>
                <option value="<?php echo $location['id']?>"><?php echo $this->string->setLoopStr('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',$location['level'])?><?php echo $location['locationname']?></option>
                <?php } ?>
            </select>
        </td>
        <td>
            <button type="button" class="btnGetInfo btn btn-danger btn-sm" index="{index}" onclick="card.getInfo({index})">Lấy thông tin liên hệ</button>
            <button type="button" class="btnRemoveLocation btn btn-danger btn-sm" index="{index}" onclick="card.removeRow({index})"><span class="fa fa-trash"></span></button>
        </td>
    </tr>
    </tbody>

</table>
<table id="" style="display: none">
    <tbody id="cardproducttemplate">
    <tr id="row{index}">
        <td>
            <label id="lblproductcode-{index}"></label>
            <input type="hidden" name="product[id][{index}]" id="id-{index}">
            <input type="hidden" name="product[productcode][{index}]" id="productcode-{index}">
        </td>
        <td>
            <label id="lblproductname-{index}"></label>
        </td>
        <td>
            <input type="text" class="form-control input-sm number" name="product[import][{index}]" id="import-{index}" placeholder="Gía nhập">
        </td>
        <td>
            <label id="lblunit-{index}"></label>
            <input type="hidden" name="product[unit][{index}]" id="unit-{index}">
        </td>
        <td>
            <button type="button" class="btnRemoveProduct btn btn-danger btn-sm" index="{index}" onclick="card.removeRow({index})"><span class="fa fa-trash"></span></button>
        </td>
    </tr>
    </tbody>

</table>
<script type="application/javascript" defer>

function selectProduct(item) {
    //alert('You selected <strong>' + item.value + '</strong>: <strong>' + item.text + '</strong>');
    $('#frmCard #productcode').val(item.value);
    $.getJSON("?route=module/product/getProductsByCode&code="+item.value,function(data){
        $('#frmCard #lbl_unit').html(data[0].unit);
        $('#frmCard #import').focus();
    });
}
$('#btnAddCardProduct').click(function () {
    if($('#frmCard #productcode').val() != ''){
        card.addProductRow(card.index);
        $('#frmCard #lblproductcode-'+card.index).html($('#frmCard #productcode').val());
        $('#frmCard #productcode-'+card.index).val($('#frmCard #productcode').val());
        $('#frmCard #lblproductname-'+card.index).html($('#frmCard #txt_productcode').val());
        $('#frmCard #import-'+card.index).val($('#frmCard #import').val());
        $('#frmCard #lblunit-'+card.index).html($('#frmCard #lbl_unit').html());
        $('#frmCard #unit-'+card.index).val($('#frmCard #lbl_unit').html());
        numberReady();
        card.index++;
        $('#frmCard #productcode').val('');
        $('#frmCard #txt_productcode').val('');
        $('#frmCard #import').val('')
        $('#frmCard #lbl_unit').html('');
        $('#txt_productcode').focus();
    }

});
$('#frmCard #import').keyup(function (e) {
    if(e.keyCode == 13){
        $('#btnAddCardProduct').click();
    }
});
$('#btnAddCardLocation').click(function () {
    card.addRow(card.index);
    card.index++;
});
var type = "<?php echo $_GET['type'];?>";
if(type != 'popup') {
    $('#btnSaveCard').click(function () {
        showLoading();
        $('#btnSaveCard').attr("disabled","disabled");
        $.post("?route=module/card/save", $('#frmCard').serialize(), function (data) {

            var obj = $.parseJSON(data)
            if (obj.errorstext != '') {
                toastr.error(obj.errorstext, "<?php echo $text_errors?>");
                $('#btnSaveCard').removeAttr('disabled');
                endLoading();
            }
            else {
                if (type == '') {
                    toastr.options.onHidden = function () {
                        window.location = '?route=module/card'
                    };
                }
                if (type == 'editprofile') {
                    toastr.options.onHidden = function () {
                        window.history.back()
                    };
                }
                toastr.success('Card has been save', '<?php echo $text_save_success?>', {timeOut: 1000});
            }

        });
    });
    $('#btnCancelCard').click(function () {
        //window.location.href='<?php echo HTTP_WEB ?>?route=module/card';
        window.history.back();
    });

    $('#btnSelectImage').click(function () {
        $('#modal-select-file').modal();
        var folder = "card";
        if ($('#frmCard #cardid').val() == '')
            folder += "/temp" + Date.now();
        else
            folder += "/" + $('#frmCard #cardid').val();
        $('#modal-select-file .modal-body').load('?route=core/uploadfile&folder=' + folder + "&eid=image", function () {

        });
    });
}
    function Card() {
        this.cardid = "<?php echo $item['cardid'] ?>";

        this.index = 0;
        this.addRow = function (pos) {
            var row = $('#cardlocationtemplate').html();
            row = strReplace('{index}', pos,row);
            $('#frmCard #locationlist').append(row);


        };
        this.getInfo = function (pos) {
            $('#contactname-'+pos).val($('#frmCard #fullname').val());
            $('#phone-'+pos).val($('#frmCard #telephone').val());
            $('#email-'+pos).val($('#frmCard #email').val());
            $('#addressline1-'+pos).val($('#frmCard #addressline1').val());
            $('#addressline2-'+pos).val($('#frmCard #addressline2').val());
        };
        this.removeRow = function (pos) {
            var locationid = $('#id-'+pos).val();
            var listid = $('#listlocationremove').val();
            listid += locationid+',';
            $('#listlocationremove').val(listid);
            $('#row'+pos).remove();
        };
        this.addDataRow = function (data) {
            this.addRow(this.index);
            $('#id-'+this.index).val(data.id);
            $('#locationname-'+this.index).val(data.locationname);
            $('#locationname-'+this.index).val(data.locationname);
            $('#contactname-'+this.index).val(data.contactname);
            $('#phone-'+this.index).val(data.phone);
            $('#email-'+this.index).val(data.email);
            $('#addressline1-'+this.index).val(data.addressline1);
            $('#addressline2-'+this.index).val(data.addressline2);
            this.index++;
        };
        this.removeRow = function (pos) {
            var id = $('#id-'+pos).val();
            var listid = $('#listproductremove').val();
            listid += id+',';
            $('#listproductremove').val(listid);
            $('#row'+pos).remove();
        };
        this.addProductRow = function (pos) {
            var row = $('#cardproducttemplate').html();
            row = strReplace('{index}', pos,row);
            $('#frmCard #productlist').append(row);
        }
    }
    var card = new Card();
$(document).ready(function () {
    $('#frmCard #cardtype').val("<?php echo $item['cardtype']?>");
    $('#frmCard #levelcode').val("<?php echo $item['levelcode']?>");
    $('#frmCard #addressline2').val("<?php echo $item['addressline2']?>");
    if(card.cardid ==''){
        card.addRow(card.index);
        $('#locationname-'+card.index).val('Default');
        card.index++;
    }else {
        $.getJSON("?route=module/card/getCardLocations&col=cardid&val="+card.cardid,function (data) {
            for (i in data){
                card.addDataRow(data[i]);
            }
        });
        $.getJSON("?route=module/card/getCardProducts&col=cardid&val="+card.cardid,function (data) {
            for (i in data){
                card.addProductRow(card.index);
                $('#frmCard #id-'+card.index).val(data[i].id);
                $('#frmCard #lblproductcode-'+card.index).html(data[i].productcode);
                $('#frmCard #productcode-'+card.index).val(data[i].productcode);
                $('#frmCard #lblproductname-'+card.index).html(data[i].name);
                $('#frmCard #import-'+card.index).val(data[i].import);
                $('#frmCard #lblunit-'+card.index).html(data[i].unit);
                $('#frmCard #unit-'+card.index).val(data[i].unit);
                numberReady();
                card.index++;
            }
        });
    }
    $('#frmCard #cardtype').change(function () {
        if($(this).val() == 'supplier'){
            $('#frmCard .companyname').hide();
            $('#frmCard .taxcode').hide();
        }
    });
    $('#frmCard #cardtype').change();
    $('#txt_productcode').typeahead({

        ajax:"?route=module/product/getProducts"+$(this).val(),
        display:'name',
        val:'productcode',
        onSelect: selectProduct
    });
    numberReady();
});
</script>