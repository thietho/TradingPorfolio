var $languages = JSON.parse('<?php echo json_encode($languages) ?>');

$(document).ready(function () {
    for (var $languageid in $languages) {
        if($languages.hasOwnProperty($languageid)) {
            setCKEditorType('summary' + $languageid, 0, '150px');
            setCKEditorType('description' + $languageid, 0, '500px');
            setCKEditorType('seo_content' + $languageid, 0, '150px');
            createSeo($languageid);
        }
    }

    /*
    var jInputDate = $('.input-date');
    jInputDate.datetimepicker({
        pickTime: false
    }).on("change.dp", function(e) {
        alert('aa');
    });
    */
    /*** http://stackoverflow.com/questions/22500662/bootstrap-3-datetimepicker-events-not-firing-up ***/
    $('.input-date').datetimepicker({
        pickTime: false
    });

});

function createSeo($languageid) {
    $("#title" + $languageid).on('change keyup paste', function () {
        var name = $(this).val();
        name = escapeUnicode(name);
        name = name.toLowerCase(); // lowercase
        name = name.replace(/^\s+|\s+$/g, ''); // remove leading and trailing whitespaces
        name = name.replace(/\s+/g, '-'); // convert (continuous) whitespaces to one -
        name = name.replace(/[^a-z0-9-]/g, ''); // remove everything that is not [a-z] or -
        $("#seourl" + $languageid).val(name);
    });
}

function tagItemClick(element, language) {
    var value_textbox;
    var jCurrentTag = $("#tag" + language);
    if (element.checked == true) {
        var currentTag = jCurrentTag.val();
        if (currentTag == "")
            value_textbox = element.value.trim() + ',';
        else {
            if (currentTag.slice(-1) != ",") {
                currentTag += ",";
            }
            value_textbox = currentTag + element.value.trim() + ',';
        }
        jCurrentTag.val(value_textbox);
    }
    else {
        value_textbox = jCurrentTag.val();
        var arr = value_textbox.split(',');
        for (var i = 0; i < arr.length; i++) {
            if (element.value.trim() == arr[i].trim()) {
                arr = jQuery.grep(arr, function (value) {
                    return value != arr[i]
                });
            }
        }
        jCurrentTag.val(arr);
    }
}


function save() {
    var jErrorMessage = $('.error-message');
    jErrorMessage.html('');
    jErrorMessage.hide();

    for (var x in $languages) {
        var pageValue;
        var summary = CKEDITOR.instances['summary' + x];
        pageValue = summary.getData();
        $('textarea#summary' + x).val(pageValue);

        var description = CKEDITOR.instances['description' + x];
        pageValue = description.getData();
        $('textarea#description' + x).val(pageValue);

        var seo_content = CKEDITOR.instances['seo_content' + x];
        pageValue = seo_content.getData();
        $('textarea#seo_content' + x).val(pageValue);
    }

    showloading();
    $.post("?route=module/news/save", $("#frmform").serialize(), function ($data) {
        endloading();

        var $response = JSON.parse($data);
        var $errors = $response['errors'];
        if ($response['status'] == 'failed') {
            var $error_panel = '<div class="alert alert-danger" role="alert">';
            $error_panel += '<a class="close" title="close" aria-label="close" data-dismiss="alert" href="#">×</a>';
            for (var $error_code in $errors) {
                if ($errors.hasOwnProperty($error_code)) {
                    $error_panel += '<p>-&nbsp;' + $errors[$error_code] + '</p>';
                }
            }
            $error_panel += '</div>';
            jErrorMessage.append($error_panel);
            jErrorMessage.show();

            $("html, body").animate({scrollTop: 0}, "fast");
            toastr.error('<div class="toast-title">' + $response['title'] + '</div><div class="toast-messsage">' + $response['message'] + '</div>');

        } else {
            toastr.success('<div class="toast-title">' + $response['title'] + '</div><div class="toast-messsage">' + $response['message'] + '</div>');

            var $mediaid = $('#mediaid').val();
            var $sitemapidold = $('#sitemapidold').val();
            var $sitemapid = $('#sitemapid').val();
            if ("" == $mediaid) {
                window.location.href = "?route=module/news&sitemapid=" + $sitemapid;

            } else {
                if ($sitemapid != $sitemapidold) {
                    window.location.href = $('#btnCancel').attr('href');
                }
            }

        }
    });
}



