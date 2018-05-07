<div class="app-heading app-heading-bordered app-heading-page">
    <div class="icon icon-lg"><span class="icon-clipboard-text"></span></div>
    <div class="title">
        <h2>Project management list</h2>
        <p>Client Project management</p>
    </div>
</div>
<div class="container">
    <div class="block">
        <div class="row">
            <form id="frmProjectSearch">
                <div class="col-md-3">
					<label class="control-label">Project name</label>
					<input type="text" class="form-control input-control" placeholder="Project name" id="projectname" name="projectname">
				</div>
				<div class="col-md-3">
					<label class="control-label">Create date</label>
					<input type="text" class="form-control input-control" placeholder="Create date" id="createdate" name="createdate">
				</div>
				<div class="col-md-3">
					<label class="control-label"><?php echo $text_description?></label>
					<input type="text" class="form-control input-control" placeholder="<?php echo $text_description?>" id="description" name="description">
				</div>
				<div class="col-md-3">
					<label class="control-label">Color</label>
					<input type="text" class="form-control input-control" placeholder="Color" id="color" name="color">
				</div>
				<div class="col-md-3">
					<label class="control-label">Portfolioid</label>
					<input type="text" class="form-control input-control" placeholder="Portfolioid" id="portfolioid" name="portfolioid">
				</div>
				
                <input type="hidden" id="sorttype" name="sorttype" value="">
                <input type="hidden" id="sortcol" name="sortcol" value="">
                <input type="hidden" name="type" value="<?php echo $_GET['type']?>">
                <div class="col-md-12 text-right">
                    <button id="btnSearch" class="btn btn-primary" type="button" onclick="elife_Project.search()"><span class="fa fa-search"></span> <?php echo $text_search?></button>
                </div>
            </form>
        </div>
    </div>

    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <div class="col-md-12">
                <?php if($_GET['type'] != 'popup'){ ?>
                <div class="pull-left margin-bottom-20">
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=test/project/insert'" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-plus"></span> Add project</button>
                </div>
                <?php } ?>
                <div class="clear-mobile"></div>
                <div id="project-list"></div>

            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->


<script type="application/javascript">
    function Project()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=test/project/loadData", $('#frmProjectSearch').serialize(), function(html){
                endLoading();
                $('#project-list').html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-project-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("<?php echo $text_do_you_want_to_delete?> " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=test/project/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { elife_Project.search(); };
                    toastr.success('Project has been deleted', '<?php echo $text_delete_success?>', {timeOut: 1000})
                }
            });
        };
    }


    var jFrmProjectSearch = $('#frmProjectSearch');
    var elife_Project = new Project();
    $(document).ready(function(){
        elife_Project.search();

        jFrmProjectSearch.submit(function(e){
            e.preventDefault();
        });

        jFrmProjectSearch.find('.form-control').change(function () {
            elife_Project.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-project-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="elife_Project._delete()"><?php echo $text_ok?></button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal"><?php echo $text_cancel?></button>
            </div>
        </div>
    </div>
</div>