var $languages = JSON.parse('<?php echo json_encode($languages) ?>');

//class SubImage
function SubImage() {
    this.index = 0;

    this.addImageSub = function ($path, $sortorder) {
        var $img = '<div class="image_item"><img src="images/resize-200x200/' + $path + '"/></div>';

        var $caption = '<div><label><?php echo $lang_text_gallery_title?></label></div>';
        for (var $languageid in $languages) {
            $caption += '<input type="hidden" name="gallery_image[' + $languageid + '][' + subImage.index + '][imagepath]"  value="' + $path + '" />';
            $caption += '<input type="text" class="form-control" placeholder="' + $languageid + '" name="gallery_image[' + $languageid + '][' + subImage.index + '][title]"  value="" />';
        }

        var $control = '<a class="btndeleteimage btn btn-danger" path="'+ $path +'"><i class="fa fa-remove"></i></a>';

        var row = '<div class="subimage-item col-md-4 col-sm-12">';
        row += '<div class="text-center">' + $img + $caption + '</div>';
        row += '<div class="subimage-item-control">' + $control + '</div>';
        row += '</div>';

        subImage.index++;
        return row;
    }

    this.addImageSubData = function ($data) {
        var $img = '<div class="image_item"><img src="images/resize-200x200/' + $data['imagepath'] + '"/></div>';

        var $caption = '<div><label><?php echo $lang_text_gallery_title?></label></div>';
        for (var $languageid in $languages) {
            $caption += '<input type="hidden" name="gallery_image[' + $languageid + '][' + subImage.index + '][imagepath]"  value="' + $data['imagepath'] + '" />';
            $caption += '<input type="text" class="form-control" placeholder="' + $languageid + '" name="gallery_image[' + $languageid + '][' + subImage.index + '][title]"  value="' + $data[$languageid] + '" />';
        }

        var $control = '<a class="btndeleteimage btn btn-danger" path="'+ $data['imagepath'] +'"><i class="fa fa-remove"></i></a>';

        var row = '<div class="subimage-item col-md-4 col-sm-12">';
        row += '<div class="text-center">' + $img + $caption + '</div>';
        row += '<div class="subimage-item-control">' + $control + '</div>';
        row += '</div>';

        subImage.index++;
        return row;
    }

}
var subImage = new SubImage();


$(document).ready(function () {
    for (var $languageid in $languages) {
        if ($languages.hasOwnProperty($languageid)) {
            setCKEditorType('summary' + $languageid, 0, '150px');
            setCKEditorType('description' + $languageid, 0, '500px');
            setCKEditorType('seo_content' + $languageid, 0, '150px');
            createSeo($languageid);
        }
    }


    var $subImageList = JSON.parse('<?php echo json_encode($subImageDataList)?>');
    for (var $key in $subImageList) {
        if ($subImageList.hasOwnProperty($key)) {
            $('#subImageList').append(subImage.addImageSubData($subImageList[$key]));
        }
    }


    $('#status-date-control').datetimepicker({
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
        name = name.replace(/[^a-z0-9-]/g, ''); // remove everything that is not [a-z] [0-9]or -
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
        $(function (arr) {
            for (var i = 0; i < arr.length; i++) {
                if (element.value.trim() == arr[i].trim()) {
                    $(function (i) {
                        arr = jQuery.grep(arr, function (value) {
                            return value != arr[i]
                        });
                    })(i);
                }
            }
            jCurrentTag.val(arr);
        })(arr);

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
    $.post("?route=module/gallery/save", $("#frmform").serialize(), function ($data) {
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
                window.location.href = "?route=module/gallery&sitemapid=" + $sitemapid;

            } else {
                if ($sitemapid != $sitemapidold) {
                    window.location.href = $('#btnCancel').attr('href');
                }
            }

        }
    });
}

//add subimage
//function addSubImage() {
//    elifeupload_multi('subimage', 'subImageList');
//}

//delete subimage
$('.btndeleteimage').live('click', function () {
    var width = $(window).width();
    if(width > 1024) {
        $(this).parent().parent().remove();
    } else {
        if(confirm("<?php echo $lang_text_confirm_delete ?>")) {
            var $owner = $(this);
            var url = "<?php echo IMAGE_SERVER ?>file_<?php echo SKINID ?>/file/quickupload.php?file=";
            var path = $(this).attr('path');

            var pieces = path.split("/");
            var filename = pieces[pieces.length-1];
            var url_remove = url + filename;
            showloading();
            $.ajax({
                url: url_remove,
                type: 'DELETE',
                success: function(result) {
                    endloading();
                    var response = JSON.parse(result);
                    if(response[filename] == true) {
                        $owner.parent().parent().remove();
                    }
                },
                fail: function() {
                    endloading();
                }
            });
        }
    }
});
//----------------------------------------------------------------------------------------------------------------------



