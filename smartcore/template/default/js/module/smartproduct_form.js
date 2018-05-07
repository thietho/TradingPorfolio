var $languages = JSON.parse('<?php echo json_encode($languages) ?>');
var $product_images = JSON.parse('<?php echo json_encode($product_images) ?>');
var $product_colors = JSON.parse('<?php echo json_encode($product_colors) ?>');
var $dataExtend = [];

$(document).ready(function () {
    for (var $languageid in $languages) {
        setCKEditorType('summary' + $languageid, 0, '150px');
        setCKEditorType('description' + $languageid, 0, '500px');
        setCKEditorType('seo_content' + $languageid, 0, '150px');
    }

    $(".currency").inputmask();

    createSeo();

    //add subimages
    var $colorKey;
    var $colorName;
    refresh_color();
    if ($product_images.length > 0) {
        for (var $index in $product_images) {
            if ($product_images.hasOwnProperty($index)) {
                $colorName = $product_images[$index]['color'];
                $colorKey = $colorName.toLowerCase().replace(" ", "-");
                var $object = { "color": $colorName };
                $dataExtend[$colorKey] = {};
                $dataExtend[$colorKey] = $object;
                $('#subImageList-' + $colorKey).append(subImageExtend.addImageSubExtend($product_images[$index]['image'], $product_images[$index]['sortorder'], $dataExtend[$colorKey]));

            }
        }
    }

    if ($product_colors.length > 0) {
        for (var $iColor in $product_colors) {
            if ($product_colors.hasOwnProperty($iColor)) {
                $colorName = $product_colors[$iColor]['color'];
                $colorKey = $colorName.toLowerCase().replace(" ", "-");

                console.log($product_colors[$iColor]['image']);

                $("#avatar-"+ $colorKey +"-imagepath").val($product_colors[$iColor]['image']);
                var $imgcontent = "";
                if($product_colors[$iColor]['image'] == "") {
                    $('#color-avatar-' + $colorKey).html('<img height="64" id="avatar-'+ $colorKey +'-imagepreview" imagetype="images/autosize-0x64" src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" />');

                    $imgcontent = '<img id="avatar-'+ $colorKey +'-qu-imagepreview" imagepath="images/autosize-0x64/upload/" src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==">';
                    $imgcontent += '<img id="avatar-'+ $colorKey +'-qu-imagewaiting" class="elife-hidden" width="50" height="50" src="<?php echo DIR_IMAGE ?>loading.gif" />';
                    $('#color-avatar-' + $colorKey + "-mobile").html($imgcontent);
                } else {
                    $('#color-avatar-' + $colorKey).html('<img height="64" id="avatar-'+ $colorKey +'-imagepreview" imagetype="images/autosize-0x64" src="images/autosize-0x64/'+ $product_colors[$iColor]['image'] +'" />');

                    $imgcontent = '<img id="avatar-'+ $colorKey +'-qu-imagepreview" imagepath="images/autosize-0x64/upload/" src="images/autosize-0x64/'+ $product_colors[$iColor]['image'] +'">';
                    $imgcontent += '<img id="avatar-'+ $colorKey +'-qu-imagewaiting" class="elife-hidden" width="50" height="50" src="<?php echo DIR_IMAGE ?>loading.gif" />';
                    $('#color-avatar-' + $colorKey + "-mobile").html($imgcontent);
                }

            }
        }
    }






    $('#color-list').change(function(){
        var colorValue = $(this).val();

        $(".product-image-color-list").removeClass("active");
        $("div[color='" + colorValue + "']").addClass("active");

        $(".product-image-color-avatar").removeClass("active");
        $("div[colorkey='" + colorValue + "']").addClass("active");
    });
});


function createSeo() {
    for (var $languageid in $languages) {
        var jSeoURL = $("#seo_url_" + $languageid);
        if (jSeoURL.val().trim().length == 0) {
            $("#product_name_" + $languageid).on('change keyup paste', function () {
                var name = $(this).val();
                var $language_id = $(this).attr('rel');
                var jSeoURL = $("#seo_url_" + $language_id);
                name = escapeUnicode(name);
                name = name.toLowerCase(); // lowercase
                name = name.replace(/^\s+|\s+$/g, ''); // remove leading and trailing whitespaces
                name = name.replace(/\s+/g, '-'); // convert (continuous) whitespaces to one -
                name = name.replace(/[^a-z0-9-]/g, ''); // remove everything that is not [a-z] or -
                jSeoURL.val(name);
            });
        }
    }
}


//----------------------------------------------------------------------------------------------------------------------
//class SubImage
function SubImage() {
    this.index = 0;

    this.addImageSub = function (path, sortorder) {
        var img = "<div class='image_item'><img src='images/resize-200x200/" + path + "'/><input type='hidden' name='product_image[" + subImage.index + "][image]'  value='" + path + "' /><input type='hidden' name='product_image[" + subImage.index + "][sortorder]'  value='" + sortorder + "' /></div>";
        var control = '<a class="btndeleteimage btn btn-danger" path="'+ path +'"><i class="fa fa-remove"></i></a>';

        var row = '<div class="subimage-item col-md-4 col-sm-12">';
        row += '<div class="text-center">' + img + '</div>';
        row += '<div class="subimage-item-control">' + control + '</div>';
        row += '</div>';

        subImage.index++;
        return row;
    }

}
var subImage = new SubImage();



//class SubImage
function SubImageExtend() {
    this.index = 0;

    this.addImageSubExtend = function (path, sortorder, data) {
        var img = "<div class='image_item'><img src='images/resize-200x200/" + path + "'/>";
        img += "<input type='hidden' name='product_image[" + subImageExtend.index + "][image]'  value='" + path + "' />";
        img += "<input type='hidden' name='product_image[" + subImageExtend.index + "][sortorder]'  value='" + sortorder + "' />";
        img += "<input type='hidden' name='product_image[" + subImageExtend.index + "][color]'  value='" + data['color'] + "' />";
        img += "</div>";
        var control = '<a class="btndeleteimage btn btn-danger" path="'+ path +'"><i class="fa fa-remove"></i></a>';

        var row = '<div class="subimage-item col-md-4 col-sm-12">';
        row += '<div class="text-center">' + img + '</div>';
        row += '<div class="subimage-item-control">' + control + '</div>';
        row += '</div>';

        subImageExtend.index++;
        return row;
    }

}
var subImageExtend = new SubImageExtend();



//----------------------------------- delete subimage -----------------------------------
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
    $.post("?route=module/smartproduct/save", $("#frmform").serialize(), function ($data) {
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

            var $productid = $('#productid').val().trim();
            var $sitemapidold = $('#sitemapidold').val();
            var $sitemapid = $('#sitemapid').val();
            if ($productid == "") {
                window.location.href = "?route=module/smartproduct/&sitemapid=" + $sitemapid + "&page=1";
            } else {
                if ($sitemapid != $sitemapidold) {
                    window.location.href = $('#btnCancel').attr('href');
                } else {
                    var $modelold = $('#modelold').val();
                    var $model = $('#model').val();
                    if ($modelold != $model) {
                        window.location.href = $('#btnCancel').attr('href');
                    }
                }
            }

        }
    });

}



function refresh_color() {
    showloading();

    $dataExtend = [];
    var jColorProductPanel = $('.color-product-panel');
    var jColorProductAvatarPanel = $('.color-product-avatar-panel');
    var jColorList = $('#color-list');


    var $arrColor = [];
    var $arrColorKey = [];
    var $color = $("#color").val().trim();
    if($color.length > 0) {
        $arrColor = $.map($color.split(","), $.trim);
        for(var $j = 0; $j < $arrColor.length; $j++) {
            $arrColorKey[$j] = $arrColor[$j].toLowerCase().replace(" ", "-");
        }
    }


    $('.product-image-color-list').each(function(){
        $(this).removeClass("active");
        var $color = $(this).attr('color');
        if($.inArray($color, $arrColorKey) < 0) {
            $('div[color="' + $color + '"]').remove();
            $('div[colorkey="' + $color + '"]').remove();
        }
    });


    var sizeColor = $arrColor.length;
    if(sizeColor > 0) {
        jColorList.html("");
        for(var $i = 0; $i < sizeColor; $i++) {
            var $colorName = $arrColor[$i];
            var colorKey = $arrColor[$i].replace(" ", "-").toLowerCase();
            jColorList.append('<option value="'+ colorKey +'">'+ $colorName +'</option>');


            if($('div[color="' + colorKey + '"]').length == 0) {
                var $object = { color: $colorName };
                $dataExtend[colorKey] = {};
                $dataExtend[colorKey] = JSON.stringify($object);

                var $html = "";
                $html += '<div class="product-image-color-list" color="'+ colorKey +'" class="row">';
                $html += '<div class="qu-imagepreview-thumb">';
                $html += '<a class="btn btn-default" onclick="elifeupload_multi_extend(\'subimage-'+ colorKey +'\', \'subImageList-'+ colorKey +'\',' + '$dataExtend[\''+ colorKey +'\']' + ')"><i class="fa fa-plus"></i>&nbsp;<?php echo $lang_text_product_select_image ?></a>';
                $html += '</div>';

                $html += '<div class="qu-imagepreview-thumb mobile">';
                $html += '<a class="btn btn-default" onclick="quickupload_multi_extend(\'<?php echo SKINID?>\', \'subimage-qu-fileupload-'+ colorKey +'\', \'subImageList-'+ colorKey +'\',' + '$dataExtend[\''+ colorKey +'\']' + ')"><i class="fa fa-plus"></i>&nbsp;<?php echo $lang_text_product_select_image ?></a>';
                $html += '<input id="subimage-qu-fileupload-'+ colorKey +'" type="file" style="display:none" name="files[]" data-url="<?php echo IMAGE_SERVER ?>file_<?php echo SKINID ?>/file/quickupload.php" accept="image/*; capture=camera" multiple>';
                $html += '</div>';

                $html += '<div id="subImageList-'+ colorKey +'" class="row"></div>';
                $html += '</div>';

                jColorProductPanel.append($html);
            }


            if($('div[colorkey="' + colorKey + '"]').length == 0) {

                var $content = "";
                $content += '<div class="product-image-color-avatar" colorkey="'+ colorKey +'" class="row">';
                $content += '<input id="avatar-'+ colorKey +'-imagepath" type="hidden" name="product_color_avatar['+ $colorName +']" value="" />';
                $content += '<div class="qu-imagepreview-thumb">';
                $content += '<p>';
                $content += '<a class="btn btn-primary btn-equal" onclick="elifeupload_one(\'avatar-'+ colorKey +'-imagepath\', \'avatar-'+ colorKey +'-imagepreview\')">';
                $content += '<i class="fa fa-pencil" aria-hidden="true"></i>';
                $content += '</a>&nbsp;';
                $content += '<a class="btn btn-danger btn-equal" onclick="elifeupload_unselectimage(\'avatar-'+ colorKey +'-imagepath\', \'avatar-'+ colorKey +'-imagepreview\')">';
                $content += '<i class="fa fa-refresh" aria-hidden="true"></i>';
                $content += '</a>';
                $content += '</p>';
                $content += '<p id="color-avatar-'+ colorKey +'">';
                $content += '<img height="64" id="avatar-'+ colorKey +'-imagepreview" imagetype="images/autosize-0x64" src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" />'
                $content += '</p>';
                $content += '</div>';


                $content += '<div class="qu-imagepreview-thumb mobile">';
                $content += '<p>';
                $content += '<a class="btn btn-primary btn-equal" onclick="quickupload_one(\'<?php echo SKINID ?>\', \'avatar-'+ colorKey +'\')">';
                $content += '<i class="fa fa-pencil" aria-hidden="true"></i>';
                $content += '</a>&nbsp;';
                $content += '<a class="btn btn-danger btn-equal" onclick="quickupload_one_remove(\'<?php echo IMAGE_SERVER ?>file_<?php echo SKINID ?>/file/quickupload.php?file=\', \'avatar-'+ colorKey +'\')">';
                $content += '<i class="fa fa-trash" aria-hidden="true"></i>';
                $content += '</a>';
                $content += '</p>';


                $content += '<input id="avatar-'+ colorKey +'-qu-oldimagepath" type="hidden" imageupload="" value="images/autosize-0x64/">';
                $content += '<input id="avatar-'+ colorKey +'-qu-fileupload" type="file" style="display:none" name="files[]" data-url="<?php echo IMAGE_SERVER ?>file_<?php echo SKINID ?>/file/quickupload.php" accept="image/*; capture=camera">';
                $content += '<p id="color-avatar-'+ colorKey +'-mobile">';
                $content += '<img id="avatar-'+ colorKey +'-qu-imagepreview" imagepath="images/autosize-0x64/upload/" src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==">';
                $content += '<img id="avatar-'+ colorKey +'-qu-imagewaiting" class="elife-hidden" width="50" height="50" src="<?php echo DIR_IMAGE ?>loading.gif" />';
                $content += '</p>';
                $content += '</div>';
                $content += '</div>';

                jColorProductAvatarPanel.append($content);
            }

            if($i == 0) {
                $('div[color="' + colorKey + '"]').addClass('active');
                $('div[colorkey="' + colorKey + '"]').addClass('active');
            }

        }




    }

    endloading();
}


function refresh_color_productprice($controlname) {
    var $control = $('input[name="'+ $controlname +'"]');
    var $arrColor;
    var $color = $("#color").val().trim();
    $control.html('');

    if($color.length > 0) {
        $arrColor = $.map($color.split(","), $.trim);

        $control.append('<option value="">--</option>');
        for(var $i = 0; $i < $arrColor.length; $i++) {
            $control.append('<option value="'+ $arrColor[$i] +'">'+ $arrColor[$i] +'</option>');
        }
    }
}

function refresh_size_productprice($controlname) {
    var $control = $('input[name="'+ $controlname +'"]');
    var $arrSize;
    var $size = $("#size").val().trim();
    $control.html('');

    if($size.length > 0) {
        $arrSize = $.map($size.split(","), $.trim);

        $control.append('<option value="">--</option>');
        for(var $i = 0; $i < $arrSize.length; $i++) {
            $control.append('<option value="'+ $arrSize[$i] +'">'+ $arrSize[$i] +'</option>');
        }
    }
}

function deletePrice(owner) {
    $(owner).parent().parent().remove();
}




//class ProductPrice
function ProductPrice()
{
    this.index = 0;
    this.addItem = function() {

        var $iColor, $iSize;

        var $arrColor;
        var $color = $("#color").val().trim();
        if($color.length > 0) {
            $arrColor = $.map($color.split(","), $.trim);
        }

        var $arrSize;
        var $size = $("#size").val().trim();
        if($size.length > 0) {
            $arrSize = $.map($size.split(","), $.trim);
        }


        var $tr = '<tr>';
        $tr += '<td class="v-middle">';
        $tr += '<select name="product_price['+ productPrice.index +'][color]" class="product-price-color form-control control-width-medium">';
        $tr += '<option value="">--</option>';
        for($iColor = 0; $iColor < $arrColor.length; $iColor++) {
            $tr += '<option value="'+ $arrColor[$iColor] +'">'+ $arrColor[$iColor] +'</option>';
        }
        $tr += '</select>';
        $tr += '</td>';

        $tr += '<td class="v-middle">';
        $tr += '<select name="product_price['+ productPrice.index +'][size]" class="product-price-size form-control control-width-medium">';
        $tr += '<option value="">--</option>';
        for($iSize = 0; $iSize < $arrSize.length; $iSize++) {
            $tr += '<option value="'+ $arrSize[$iSize] +'">'+ $arrSize[$iSize] +'</option>';
        }
        $tr += '</select>';
        $tr += '</td>';

        $tr += '<td class="v-middle">';
        $tr += '<input name="product_price['+ productPrice.index +'][price]" type="text" class="form-control control-width-medium text-right currency" data-inputmask="\'alias\': \'numeric\', \'groupSeparator\': \',\', \'autoGroup\': true, \'digits\': 2, \'digitsOptional\': false, \'prefix\': \'\', \'placeholder\': \'0\'" value="0" />';
        $tr += '</td>';

        $tr += '<td class="v-middle">';
        $tr += '<input name="product_price['+ productPrice.index +'][saleoff]" type="text" class="form-control control-width-medium text-right currency" data-inputmask="\'alias\': \'numeric\', \'groupSeparator\': \',\', \'autoGroup\': true, \'digits\': 2, \'digitsOptional\': false, \'prefix\': \'\', \'placeholder\': \'0\'" value="0" />';
        $tr += '</td>';

        $tr += '<td class="v-middle">';
        $tr += '<a class="btn btn-default" onclick="deletePrice(this)" ><?php echo $lang_text_delete ?></a>';
        $tr += '</td>';
        $tr += '</tr>';


        productPrice.index++;
        $('#product-price-list').append($tr);

        $(".currency").inputmask();
    }
}
var productPrice = new ProductPrice();
productPrice.index = $countProductPrice;


function addItemPrice() {
    productPrice.addItem();
}




function refreshColorItemPrice() {
    var $iColor;
    var $arrColor;
    var $color = $("#color").val().trim();
    if($color.length > 0) {
        $arrColor = $.map($color.split(","), $.trim);
    }

    $('.product-price-color').each(function(){
        var selectedValue = $(this).val();
        $(this).html('');

        $(this).append('<option value="">--</option>');
        for($iColor = 0; $iColor < $arrColor.length; $iColor++) {
            $(this).append('<option value="'+ $arrColor[$iColor] +'">'+ $arrColor[$iColor] +'</option>');
        }

        $(this).val(selectedValue);
    });

}

function refreshSizeItemPrice() {
    var $iSize;
    var $arrSize;
    var $size = $("#size").val().trim();
    if($size.length > 0) {
        $arrSize = $.map($size.split(","), $.trim);
    }

    $('.product-price-size').each(function(){
        var selectedValue = $(this).val();
        $(this).html('');

        $(this).append('<option value="">--</option>');
        for($iSize = 0; $iSize < $arrSize.length; $iSize++) {
            $(this).append('<option value="'+ $arrSize[$iSize] +'">'+ $arrSize[$iSize] +'</option>');
        }

        $(this).val(selectedValue);
    });
}