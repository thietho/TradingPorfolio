function goPage(page, filter) {
    window.location.href = "?route=module/customer/" + filter + "&page=" + page;
}

function confirmDeleteList() {
    showSimpleModal("<?php echo $lang_text_delete_data ?>", "<?php echo $lang_text_confirm_delete ?>", "module_delete()", "<?php echo $lang_text_cancel?>", "<?php echo $lang_text_delete ?>");
}

function module_delete() {
    closeSimpleModal();

    showloading();
    var jErrorMessage = $('.error-message');
    jErrorMessage.html('');
    jErrorMessage.hide();

    var url = "?route=module/customer/deleteList";
    $.post(url, $('#formlist').serialize(), function ($data) {
        var $response = JSON.parse($data);
        var $errors = $response['errors'];
        if($response['status'] == 'failed') {
            endloading();

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
            window.location.reload();
        }
    });
}

function searchForm() {
    var $search_email = $('#search_email').val().trim();
    var $search_customername = $('#search_customername').val().trim();

    var url = "?route=module/customer";

    if (0 != $search_customername.length) {
        url += "&search_customername=" + encodeURIComponent($search_customername);
    }
    if (0 != $search_email.length) {
        url += "&search_email=" + encodeURIComponent($search_email);
    }

    url += "&page=1";

    window.location.href = url;


}

function viewCustomereAll() {
    window.location.href = "?route=module/customer";

}

$(document).ready(function(){

    $('#frmsearch').submit(function(e){
        e.preventDefault();
        searchForm();
    });
});

// check Active Customer

function approveCustomer(owner, $customerid) {


    showloading();
    var jErrorMessage = $('.error-message');
    jErrorMessage.html('');
    jErrorMessage.hide();

    var url = "?route=module/customer/activeCustomer";
    $.post(url, {customerid : $customerid}, function ($data) {
        endloading();
        var $jMessageBox = $('#messagebox');
        var $response = JSON.parse($data);

        if($response['status'] == 'failed') {
            $jMessageBox.find('.table-cell-message').html($response['message']);
            $.fancybox("#messagebox");

        } else {
            toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');


            var $rowItem = $(owner).parent().parent();
            $rowItem.removeClass('bg-active');
            $rowItem.removeClass('bg-unactive');

            if($response['approved'] == 1) {
                $rowItem.addClass('bg-active');
                $(owner).html('<?php echo $lang_text_lock ?>');
            } else  {
                $rowItem.addClass('bg-unactive');
                $(owner).html('<?php echo $lang_text_active ?>');
            }

        }
    });

}

