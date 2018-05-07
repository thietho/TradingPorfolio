var $jSitename = $('#sitename');
var $jSiteurl = $('#siteurl');

$(document).ready(function(){
    $jSitename.focus();
});

function save() {
    //validate form
    if(validateForm()) {
        showloading();
        $.post("?route=elife/setting/save", $("#frm_setting").serialize(), function($data) {
            endloading();
            var $response = JSON.parse($data);
            var $errors = $response['errors'];
            if($response['status'] == 'failed') {
                for (var $error_code in $errors) {
                    if ($errors.hasOwnProperty($error_code)) {
                        if($error_code == 'sitename') {
                            showError($jSitename);
                        }
                        if($error_code == 'siteurl') {
                            showError($jSiteurl);
                        }
                    }
                }
                $("html, body").animate({ scrollTop: 0 }, "fast");
                toastr.error('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');

            } else {
                toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');
            }
        });
    }
}

function showError($jSelector) {
    $jSelector.parent().addClass('has-error');
    $jSelector.siblings(".help-block").css('display', 'inline-block');
}

function hideError($jSelector) {
    $jSelector.parent().removeClass('has-error');
    $jSelector.siblings(".help-block").css('display', 'none');
}


function validateForm() {
    var $isValid = true;
    var $sitename = $jSitename.val().trim();
    var $siteurl = $jSiteurl.val().trim();

    if($sitename.length == 0) {
        showError($jSitename);
        $isValid = false;
    } else {
        hideError($jSitename);
    }

    if($siteurl.length == 0) {
        showError($jSiteurl);
        $isValid = false;
    } else {
        hideError($jSiteurl);
    }

    return $isValid;
}

function cancel() {
    window.location.href = "?route=page/home";
}