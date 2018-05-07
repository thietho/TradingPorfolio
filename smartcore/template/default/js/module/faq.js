function goPage(page, filter) {
    window.location.href = "?route=module/faq/" + filter + "&page=" + page;
}

function updateList() {
    showloading();
    var jErrorMessage = $('.error-message');
    jErrorMessage.html('');
    jErrorMessage.hide();

    var $url = "index.php?route=module/faq/updatePosition";
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


function confirmDeleteList() {
    showSimpleModal("<?php echo $lang_text_delete_data ?>", "<?php echo $lang_text_confirm_delete ?>", "faq_delete()", "<?php echo $lang_text_cancel?>", "<?php echo $lang_text_delete ?>");
}

function faq_delete() {
    closeSimpleModal();

    showloading();
    var jErrorMessage = $('.error-message');
    jErrorMessage.html('');
    jErrorMessage.hide();

    var url = "?route=module/faq/deleteList";
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


function publish(onwer, $mediaid, $status) {
    showloading();
    var jErrorMessage = $('.error-message');

    $.post("<?php echo HTTP_SERVER ?>?route=module/faq/active", {mediaid : $mediaid, status : $status},function($data) {
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
            jErrorMessage.html('');
            jErrorMessage.hide();

            toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');

            var $rowItem = $(onwer).parent().parent();
            if($status == 'pending') {
                $(onwer).html('<?php echo $lang_text_publish ?>');
                $(onwer).attr('onclick', "publish(this, '" + $mediaid  + "', 'active')");
                if(!$rowItem.hasClass('danger')) {
                    $rowItem.addClass('danger');
                }
            } else {
                $(onwer).html('<?php echo $lang_text_hidden ?>');
                $(onwer).attr('onclick', "publish(this, '" + $mediaid  + "', 'pending')");
                if($rowItem.hasClass('danger')) {
                    $rowItem.removeClass('danger');
                }
            }

        }


    });
}


function sort(object, $orderby) {
    var $sort = $(object).attr('sort');
    var $page = "<?php echo $page ?>";
    var $sitemapid = "<?php echo $sitemap['sitemapid'] ?>";
    window.location.href = "?route=module/faq/&sitemapid="+ $sitemapid + "&orderby=" + $orderby + "&sort=" + $sort + "&page=" + $page;
}


function searchForm() {
    var $sitemapid = "<?php echo $sitemap['sitemapid'] ?>";
    var $search_title = $('#search_title').val().trim();
    var $search_status = $('#search_status').val().trim();

    var url = "?route=module/faq&sitemapid=" + $sitemapid;
    if (0 != $search_title.length) {
        url += "&search_title=" + encodeURIComponent($search_title);
    }
    if (0 != $search_status.length) {
        url += "&search_status=" + encodeURIComponent($search_status);
    }
    url += "&page=1";
    window.location.href = url;
}

function viewFaqAll() {
    var $sitemapid = "<?php echo $sitemap['sitemapid'] ?>";
    window.location.href = "?route=module/faq&sitemapid=" + $sitemapid;
}

$(document).ready(function(){
    $('#frmsearch').submit(function(e){
        e.preventDefault();
        searchForm();
    });
});