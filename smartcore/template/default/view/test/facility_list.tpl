<div class="app-heading app-heading-bordered app-heading-page">
    <div class="icon icon-lg"><span class="icon-clipboard-text"></span></div>
    <div class="title">
        <h2>Facility management list</h2>
        <p>Client Facility management</p>
    </div>
</div>
<div class="container">
    <div class="block">
        <div class="row">
            <form id="frmFacilitySearch">
                <div class="col-md-3">
					<label class="control-label">Property name</label>
					<input type="text" class="form-control input-control" placeholder="Property name" id="propertyname" name="propertyname">
				</div>
				<div class="col-md-3">
					<label class="control-label">Locationid</label>
					<input type="text" class="form-control input-control" placeholder="Locationid" id="locationid" name="locationid">
				</div>
				<div class="col-md-3">
					<label class="control-label">Primary use</label>
					<input type="text" class="form-control input-control" placeholder="Primary use" id="primaryuse" name="primaryuse">
				</div>
				<div class="col-md-3">
					<label class="control-label">Business unit</label>
					<input type="text" class="form-control input-control" placeholder="Business unit" id="businessunit" name="businessunit">
				</div>
				<div class="col-md-3">
					<label class="control-label">Property street address1</label>
					<input type="text" class="form-control input-control" placeholder="Property street address1" id="propertystreetaddress1" name="propertystreetaddress1">
				</div>
				<div class="col-md-3">
					<label class="control-label">Property street address2</label>
					<input type="text" class="form-control input-control" placeholder="Property street address2" id="propertystreetaddress2" name="propertystreetaddress2">
				</div>
				<div class="col-md-3">
					<label class="control-label">Property City</label>
					<input type="text" class="form-control input-control" placeholder="Property City" id="propertycity" name="propertycity">
				</div>
				<div class="col-md-3">
					<label class="control-label">Property State</label>
					<input type="text" class="form-control input-control" placeholder="Property State" id="propertystate" name="propertystate">
				</div>
				<div class="col-md-3">
					<label class="control-label">Property Zip</label>
					<input type="text" class="form-control input-control" placeholder="Property Zip" id="propertyzip" name="propertyzip">
				</div>
				<div class="col-md-3">
					<label class="control-label">Property country</label>
					<input type="text" class="form-control input-control" placeholder="Property country" id="propertycountry" name="propertycountry">
				</div>
				<div class="col-md-3">
					<label class="control-label"><?php echo $text_type?></label>
					<input type="text" class="form-control input-control" placeholder="Type" id="type" name="type">
				</div>
				<div class="col-md-3">
					<label class="control-label">Portfolioid</label>
					<input type="text" class="form-control input-control" placeholder="Portfolioid" id="portfolioid" name="portfolioid">
				</div>
				
                <input type="hidden" id="sorttype" name="sorttype" value="">
                <input type="hidden" id="sortcol" name="sortcol" value="">
                <input type="hidden" name="type" value="<?php echo $_GET['type']?>">
                <div class="col-md-12 text-right">
                    <button id="btnSearch" class="btn btn-primary" type="button" onclick="elife_Facility.search()"><span class="fa fa-search"></span> <?php echo $text_search?></button>
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
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=test/facility/insert'" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-plus"></span> Add facility</button>
                </div>
                <?php } ?>
                <div class="clear-mobile"></div>
                <div id="facility-list"></div>

            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->


<script type="application/javascript">
    function Facility()
    {
        this.id = 0;
        this.search = function()
        {
            showLoading();
            $.get("?route=test/facility/loadData", $('#frmFacilitySearch').serialize(), function(html){
                endLoading();
                $('#facility-list').html(html);
            });
        };

        this.showDeleteDialog = function(id, name)
        {
            this.id = id;
            var jModalLocationDelete = $('#modal-facility-delete');
            jModalLocationDelete.modal();
            jModalLocationDelete.find('.modal-header').html("<?php echo $text_do_you_want_to_delete?> " + name + "?");
        };

        this._delete = function()
        {
            $.get('?route=test/facility/delete&id=' + this.id,function(data){
                if(data == 'true')
                {
                    toastr.options.onHidden = function() { elife_Facility.search(); };
                    toastr.success('Facility has been deleted', '<?php echo $text_delete_success?>', {timeOut: 1000})
                }
            });
        };
    }


    var jFrmFacilitySearch = $('#frmFacilitySearch');
    var elife_Facility = new Facility();
    $(document).ready(function(){
        elife_Facility.search();

        jFrmFacilitySearch.submit(function(e){
            e.preventDefault();
        });

        jFrmFacilitySearch.find('.form-control').change(function () {
            elife_Facility.search();
        });
    });

</script>

<!-- MODAL SMALL -->
<div class="modal fade" id="modal-facility-delete" tabindex="-1" role="dialog" aria-labelledby="modal-small-header">
    <div class="modal-dialog modal-sm" role="document">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="icon-cross"></span>
        </button>
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title" id="modal-small-header"></h4>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-default btn-bg btn-info" data-dismiss="modal" onclick="elife_Facility._delete()"><?php echo $text_ok?></button>
                <button type="button" class="btn btn-default btn-bg" data-dismiss="modal"><?php echo $text_cancel?></button>
            </div>
        </div>
    </div>
</div>