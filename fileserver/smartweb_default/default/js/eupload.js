/*---START CAC HAM DANH CHO UPLOAD-----------------------------------------------------*/
function elifeupload_unselectfile(controlid) {
    $('#' + controlid).val('');
}

function elifeupload_unselectimage(controlid, previewid) {
    $('#' + controlid).val("");
    $('#' + previewid).attr("src", " data:image/png;base64,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");
}

function elifeupload_unselectfile_preview(controlid, previewid) {
    $('#' + controlid).val('');
    var jPreview = $('#' + previewid);
    jPreview.attr('src', '');
    jPreview.html('src', '');
}

function elifeupload_multi(controlid, previewid) {
    openSmartUpload_multi(controlid, previewid);
}

function elifeupload_multi_extend(controlid, previewid, data) {
    //console.log(data['color']);
    //console.log(data['size']);
    openSmartUpload_multi_extend(controlid, previewid, data);
}

function elifeupload_one(controlid, previewid) {
    openSmartUpload_one(controlid, previewid);
}

function elifeupload_editor(controlid) {
    openSmartUpload_editor(controlid);
}

function elifeupload_onefile(controlid, previewid) {
    openSmartUpload_onefile(controlid, previewid);
}

$('.elife-upload-panel-link').fancybox({
    'transitionIn': 'elastic',
    'transitionOut': 'elastic',
    'easingIn': 'swing',
    'easingOut': 'swing',
    'mouseWheel': false,
    'scrolling': false,
    'speedIn': 600,
    'speedOut': 200,
    'overlayShow': true,
    'padding': 0,
    'overlayColor': '#aa000000',
    'width':  1000,
    'height': 600,
    beforeShow: function() {

    },
    afterShow: function() {
        var serverurl = $('#urlserverupload').val();
        var url = serverurl + "&getfolder=true";

        var jFolderList = $('#folder-list');
        if(jFolderList.html().trim() == "") {
            $('.loading-folder').show();
            $.post(url, null, function(data){
                $('.loading-folder').hide();
                if(data != "") {
                    jFolderList.append('<li id="eupload_upload"><a class="active" onclick=openFolder("upload")>upload</a></li>');
                    var folders = JSON.parse(data);
                    var lenFolder = folders.length;
                    for(var $i = 0; $i < lenFolder; $i++) {
                        $('#folder-list').append('<li id="eupload_'+ folders[$i] +'"><a onclick=openFolder("'+ folders[$i] +'")>'+ folders[$i] +'</a><a class="delete-folder" onclick=removeFolderUpload("'+ folders[$i] +'")></a></li>');
                    }
                }
            })
        }

        //open default folder upload
        var urlOpenUpload = $('#urlserverfolder').val() + "&folder_upload_name=upload&folder_thumb_name=thumbnails";
        $('#tree').attr('src', urlOpenUpload);
        $('#groupname-current').html("Upload");

        $('#folder-list li a').removeClass('active');
        $('#eupload_upload a').addClass('active');
    }
});



function openSmartUpload_multi(controlid, previewid) {
    var jCpanelSmartuploadSelect = $('#cpanel-smartupload-select');
    var domain = $('#accept-domain').val();
    if(domain != "") {
        jCpanelSmartuploadSelect.hide();
        jCpanelSmartuploadSelect.attr("controlid", controlid);
        jCpanelSmartuploadSelect.attr("previewid", previewid);
        jCpanelSmartuploadSelect.attr("method", "openSmartUpload_multi");
    } else {
        $('iframe[name=tree]').contents().find('#smartupload_select_files').val("");
        jCpanelSmartuploadSelect.attr("onclick", "smartupload_multi('"+ controlid +"', '"+ previewid +"')");
    }

    $('.elife-upload-panel-link').trigger('click');
}

function openSmartUpload_multi_extend(controlid, previewid, data) {
    var jCpanelSmartuploadSelect = $('#cpanel-smartupload-select');
    var domain = $('#accept-domain').val();
    if(domain != "") {
        jCpanelSmartuploadSelect.hide();
        jCpanelSmartuploadSelect.attr("controlid", controlid);
        jCpanelSmartuploadSelect.attr("previewid", previewid);
        jCpanelSmartuploadSelect.attr("method", "openSmartUpload_multi");
    } else {
        console.log(data);
        console.log("smartupload_multi_extend('"+ controlid +"', '"+ previewid +"', "+ JSON.stringify(data) +")");
        $('iframe[name=tree]').contents().find('#smartupload_select_files').val("");
        jCpanelSmartuploadSelect.attr("onclick", "smartupload_multi_extend('"+ controlid +"', '"+ previewid +"', "+ JSON.stringify(data) +")");
    }

    $('.elife-upload-panel-link').trigger('click');
}


function openSmartUpload_one(controlid, previewid) {
    var jCpanelSmartuploadSelect = $('#cpanel-smartupload-select');
    var domain = $('#accept-domain').val();
    if(domain != "") {
        jCpanelSmartuploadSelect.hide();
        jCpanelSmartuploadSelect.attr("controlid", controlid);
        jCpanelSmartuploadSelect.attr("previewid", previewid);
        jCpanelSmartuploadSelect.attr("method", "openSmartUpload_one");
    } else {
        $('iframe[name=tree]').contents().find('#smartupload_select_files').val("");
        jCpanelSmartuploadSelect.attr("onclick", "smartupload_one('"+ controlid +"', '"+ previewid +"')");
    }

    $('.elife-upload-panel-link').trigger('click');
}

function openSmartUpload_editor(controlid) {
    var jCpanelSmartuploadSelect = $('#cpanel-smartupload-select');
    var domain = $('#accept-domain').val();
    if(domain != "") {
        jCpanelSmartuploadSelect.hide();
        jCpanelSmartuploadSelect.attr("controlid", controlid);
        jCpanelSmartuploadSelect.attr("method", "openSmartUpload_editor");
    } else {
        $('iframe[name=tree]').contents().find('#smartupload_select_files').val("");
        jCpanelSmartuploadSelect.attr("onclick", "smartupload_editor('"+ controlid +"')");
    }

    $('.elife-upload-panel-link').trigger('click');
}

function openSmartUpload_onefile(controlid, previewid) {

    var jCpanelSmartuploadSelect = $('#cpanel-smartupload-select');
    var domain = $('#accept-domain').val();
    if(domain != "") {
        jCpanelSmartuploadSelect.hide();
        jCpanelSmartuploadSelect.attr("controlid", controlid);
        jCpanelSmartuploadSelect.attr("previewid", previewid);
        jCpanelSmartuploadSelect.attr("method", "openSmartUpload_onefile");
    } else {
        $('iframe[name=tree]').contents().find('#smartupload_select_files').val("");
        jCpanelSmartuploadSelect.attr("onclick", "smartupload_onefile('"+ controlid +"', '"+ previewid +"')");
    }

    $('.elife-upload-panel-link').trigger('click');
}


function smartupload_multi(controlid, previewid) {
    var iframe = $('iframe[name=tree]');
    iframe.contents().find('#smartupload-select-button').trigger("click");
    var strResult = iframe.contents().find('#smartupload_select_files').val();
    var result = strResult.split(",");

    var str = "";
    if (controlid != "") {
        for (var i = 0; i < result.length; i++) {
            if(result[i].length > 0) {
                str += result[i] + ",";
            }
        }
        $("#" + controlid).val(str);
    }
    if (result.length > 0) {
        UPLOAD_FILE_LIST = result;
        UPLOAD_FILE_ITEM = result[0];
    }

    for(var i in result){
        if(result[i] != ""){
            $('#' + previewid).append(subImage.addImageSub(result[i], 1));
        }
    }


    $.fancybox.close();
    return str;
}


function smartupload_multi_extend(controlid, previewid, data) {
    var iframe = $('iframe[name=tree]');
    iframe.contents().find('#smartupload-select-button').trigger("click");
    var strResult = iframe.contents().find('#smartupload_select_files').val();
    var result = strResult.split(",");

    var str = "";
    if (controlid != "") {
        for (var i = 0; i < result.length; i++) {
            if(result[i].length > 0) {
                str += result[i] + ",";
            }
        }
        $("#" + controlid).val(str);
    }
    if (result.length > 0) {
        UPLOAD_FILE_LIST = result;
        UPLOAD_FILE_ITEM = result[0];
    }

    for(var i in result){
        if(result[i] != ""){
            if(typeof data === 'string') {
                $('#' + previewid).append(subImageExtend.addImageSubExtend(result[i], 1, JSON.parse(data)));
            } else {
                $('#' + previewid).append(subImageExtend.addImageSubExtend(result[i], 1, data));
            }

        }
    }


    $.fancybox.close();
    return str;
}

function smartupload_one(controlid, previewid) {
    var iframe = $('iframe[name=tree]');
    iframe.contents().find('#smartupload-select-button').trigger("click");
    var strResult = iframe.contents().find('#smartupload_select_files').val();
    var result = strResult.split(",");

    if (result.length > 0) {
        if(result[0].length > 0) {
            UPLOAD_FILE_LIST = result;
            UPLOAD_FILE_ITEM = result[0];
            $("#" + controlid).val(result[0]);
            if (previewid != "") {
                var button = $("#" + previewid);
                if (button.attr("imagetype")) {
                    var imagepath = button.attr("imagetype") + "/" + result[0];
                    button.attr("src", imagepath);
                }
                else {
                    button.html(result[0]);
                }
            }
            $.fancybox.close();
            return result[0];
        } else {
            $.fancybox.close();
            return "";
        }
    } else {
        $.fancybox.close();
        return "";
    }
}

function smartupload_editor(controlid) {
    var iframe = $('iframe[name=tree]');
    iframe.contents().find('#smartupload-select-button').trigger("click");
    var strResult = iframe.contents().find('#smartupload_select_files').val();
    var result = strResult.trim().split(",");

    var str = "";
    if (controlid != "" && result.length > 0) {
        var oEditor = CKEDITOR.instances[controlid];
        if (oEditor.mode == 'wysiwyg') {
            for (var i = 0; i < result.length; i++) {
                if(result[i].length > 0) {
                    str += '<img alt="" width=auto height=auto src="images/autosize-700x0/' + result[i] + '"/>';
                }
            }
            oEditor.insertHtml(str);
            var temp = oEditor.getData()
            oEditor.setData(temp);
        }
        else {
            alert('You must be on WYSIWYG mode!');
        }
    }
    if (result.length > 0) {
        UPLOAD_FILE_LIST = result;
        UPLOAD_FILE_ITEM = result[0];
    }
    $.fancybox.close();
    return str;
}

function smartupload_onefile(controlid, previewid) {
    var iframe = $('iframe[name=tree]');
    iframe.contents().find('#smartupload-select-button').trigger("click");
    var strResult = iframe.contents().find('#smartupload_select_files').val();
    var result = strResult.split(",");

    if (result.length > 0) {
        if(result[0].length > 0) {
            UPLOAD_FILE_LIST = result;
            UPLOAD_FILE_ITEM = result[0];
            $("#" + controlid).val(result[0]);
            if (previewid != "") {
                var button = $("#" + previewid);
                var imagepath = result[0];
                button.html(imagepath);
            }
            $.fancybox.close();
            return result[0];
        } else {
            $.fancybox.close();
            return "";
        }
    } else {
        $.fancybox.close();
        return "";
    }
}


//process for cross domain upload
function smartupload_multi_messagepost(controlid, previewid, strImageSelect) {
    if(strImageSelect == "") {
        return "";
    }

    var result = strImageSelect.split(",");
    var str = "";
    if (controlid != "") {
        for (var i = 0; i < result.length; i++) {
            if(result[i].length > 0) {
                str += result[i] + ",";
            }
        }
        $("#" + controlid).val(str);
    }
    if (result.length > 0) {
        UPLOAD_FILE_LIST = result;
        UPLOAD_FILE_ITEM = result[0];
    }

    for(var i in result){
        if(result[i] != ""){
            $('#' + previewid).append(subImage.addImageSub(result[i], 1));
        }
    }


    $.fancybox.close();
    return str;
}

function smartupload_one_messagepost(controlid, previewid, strImageSelect) {
    if(strImageSelect == "") {
        return "";
    }

    var result = strImageSelect.split(",");
    if (result.length > 0) {
        if(result[0].length > 0) {
            UPLOAD_FILE_LIST = result;
            UPLOAD_FILE_ITEM = result[0];
            $("#" + controlid).val(result[0]);
            if (previewid != "") {
                var button = $("#" + previewid);
                if (button.attr("imagetype")) {
                    var imagepath = button.attr("imagetype") + "/" + result[0];
                    button.attr("src", imagepath);
                }
                else {
                    button.html(result[0]);
                }
            }
            $.fancybox.close();
            return result[0];
        } else {
            $.fancybox.close();
            return "";
        }
    } else {
        $.fancybox.close();
        return "";
    }
}

function smartupload_editor_messagepost(controlid, strImageSelect) {
    if(strImageSelect == "") {
        return "";
    }

    var result = strImageSelect.split(",");
    var str = "";
    if (controlid != "" && result.length > 0) {
        var oEditor = CKEDITOR.instances[controlid];
        if (oEditor.mode == 'wysiwyg') {
            for (var i = 0; i < result.length; i++) {
                if(result[i].length > 0) {
                    str += '<img alt="" width=auto height=auto src="images/autosize-700x0/' + result[i] + '"/>';
                }
            }
            oEditor.insertHtml(str);
            var temp = oEditor.getData()
            oEditor.setData(temp);
        }
        else {
            alert('You must be on WYSIWYG mode!');
        }
    }
    if (result.length > 0) {
        UPLOAD_FILE_LIST = result;
        UPLOAD_FILE_ITEM = result[0];
    }
    $.fancybox.close();
    return str;
}

function smartupload_onefile_messagepost(controlid, previewid, strImageSelect) {
    if(strImageSelect == "") {
        return "";
    }

    var result = strImageSelect.split(",");

    if (result.length > 0) {
        if(result[0].length > 0) {
            UPLOAD_FILE_LIST = result;
            UPLOAD_FILE_ITEM = result[0];
            $("#" + controlid).val(result[0]);
            if (previewid != "") {
                var button = $("#" + previewid);
                var imagepath = result[0];
                button.html(imagepath);
            }
            $.fancybox.close();
            return result[0];
        } else {
            $.fancybox.close();
            return "";
        }
    } else {
        $.fancybox.close();
        return "";
    }
}






function addFolderUpload() {
    var jGroupName = $('#smartupload-groupname');
    var foldername = jGroupName.val().trim();
    if (foldername.length == 0 || foldername.search(/[^a-z0-9\\s]/g) > 0) {
        alert("Group name just include a-z or number, not include whitespace");
    } else {
        var serverurl = $("#urlserverupload").val();
        var url = serverurl + "&addfolder=" + encodeURIComponent(foldername);
        $('.loading-folder').show();
        $.post(url, null, function(data){
            $('.loading-folder').hide();
            if(data == "true") {
                jGroupName.val("");
                $('#folder-list').append('<li id="eupload_'+ foldername +'"><a onclick=openFolder("'+ foldername +'")>'+ foldername +'</a><a class="delete-folder" onclick=removeFolderUpload("'+ foldername +'")></a></li>');
            } else {
                alert(data);
            }
        })
    }
}

function removeFolderUpload(foldername) {

    if(confirm("Bạn có muốn xóa thư mục này không?")) {
        $('.loading-folder').show();
        var serverurl = $("#urlserverupload").val();
        var url = serverurl + "&removefolder=" + encodeURIComponent(foldername);
        $.post(url, null, function(data){
            $('.loading-folder').hide();
            if(data == "true") {
                if($('#eupload_' + foldername + ' a').hasClass('active')) {
                    var urlOpenUpload = $('#urlserverfolder').val() + "&folder_upload_name=upload&folder_thumb_name=thumbnails";
                    $('#tree').attr('src', urlOpenUpload);
                    $('#groupname-current').html("Upload");
                }
                $('#eupload_' + foldername).remove();
            } else {
                alert(data);
            }
        });
    }
}

function openFolder(foldername) {
    //&folder_upload_name=upload&folder_thumb_name=thumbnails
    var serverurl = $("#urlserverfolder").val();
    var url = serverurl + "&folder_upload_name=eupload_"+ foldername +"&folder_thumb_name=ethumb_" + foldername;
    if(foldername == 'upload') {
        url = serverurl + "&folder_upload_name="+ foldername +"&folder_thumb_name=thumbnails";
    }
    $('#folder-list li a').removeClass('active');
    $('#eupload_' + foldername + ' a').addClass('active');
    $('#tree').attr('src', url);
    $('#groupname-current').html(foldername);
}


///listen iframe upload send selectimage to parent window
window.addEventListener('message', receiveMessage, false);
function receiveMessage(evt)
{
    var domain = $('#accept-domain').val();
    if (domain != "" && evt.origin == domain)
    {
        var strImageSelect = evt.data + "";
        var jCpanelSmartuploadSelect = $('#cpanel-smartupload-select');
        var controlid = jCpanelSmartuploadSelect.attr('controlid');
        var previewid = jCpanelSmartuploadSelect.attr('previewid');
        var method = jCpanelSmartuploadSelect.attr('method');

        if(method == "openSmartUpload_multi") {
            smartupload_multi_messagepost(controlid, previewid, strImageSelect);
        } else if (method == "openSmartUpload_one") {
            smartupload_one_messagepost(controlid, previewid, strImageSelect);
        } else if (method == "openSmartUpload_editor") {
            smartupload_editor_messagepost(controlid, strImageSelect);
        } else if (method == "openSmartUpload_onefile") {
            smartupload_onefile_messagepost(controlid, previewid, strImageSelect);
        }
    }
}

/*---END CAC HAM DANH CHO UPLOAD-----------------------------------------------------*/











/*--- QUICK UPLOAD FOR MOBILE -----------------------------------------------------*/
function quickupload_reset(oldimagepath, imagepath, previewid) {
    var oldImagePath = $('#' + oldimagepath).val();
    if (oldImagePath == "") {
        $('#' + previewid).attr("src", " data:image/png;base64,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");
    } else {
        $('#' + imagepath).val(oldImagePath);
        $('#' + previewid).attr("src", oldImagePath);
    }
}


function quickupload_one_remove(url, controlprefix) {
    var jImageControlId = $('#'+ controlprefix +'-imagepath');
    var jOldImageControlId = $('#'+ controlprefix +'-qu-oldimagepath');
    var jPreviewImageControlId = $('#' + controlprefix + '-qu-imagepreview');

    var oldimageurl = jOldImageControlId.val();
    var oldimage = jOldImageControlId.attr('imageupload');
    var uploadImage = jImageControlId.val();

    //if(oldimage == "") {
    //    return;
    //}

    if(confirm("Do you want to delete this image?")) {
        var pieces = uploadImage.split("/");
        var filename = pieces[pieces.length-1];
        var url_remove = url + filename;
        showLoading();
        $.ajax({
            url: url_remove,
            type: 'DELETE',
            success: function(result) {
                endLoading();
                var response = JSON.parse(result);
                if(response[filename] == true) {
                    if(uploadImage != oldimage) {
                        jImageControlId.val(oldimage);
                        if(oldimage != "") {
                            jPreviewImageControlId.attr('src', oldimageurl);
                        } else {
                            jPreviewImageControlId.attr("src", " data:image/png;base64,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");
                        }
                    } else {
                        jOldImageControlId.val("");
                        jOldImageControlId.attr('imageupload', '');
                        jImageControlId.val("");
                        jPreviewImageControlId.attr("src", " data:image/png;base64,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");
                    }
                }
            },
            fail: function() {
                endLoading();
            }
        });
    }
}

function quickupload_onefile_remove(url, controlprefix) {
    var jFileControlId = $('#'+ controlprefix +'-qu-filepath');
    var jOldFileControlId = $('#'+ controlprefix +'-qu-oldfilepath');
    var jPreviewFileControlId = $('#' + controlprefix + '-qu-filepreview');


    var oldfile = jOldFileControlId.val();
    var uploadFile = jFileControlId.val();

    if(oldfile == "") {
        return;
    }

    if(confirm("<?php echo $lang_text_confirm_delete ?>")) {

        var pieces = uploadFile.split("/");
        var filename = pieces[pieces.length-1];
        var url_remove = url + filename;
        showLoading();
        $.ajax({
            url: url_remove,
            type: 'DELETE',
            success: function(result) {
                endLoading();
                var response = JSON.parse(result);
                if(response[filename] == true) {
                    if(uploadFile != oldfile) {
                        jFileControlId.val(oldfile);
                        jPreviewFileControlId.html(oldfile);
                    } else {
                        jOldFileControlId.val("");
                        jFileControlId.val("");
                        jPreviewFileControlId.html("");
                    }
                }
            },
            fail: function() {
                endLoading();
            }
        });
    }
}


function quickupload_one(skinid, controlprefix) {
    var jFileUpload = $('#' + controlprefix  + '-qu-fileupload');
    jFileUpload.fileupload({
        dataType: 'json',
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        maxFileSize: 5000000, // 5 MB
        previewMaxWidth: 800,
        previewMaxHeight: 800,
        previewCrop: true,
        formData: {
            skinid: skinid
        },
        start: function(e) {
            showLoading();
        },
        progressall: function (e, data) {

        },
        done: function (e, data) {
            endLoading();
            var jImagePreview = $('#'+ controlprefix +'-qu-imagepreview');
            var uploadPath = jImagePreview.attr('imagepath');
            $.each(data.result.files, function (index, file) {
                $("#" + controlprefix + "-imagepath").val('upload/' + file.name);
                if(file.error == null) {

                    jImagePreview.fadeOut('slow', function(){
                        $(this).load(function() {
                            $(this).fadeIn('fast', function(){
                            });
                        });
                        $(this).attr('src', uploadPath + file.name);
                    });
                } else {
                    console.log(file.error);
                }
            });

        },
        fail: function (e, data) {
            endLoading();
            alert("Server fails occur");
        },
        stop: function(e) {
            endLoading();
        }
    });
    jFileUpload.trigger('click');

}

function quickupload_onefile(skinid, controlprefix) {

    var jFileUpload = $('#' + controlprefix  + '-qu-fileupload');
    jFileUpload.fileupload({
        dataType: 'json',
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        maxFileSize: 5000000, // 5 MB
        previewMaxWidth: 800,
        previewMaxHeight: 800,
        previewCrop: true,
        formData: {
            skinid: skinid
        },
        progressall: function (e, data) {
            showLoading();
        },
        done: function (e, data) {
            endLoading();
            var jFilePreview = $('#'+ controlprefix +'-qu-filepreview');
            $.each(data.result.files, function (index, file) {
                $("#" + controlprefix + "-qu-filepath").val('upload/' + file.name);
                if(file.error == null) {
                    jFilePreview.html('upload/' + file.name);
                } else {
                    console.log(file.error);
                }
            });

        },
        fail: function (e, data) {
            endLoading();
            alert("Server fails occur");
        }
    });
    jFileUpload.trigger('click');

}

function quickupload_editor(skinid, fileuploadid, editorid) {
    var jFileUpload = $('#'+ fileuploadid);


    var strHTML = "";
    jFileUpload.fileupload({
        dataType: 'json',
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        maxFileSize: 5000000, // 5 MB
        previewMaxWidth: 800,
        previewMaxHeight: 800,
        previewCrop: true,
        formData: {
            skinid: skinid
        },
        start: function(e) {
            showLoading();
        },
        progressall: function (e, data) {

        },
        done: function (e, data) {
            endLoading();
            $.each(data.result.files, function (index, file) {
                if(file.error == null) {
                    strHTML += '<img alt="" src="images/autosize-700x0/' + 'upload/' + file.name + '"/>';
                } else {
                    console.log(file.error);
                }
            });
        },
        fail: function (e, data) {
            endLoading();
            alert("Server fails occur");
        },
        stop: function(e) {
            endLoading();
            if (editorid != "") {
                var oEditor = CKEDITOR.instances[editorid];
                if (oEditor.mode == 'wysiwyg') {
                    oEditor.insertHtml(strHTML);
                    var temp = oEditor.getData();
                    oEditor.setData(temp);
                }
                else {
                    alert('You must be on WYSIWYG mode!');
                }
            }
        }
    });
    jFileUpload.trigger('click');

}



function quickupload_multi(skinid, fileuploadid, previewid) {
    var jFileUpload = $('#'+ fileuploadid);

    var strHTML = "";
    jFileUpload.fileupload({
        dataType: 'json',
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        maxFileSize: 5000000, // 5 MB
        previewMaxWidth: 800,
        previewMaxHeight: 800,
        previewCrop: true,
        formData: {
            skinid: skinid
        },
        start: function(e) {
            showLoading();
        },
        progressall: function (e, data) {

        },
        done: function (e, data) {
            endLoading();
            $.each(data.result.files, function (index, file) {
                if(file.error == null) {
                    //strHTML += '<img alt="" src="images/autosize-700x700/' + 'upload/' + file.name + '"/>';
                    $('#' + previewid).append(subImage.addImageSub('upload/' + file.name, 1));
                } else {
                    console.log(file.error);
                }
            });
        },
        fail: function (e, data) {
            endLoading();
            alert("Server fails occur");
        },
        stop: function(e) {
            endLoading();
            /*
             if (editorid != "") {
             var oEditor = CKEDITOR.instances[editorid];
             if (oEditor.mode == 'wysiwyg') {
             oEditor.insertHtml(strHTML);
             var temp = oEditor.getData();
             oEditor.setData(temp);
             }
             else {
             alert('You must be on WYSIWYG mode!');
             }
             }
             */
        }
    });
    jFileUpload.trigger('click');

}

function quickupload_multi_extend(skinid, fileuploadid, previewid, extendData) {
    var jFileUpload = $('#'+ fileuploadid);

    var strHTML = "";
    jFileUpload.fileupload({
        dataType: 'json',
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        maxFileSize: 5000000, // 5 MB
        previewMaxWidth: 800,
        previewMaxHeight: 800,
        previewCrop: true,
        formData: {
            skinid: skinid
        },
        start: function(e) {
            showLoading();
        },
        progressall: function (e, data) {

        },
        done: function (e, data) {
            endLoading();
            $.each(data.result.files, function (index, file) {
                if(file.error == null) {
                    //strHTML += '<img alt="" src="images/autosize-700x700/' + 'upload/' + file.name + '"/>';
                    $('#' + previewid).append(subImageExtend.addImageSubExtend('upload/' + file.name, 1,  extendData));
                } else {
                    console.log(file.error);
                }
            });
        },
        fail: function (e, data) {
            endLoading();
            alert("Server fails occur");
        },
        stop: function(e) {
            endLoading();
            /*
             if (editorid != "") {
             var oEditor = CKEDITOR.instances[editorid];
             if (oEditor.mode == 'wysiwyg') {
             oEditor.insertHtml(strHTML);
             var temp = oEditor.getData();
             oEditor.setData(temp);
             }
             else {
             alert('You must be on WYSIWYG mode!');
             }
             }
             */
        }
    });
    jFileUpload.trigger('click');

}
/*--- QUICK UPLOAD FOR MOBILE -----------------------------------------------------*/