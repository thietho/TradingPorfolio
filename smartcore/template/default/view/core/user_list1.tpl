<div class="container">
    <h3 class="text-standard text-uppercase"><strong><?php echo $lang_text_user_mangament ?></strong></h3>
    <div class="block">
        <div class="row">
            <form id="frmUserSearch">
                <div class="col-md-3">
                    <label class="control-label">Name</label>
                    <input type="text" class="form-control input-control" name="name" placeholder="Name">
                </div>
                <div class="col-md-3">
                    <label class="control-label"><?php echo $text_user_name?></label>
                    <input type="text" class="form-control input-control" name="username" placeholder="<?php echo $text_user_name?>">
                </div>
                <div class="col-md-3">
                    <label class="control-label"><?php echo $text_status?></label>
                    <select class="form-control" name="status">
                        <option value=""><?php echo $text_all?></option>
                        <?php foreach($this->document->userStatus as $status => $statustext){ ?>
                        <option value="<?php echo $status?>"><?php echo $statustext?></option>
                        <?php } ?>
                    </select>
                </div>
                <div class="col-md-12 text-right">
                    <button id="btnSearch" class="btn btn-primary" onclick="user.search()"><span class="fa fa-search"></span> <?php echo $text_search?></button>
                </div>
            </form>
        </div>
    </div>



    <div class="block">
        <div class="row">
            <div class="col-md-12">
                <div class="pull-left margin-bottom-20">
                    <button onclick="window.location = '?route=core/user/insert'" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-plus"></span> Add user</button>
                </div>

                <div class="clear-mobile"></div>
                <div id="user-list"></div>

            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>


<script type="application/javascript">
    function User()
    {
        this.userid = '';
        this.search = function()
        {
            showLoading();
            $.get("?route=core/user/loadData",$('#frmUserSearch').serialize(),function(html){
                endLoading();
                $('#user-list').html(html);
                app_plugins.switch_button();
                addEventStatusButton();
            });
        };
        this.showDeleteDialog = function(userid, fullname)
        {
            $('#modal-client-delete').modal();
            this.userid = userid;
            $('#modal-client-delete .modal-header').html("<?php echo $text_do_you_want_to_delete?> " + fullname + "?");
        };
        this.delete = function()
        {
            $.post('?route=core/user/delete', {userid: this.userid} ,function(data){
                var obj = $.parseJSON(data);
                if(obj.status == 'ok')
                {
                    toastr.options.onHidden = function() { user.search() }
                    toastr.success('User has been deleted', '<?php echo $text_delete_success?>', {timeOut: 1000})
                }
            });
        };
        this.showResetPassForm = function(userid, username)
        {
            $('#modal-client-reset').modal();
            this.userid = userid;
            $('#modal-client-reset .modal-header').html("Do you want to reset password for account <strong>" + username + "</strong>?");
        };
        this.resetPassword = function()
        {
            $.post("?route=core/user/resetPassword",{
                userid: this.userid
            },function(data){
                var obj = $.parseJSON(data);
                if(obj.status != 'ok')
                {
                    toastr.error(obj.message, '<?php echo $text_errors?>', {timeOut: 5000})
                }
                else
                {
                    toastr.success('User has been change password success', 'Reset password success', {timeOut: 5000});
                    $('#modal-client-reset').modal("hide");
                }
            });
        };
        this.selectCard = function(username)
        {
            $('#modal-card-list').modal();
            if($('#modal-card-list .modal-body').html() == '')
                $('#modal-card-list .modal-body').load('?route=module/card&type=popup',function(){
                    $(document).ajaxComplete(function(){
                        $('.btnCardSelect').click(function () {
                            var id = $(this).attr('id');
                            $.post('?route=module/card/updateAccount',{
                                id:id,
                                username:username
                            },function(data){

                            });
                            $('#modal-card-list').modal('hide');
                        });
                    });

                });
        }
    }
    var user = new User();
    $(document).ready(function(){
        user.search();
        $('#frmUserSearch .form-control').change(function () {
            user.search();
        });
    });

    $('#frmUserSearch').submit(function(e){
        e.preventDefault();
    });


    function addEventStatusButton() {
        $('.user_status').change(function(){
            var userid = $(this).attr('userid');
            var status = $(this).prop('checked');
            activeUser(userid);
        });
    }

    function activeUser($userid) {
        showLoading();
        $.post("?route=core/user/active", {userid: $userid}, function($data) {
            endLoading();
            var $response = JSON.parse($data);
            var $errors = $response['errors'];
            if($response['status'] == 'failed') {
                //$("html, body").animate({ scrollTop: 0 }, "fast");
                toastr.error('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');

            } else {
                //toastr.success('<div class="toast-title">'+ $response['title'] +'</div><div class="toast-messsage">'+ $response['message'] +'</div>');
                //window.location.reload();
            }
        });
    }
</script>
<!-- MODAL SMALL -->
<div class="modal fade" id="modal-client-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="user.delete()"><?php echo $text_ok?></button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal"><?php echo $text_cancel?></button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="modal-client-reset" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="user.resetPassword()"><?php echo $text_ok?></button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal"><?php echo $text_cancel?></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-card-list" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-fw" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-default-header"><?php echo $text_list_card?></h4>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnAddCard" onclick="addCard()"><span class="fa fa-plus"></span> <?php echo $text_add_card?></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal-card-form" tabindex="-1" role="dialog" aria-labelledby="modal-default-header">
    <div class="modal-dialog modal-fw" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-default-header"><?php echo $text_card_infomation?></h4>
            </div>
            <div class="modal-body"></div>

        </div>
    </div>
</div>