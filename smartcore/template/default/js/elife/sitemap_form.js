$(document).ready(function () {
    $("input[id*=sitemapname_]").on('change keyup paste', function () {
        var lang = $(this).attr("rel");
        if ($("#old_seo_url_" + lang).val() != '') {
            return;
        }
        var name = $(this).val();
        name = escapeUnicode(name);
        name = name.toLowerCase(); // lowercase
        name = name.replace(/^\s+|\s+$/g, ''); // remove leading and trailing whitespaces
        name = name.replace(/\s+/g, '-'); // convert (continuous) whitespaces to one -
        name = name.replace(/[^a-z0-9-]/g, ''); // remove everything that is not [a-z] or -
        $("#seo_url_" + lang).val(name);
    });

});


function save() {
    var sitemapid = $('#sitempaid').val();
    var jErrorMessage = $('.error-message');
    showloading();
    $.post("?route=elife/sitemap/save", $("#frmSiteMap").serialize(), function ($data) {
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
            jErrorMessage.html('');
            jErrorMessage.hide();

            toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');
            console.log(sitemapid);
            if(sitemapid == '') {
                window.location.href = '?route=elife/sitemap';
            } else {
                endloading();
            }
        }

    });
}