var $jUserId = $('#userid');
var $jUsername = $('#username');
var $jFullname = $('#fullname');
var $jEmail = $('#email');
var $jPassword = $('#password');
var $jConfirmPassword = $('#confirmpassword');


function showError($jSelector, $classHelp) {
    $jSelector.parent().addClass('has-error');
    $jSelector.siblings("." + $classHelp).css('display', 'inline-block');
}

function hideError($jSelector, $classHelp) {
    $jSelector.parent().removeClass('has-error');
    $jSelector.siblings("." + $classHelp).css('display', 'none');
}


function save() {
    //validate form
    if(validate_form()) {
        showloading();
        $.post("?route=core/user/save", $("#frmform").serialize(), function($data) {
            endloading();
            var $response = JSON.parse($data);
            var $errors = $response['errors'];
            if($response['status'] == 'failed') {
                for (var $error_code in $errors) {
                    if ($errors.hasOwnProperty($error_code)) {
                        if($error_code == 'username') {
                            showError($jUsername, 'username-required');
                        }
                        if($error_code == 'fullname') {
                            showError($jFullname, 'fullname-required');
                        }
                        if($error_code == 'email-required') {
                            showError($jEmail, 'email-required');
                        }
                        if($error_code == 'email-invalid') {
                            showError($jEmail, 'email-invalid');
                        }

                        if($error_code == 'username-used') {
                            showError($jUsername, 'username-used');
                        }
                        if($error_code == 'password-required') {
                            showError($jPassword, 'password-required');
                        }
                        if($error_code == 'password-length') {
                            showError($jPassword, 'password-length');
                        }
                        if($error_code == 'confirmpassword-required') {
                            showError($jConfirmPassword, 'confirmpassword-required');
                        }
                        if($error_code == 'confirmpassword-match') {
                            showError($jConfirmPassword, 'confirmpassword-match');
                        }
                    }
                }
                $("html, body").animate({ scrollTop: 0 }, "fast");
                toastr.error('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');

            } else {
                toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');
                if($jUserId.val().trim().length == 0) {
                    window.location.href = "?route=core/user";
                }
            }
        });
    }
}


function validate_form() {
    var $isValid = true;
    var $userid = $jUserId.val().trim();
    var $username = $jUsername.val().trim();
    var $fullname = $jFullname.val().trim();
    var $email = $jEmail.val().trim();


    if(0 == $username.length) {
        showError($jUsername, 'username-required');
        $isValid = false;
    } else {
        hideError($jUsername, 'username-required');
    }

    if(0 == $fullname.length) {
        showError($jFullname, 'fullname-required');
        $isValid = false;
    } else {
        hideError($jFullname, 'fullname-required');
    }

    if(0 == $email.length) {
        showError($jEmail, 'email-required');
        $isValid = false;
    } else {
        hideError($jEmail, 'email-required');

        //check email valid
        if(!validateEmail($email)) {
            showError($jEmail, 'email-invalid');
            $isValid = false;
        } else {
            hideError($jEmail, 'email-invalid');
        }
    }

    //check for case insert new user
    if(0 == $userid.length) {
        var $password = $jPassword.val().trim();
        var $confirmpassword = $jConfirmPassword.val().trim();

        if(0 == $password.length) {
            showError($jPassword, 'password-required');
            $isValid = false;
        } else {
            hideError($jPassword, 'password-required');
        }

        if(5 > $password.length) {
            showError($jPassword, 'password-length');
            $isValid = false;
        } else {
            hideError($jPassword, 'password-length');
        }

        if(0 == $confirmpassword.length) {
            showError($jConfirmPassword, 'confirmpassword-required');
            $isValid = false;
        } else {
            hideError($jConfirmPassword, 'confirmpassword-required');
        }

        if(5 > $confirmpassword.length) {
            showError($jConfirmPassword, 'confirmpassword-length');
            $isValid = false;
        } else {
            hideError($jConfirmPassword, 'confirmpassword-length');
        }

        if($confirmpassword.length >= 5 && $password.length >= 5) {
            if($confirmpassword != $password) {
                showError($jConfirmPassword, 'confirmpassword-match');
                $isValid = false;
            } else {
                hideError($jConfirmPassword, 'confirmpassword-match');
            }
        }

    }

    return $isValid;
}


