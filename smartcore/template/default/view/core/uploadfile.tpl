<style>
    .progress
    {
        width:100%;

    }
    .bar {
        height: 18px;
        background: green;
        text-align:center;
    }
</style>
<input id="fileupload" class="file-input" type="file" name="files[]"  multiple value="Chon file">
<div class="progress" id="progress'+t+'"><div class="bar" style="width: 0%;"></div></div>
<div id="listfile"></div>
<script type="text/javascript" defer>
    var type = "<?php echo $type?>";
    $(function () {
        $('#fileupload').fileupload({
            dataType: 'json',
            url: "?route=common/uploadfile&folder=<?php echo $folder?>",
            done: function (e, data) {

                resetProgressBar();
                returnControl(data.files[0].name,"<?php echo $_GET['eid']?>",type);
                loadListFile();
            },
            progressall: function (e, data) {
                //showProgress(cur,e, data)
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $('.bar').html(progress+"%");
                $('.progress .bar').css(
                        'width',
                        progress + '%'
                );
            }
        });
    });
    function resetProgressBar()
    {
        $('.bar').html('');
        $('.progress .bar').css(
                'width',0
        );
    }
    function showProgress(id,e, data)
    {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('#progress'+cur+' .bar').css(
                'width',
                progress + '%'
        );
    }

    $(document).ready(function(){
        loadListFile();
    });
    function loadListFile() {
        $('#listfile').load("?route=core/uploadfile/getList&folder=<?php echo $folder?>&type=<?php echo $type?>",function(){
            var fbbtnSelectFile = false;

            $(document).ajaxComplete(function(){

                if(fbbtnSelectFile == false)
                {
                    fbbtnSelectFile = true;
                    $('.btnSelectFile').click(function(){
                        returnControl($(this).attr('filename'),"<?php echo $_GET['eid']?>",type);

                    });

                }

                $('.btnDeleteFile').click(function(){
                    $.post("?route=core/uploadfile/delFile",{
                        filepath:$(this).attr('filepath')
                    },function(data){
                        if(data == 'true')
                        {
                            $('#listfile').load("?route=core/uploadfile/getList&folder=<?php echo $folder?>");
                        }
                    });
                });
            });
        });
    }
    function returnControl(filename,eid,type)
    {
        var size = "<?php echo $size?>";
        if(size == '')
                size = '0x64';
        var output = "<?php echo $output?>";
        if(output == '')
            output = 'autosize';

        switch(type)
        {
            case '':
                $("#"+eid).val("<?php echo 'upload/'.$folder?>/"+filename);
                $("#lbl"+eid).html("<?php echo 'upload/'.$folder?>/"+filename);
                $("#img"+eid).attr('src',"<?php echo DIR_USERIMAGE ?>"+output+"-"+size+"/<?php echo 'upload/'.$folder?>/"+filename);
                $('#modal-select-file').modal('hide');
                break;
            case 'multi':
                var s ="<?php echo DIR_USERIMAGE ?>"+output+"-"+size+"/<?php echo 'upload/'.$folder?>/"+filename;
                var filepath = "<?php echo 'upload/'.$folder?>/"+ filename;
                $("#"+eid).append('<div class="'+eid+'" filepath="'+ filepath +'"><img src="'+s+'"><a target="_blank" href="<?php echo MAIN_HTTP_SERVER.DIR_FILE?>'+filepath+'">'+filename+'</a><button type="button" class="btn btn-sm btn-default btn-icon btn-danger margin-0 margin-right-5 btnDelFileList"><span class="fa fa-trash"></span></button></div>');
                $('#modal-select-file').modal('hide');
                $('.btnDelFileList').click(function(){
                    $(this).parent().remove();
                });
                break;
            case 'editor':
                var oEditor = CKEDITOR.instances[eid] ;
                var filepath = "<?php echo 'upload/'.$folder?>/"+ filename;
                value = "<img src='<?php echo MAIN_HTTP_SERVER.DIR_FILE?>" + filepath + "'/>";
                // Check the active editing mode.
                if (oEditor.mode == 'wysiwyg' )
                {
                    // Insert the desired HTML.
                    oEditor.insertHtml( value ) ;

                    var temp = oEditor.getData()
                    oEditor.setData( temp );
                }
                else
                    alert( 'You must be on WYSIWYG mode!' ) ;
                $('#modal-select-file').modal('hide');
                break;

        }
    }

</script>