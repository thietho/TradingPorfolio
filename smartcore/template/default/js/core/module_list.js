function goPage(page, filter) {
    window.location.href = "?route=core/module/" + filter + "&page=" + page;
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

    var url = "?route=core/module/deleteList";
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


function updateList() {
    showloading();
    var jErrorMessage = $('.error-message');
    jErrorMessage.html('');
    jErrorMessage.hide();

    var $url = "index.php?route=core/module/updatePosition";
    $.post($url, $('#formlist').serialize(), function ($data) {
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
    var $search_moduleid = $('#search_moduleid').val().trim();
    var $search_areacode = $('#search_areacode').val().trim();
    var $search_modulename = $('#search_modulename').val().trim();
    var $search_status = $('#search_status').val().trim();

    var url = "?route=core/module";
    if (0 != $search_moduleid.length) {
        url += "&search_moduleid=" + encodeURIComponent($search_moduleid);
    }
    if (0 != $search_areacode.length) {
        url += "&search_areacode=" + encodeURIComponent($search_areacode);
    }
    if (0 != $search_modulename.length) {
        url += "&search_modulename=" + encodeURIComponent($search_modulename);
    }
    if (0 != $search_status.length) {
        url += "&search_status=" + encodeURIComponent($search_status);
    }
    url += "&page=1";
    window.location.href = url;
}

function viewModuleAll() {
    window.location.href = "?route=core/module";
}

$(document).ready(function(){
    $('#frmsearch').submit(function(e){
        e.preventDefault();
        searchForm();
    });
});