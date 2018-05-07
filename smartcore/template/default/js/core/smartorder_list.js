function goPage(page, filter) {
    window.location.href = "?route=core/smartorder/" + filter + "&page=" + page;
}



var $orders = JSON.parse('<?php echo $orders_json ?>');

/*
for (var $orderid in $orders) {
    if ($orders.hasOwnProperty($orderid)) {
        var $products = $orders[$orderid]['products'];
        alert($products.length);

        break;
    }
}
*/

/*
function showSimpleModal($title, $content, $callback, $text_cancel, $text_ok) {
    var $template = '<div id="simpleModal" class="modal fade" aria-hidden="true" aria-labelledby="simpleModalLabel" role="dialog" tabindex="-1" style="display: none;">';
    $template += '<div class="modal-dialog">';
    $template += '<div class="modal-content">';
    $template += '<div class="modal-header">';
    $template += '<button class="close" aria-hidden="true" data-dismiss="modal" type="button">×</button>';
    $template += '<h4 id="simpleModalLabel" class="modal-title">'+ $title +'</h4>';
    $template += '</div>';
    $template += '<div class="modal-body">';
    $template += '<p>'+ $content +'</p>';
    $template += '</div>';
    $template += '<div class="modal-footer">';
    $template += '<button class="btn btn-default" type="button" onclick="closeSimpleModal()">'+ $text_cancel +'</button>';
    $template += '<button class="btn btn-primary" type="button" onclick="'+ $callback +'">'+ $text_ok +'</button>';
    $template += '</div></div></div></div>';

    $('body').append($template);
    $("#simpleModal").modal('show');
}

function closeSimpleModal() {
    var jSimpleModal = $("#simpleModal");
    jSimpleModal.modal('hide');
    $('.modal-backdrop').remove();
    jSimpleModal.remove();
}
*/


function showOrderDetailModal($orderid) {

    var $logo_path = "<?php echo $this->config->get('config_logo') ?>";

    var $template = '<div id="orderDetailModal" class="modal fade" aria-hidden="true" aria-labelledby="formModalLabel" role="dialog" tabindex="-1" style="display: none;">';
    $template += '<div class="modal-dialog smartorder">';
    $template += '<div class="row">';
    $template += '<div class="col-lg-12">';
    $template += '<div class="box box-printable style-transparent">';
    $template += '<div class="box-head"><div class="tools"><div class="btn-group"><button class="btn btn-primary" aria-hidden="true" data-dismiss="modal" type="button"><i class="fa fa-close"></i>&nbsp;<?php echo $lang_text_close ?></button></div></div></div>';
    $template += '<div class="box-body style-white">';
    $template += '<div class="row">';
    $template += '<div class="col-xs-12 text-center"><img border="0" height="120" src="<?php echo DIR_USERIMAGE ?>autosize-0x120/'+ $logo_path +'"/></div>';
    $template += '<div class="col-md-12 text-center"><h1 class="text-light text-gray-light"><?php echo $lang_text_invoice ?></h1></div>';
    $template += '</div>';
    $template += '<div class="row">';
    $template += '<div class="col-md-12"><div class="invoice-no-section no-padding-left-right text-center clearfix"><?php echo $lang_text_invoice_no ?>: <strong class="text-lg">'+ $orders[$orderid]['orderid'] +'</strong><br/><?php echo $lang_text_invoice_date ?>: <strong>'+ $orders[$orderid]['orderdate_format'] +'</strong></div></div>';
    $template += '</div>';

    $template += '<div class="row">';
    $template += '<div class="box-body no-padding-left-right">';
    $template += '<div class="col-md-6">';
    $template += '<h4 class="text-light opacity-50"><?php echo $lang_text_prepared_by ?></h4>';
    $template += '<address><strong>'+ $orders[$orderid]['customername'] +'</strong><br>'+ $orders[$orderid]['address'] +'<br/></address>';
    $template += '<address><span><i class="fa fa-envelope fa-fw"></i>&nbsp;'+ $orders[$orderid]['email'] +'</span><br/><span><i class="fa fa-phone fa-fw"></i>&nbsp;'+ $orders[$orderid]['phone'] +'</span></address>';
    $template += '</div>';

    if(0 != $orders[$orderid]['shipment_name'].length) {
        $template += '<div class="col-md-6">';
        $template += '<h4 class="text-light opacity-50"><?php echo $lang_text_prepared_for ?></h4>';
        $template += '<address><strong>'+ $orders[$orderid]['shipment_name'] +'</strong><br>'+ $orders[$orderid]['shipment_address'] +'<br/></address>';
        $template += '<address><span><i class="fa fa-envelope fa-fw"></i>&nbsp;'+ $orders[$orderid]['shipment_email'] +'</span><br/><span><i class="fa fa-phone fa-fw"></i>&nbsp;'+ $orders[$orderid]['shipment_phone'] +'</span></address>';
        $template += '</div>';
    }
    $template += '</div></div>';


    if(0 != $orders[$orderid]['comment'].length) {
        $template += '<div class="row">';
        $template += '<div class="col-md-12"><h4 class="text-light opacity-50"><?php echo $lang_text_customer_note ?></h4></div>';
        $template += '<div class="col-md-12"><p>'+ $orders[$orderid]['comment'] +'</p></div>';
        $template += '</div>';
    }


    $template += '<div class="row">';
    $template += '<div class="box-body no-padding-left-right">';
    $template += '<div class="col-md-12">';
    $template += '<h4 class="text-light opacity-50"><?php echo $lang_text_customer_ordered_list ?></h4>';
    $template += '<div class="list-cart-th clearfix">';
    $template += '<div class="list-cart-th-col list-cart-row-col1 pull-left"><?php echo $lang_text_product_model ?></div>';
    $template += '<div class="list-cart-th-col list-cart-row-col2 pull-left"><?php echo $lang_text_product_name ?></div>';
    $template += '<div class="list-cart-th-col list-cart-row-col3 pull-left text-right"><?php echo $lang_text_product_price ?></div>';
    $template += '</div>';


    $template += '<div class="list-cart">';
    var $products = $orders[$orderid]['products'];
    for (var $index in $products) {
        if ($products.hasOwnProperty($index)) {
            $template += '<div class="list-cart-row clearfix">';
            $template += '<div class="list-cart-row-col1 pull-left">'+ $products[$index]['model'] +'</div>';
            $template += '<div class="list-cart-row-col2 pull-left">';
            $template += '<div class="cart-section-info"><div class="cart-product-name">'+ $products[$index]['name'] +'</div></div>';
            $template += '<div class="cart-section-info cart-product-model"><div class="cart-product-label">Model: '+ $products[$index]['model'] +'</div></div>';
            $template += '<div class="cart-section-info"><div class="cart-product-label"><?php echo $lang_text_product_size ?>: '+ $products[$index]['size'] +'</div></div>';
            $template += '<div class="cart-section-info end"><div class="cart-product-label"><?php echo $lang_text_product_color ?>: '+ $products[$index]['color'] +'</div></div>';
            $template += '</div>';
            $template += '<div class="list-cart-row-col3 pull-left">';
            $template += '<div class="col-price"><span>'+ $products[$index]['quantity'] +'</span>&nbsp;x&nbsp;<span>'+ $products[$index]['price_format'] +'</span></div>';
            $template += '</div>';
            $template += '</div>';
        }
    }

    $template += '<div class="list-cart-row other clearfix">';
    $template += '<div class="list-cart-row-col1 pull-left">&nbsp;</div>';
    $template += '<div class="list-cart-row-col2 pull-left text-right"><div class="cart-product-name"><?php echo $lang_text_total_price ?></div></div>';
    $template += '<div class="list-cart-row-col3 other pull-left"><div class="col-price">'+ $orders[$orderid]['total_format'] +'</div></div>';
    $template += '</div>';

    $template += '</div></div></div></div></div></div></div></div></div></div>';



    $('#orderDetailModal').remove();
    $('body').append($template).promise().done(function() {
        $('#orderDetailModal').modal('show');
    });


}



function sort(object, $orderby) {
    var $sort = $(object).attr('sort');
    var $page = "<?php echo $page ?>";
    window.location.href = "?route=core/smartorder/&orderby=" + $orderby + "&sort=" + $sort + "&page=" + $page;
}


function searchForm() {
    var $search_orderid = $('#search_orderid').val().trim();
    var $search_orderdate_from = $('#search_orderdate_from').val().trim();
    var $search_orderdate_to = $('#search_orderdate_to').val().trim();
    var $search_customername = $('#search_customername').val().trim();
    var $search_email = $('#search_email').val().trim();
    var $search_status = $('#search_status').val().trim();

    var url = "?route=core/smartorder";
    if (0 != $search_orderid.length) {
        url += "&search_orderid=" + encodeURIComponent($search_orderid);
    }
    if (0 != $search_orderdate_from.length) {
        url += "&search_orderdate_from=" + encodeURIComponent($search_orderdate_from);
    }
    if (0 != $search_orderdate_to.length) {
        url += "&search_orderdate_to=" + encodeURIComponent($search_orderdate_to);
    }
    if (0 != $search_customername.length) {
        url += "&search_customername=" + encodeURIComponent($search_customername);
    }
    if (0 != $search_email.length) {
        url += "&search_email=" + encodeURIComponent($search_email);
    }
    if (0 != $search_status.length) {
        url += "&search_status=" + encodeURIComponent($search_status);
    }
    url += "&page=1";
    window.location.href = url;
}

function viewOrderAll() {
    window.location.href = "?route=core/smartorder";
}


function changeStatus(owner, $orderid) {
    showloading();
    var jErrorMessage = $('.error-message');
    jErrorMessage.html('');
    jErrorMessage.hide();


    var $status = $(owner).val();

    $.post("<?php echo HTTP_SERVER ?>?route=core/smartorder/changeStatus", {orderid : $orderid, status : $status},function($data) {
        endloading();

        var $response = JSON.parse($data);
        var $errors = $response['errors'];
        if($response['status'] == 'failed') {
            jErrorMessage.html('');
            var $error_panel = '<div class="alert alert-danger" role="alert">';
            $error_panel += '<a class="close" title="close" aria-label="close" data-dismiss="alert" href="#">×</a>';
            for (var $error_code in $errors) {
                if ($errors.hasOwnProperty($error_code)) {
                    $error_panel += '<p>-&nbsp;'+ $errors[$error_code] +'</p>';
                }
            }
            $error_panel += '</div>';
            jErrorMessage.append($error_panel);
            jErrorMessage.show();

            $("html, body").animate({ scrollTop: 0 }, "fast");
            toastr.error('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');

        } else {
            toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');

            var $rowItem = $(owner).parent().parent();
            $rowItem.removeClass('bg-info');
            $rowItem.removeClass('bg-warning');
            $rowItem.removeClass('bg-success');
            $rowItem.removeClass('bg-danger');

            //hidden 3 nut
            var jactive = $('#order-active-'+ $orderid);
            var jdeliver = $('#order-deliver-'+ $orderid);
            var jdelete = $('#order-delete-'+ $orderid);

            jactive.hide();
            jdeliver.hide();
            jdelete.hide();

            if($status == "pending") {
                $rowItem.addClass('bg-info');
            } else if($status == "active") {
                $rowItem.addClass('bg-warning');
                jactive.show();
            } else if($status == "deliver") {
                $rowItem.addClass('bg-success');
                jdeliver.show();
            } else if($status == "cancel") {
                $rowItem.addClass('bg-danger');
                jdelete.show();
            }
        }
    });
}

// send email active

function sendEmailActive($orderid) {
    showSimpleModal("<?php echo $lang_text_send_email_data ?>", "<?php echo $lang_text_confirm_send_email ?>", "send_email_active('" + $orderid + "')", "<?php echo $lang_text_cancel?>", "<?php echo $lang_text_send ?>");

}

function send_email_active($orderid) {
    closeSimpleModal();
    showloading();
    var jErrorMessage = $('.error-message');
    jErrorMessage.html('');
    jErrorMessage.hide();

    var url = "?route=core/smartorder/sendEmailActive";
    $.post(url, {orderid : $orderid}, function ($data) {
        endloading();
        var $jMessageBox = $('#messagebox');
        var $response = JSON.parse($data);

        if($response['status'] == 'failed') {
            console.log($response['message']);
            $jMessageBox.find('.table-cell-message').html($response['message']);
            $.fancybox("#messagebox");

        } else {
            toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');
        }
    });
}

// send email deliver

function sendEmailDeliver($orderid) {
    showSimpleModal("<?php echo $lang_text_send_deliver_data ?>", "<?php echo $lang_text_confirm_send_email ?>", "send_email_deliver('" + $orderid + "')", "<?php echo $lang_text_cancel?>", "<?php echo $lang_text_send ?>");

}

function send_email_deliver($orderid) {
    closeSimpleModal();
    showloading();
    var jErrorMessage = $('.error-message');
    jErrorMessage.html('');
    jErrorMessage.hide();

    var url = "?route=core/smartorder/sendEmailDeliver";
    $.post(url, {orderid : $orderid}, function ($data) {
        endloading();
        var $jMessageBox = $('#messagebox');
        var $response = JSON.parse($data);

        if($response['status'] == 'failed') {
            console.log($response['message']);
            $jMessageBox.find('.table-cell-message').html($response['message']);
            $.fancybox("#messagebox");

        } else {
            toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');
        }
    });
}


function deleteOrder($orderid) {
    showSimpleModal("<?php echo $lang_text_delete_data ?>", "<?php echo $lang_text_confirm_delete ?>", "order_delete('" + $orderid + "')", "<?php echo $lang_text_cancel?>", "<?php echo $lang_text_delete ?>");

}

function order_delete($orderid) {
    closeSimpleModal();

    showloading();
    var jErrorMessage = $('.error-message');
    jErrorMessage.html('');
    jErrorMessage.hide();

    var url = "?route=core/smartorder/delete";
    $.post(url, {orderid : $orderid}, function ($data) {
        endloading();
        var $jMessageBox = $('#messagebox');
        var $response = JSON.parse($data);

        if($response['status'] == 'failed') {
            console.log($response['message']);
            $jMessageBox.find('.table-cell-message').html($response['message']);
            $.fancybox("#messagebox");

        } else {
            toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');
            //window.location.reload();
            $('#order-delete-' + $orderid).parent().parent().parent().remove();
        }
    });
}

$(document).ready(function(){
    $('#order-date-from, #order-date-to').datetimepicker({
        pickTime: false
    });

    $('#frmsearch').submit(function(e){
        e.preventDefault();
        searchForm();
    });
});