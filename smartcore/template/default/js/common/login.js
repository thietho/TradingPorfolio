window.csrf = { csrf_token: '<?php echo $_SESSION["csrf_token"]; ?>' };
$.ajaxSetup({
    data: window.csrf
});

$(document).ready(function(){
    var $error = $('#error').val().trim();
    if($error != "") {
        alert($error);
    }
});