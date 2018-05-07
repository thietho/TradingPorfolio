<div class="app-heading app-heading-bordered app-heading-page">
    <div class="icon icon-lg"><span class="icon-clipboard-text"></span></div>
    <div class="title">
        <?php if($item['id'] == ""){ ?>
        <h2 >Add facility</h2>
        <?php } else { ?>
        <h2 ><?php echo $text_edit?> facility</h2>
        <?php }?>
        <p>Facility management</p>
    </div>
</div>
<div class="container container-boxed">
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmFacility">
                <input type="hidden" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6 col-md-offset-3">
                    <form class="form-horizontal">
                        <div class="form-group">
							<label class="col-md-3 control-label">Property name</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="propertyname" placeholder="Property name"
                                       value="<?php echo $item['propertyname'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Locationid</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="locationid" placeholder="Locationid"
                                       value="<?php echo $item['locationid'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Primary use</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="primaryuse" placeholder="Primary use"
                                       value="<?php echo $item['primaryuse'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Business unit</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="businessunit" placeholder="Business unit"
                                       value="<?php echo $item['businessunit'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Property street address1</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="propertystreetaddress1" placeholder="Property street address1"
                                       value="<?php echo $item['propertystreetaddress1'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Property street address2</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="propertystreetaddress2" placeholder="Property street address2"
                                       value="<?php echo $item['propertystreetaddress2'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Property City</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="propertycity" placeholder="Property City"
                                       value="<?php echo $item['propertycity'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Property State</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="propertystate" placeholder="Property State"
                                       value="<?php echo $item['propertystate'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Property Zip</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="propertyzip" placeholder="Property Zip"
                                       value="<?php echo $item['propertyzip'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Property country</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="propertycountry" placeholder="Property country"
                                       value="<?php echo $item['propertycountry'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label"><?php echo $text_type?></label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="type" placeholder="Type"
                                       value="<?php echo $item['type'] ?>">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">Portfolioid</label>
							<div class="col-md-9">
								<input type="text" class="form-control input-control"
                                       name="portfolioid" placeholder="Portfolioid"
                                       value="<?php echo $item['portfolioid'] ?>">
							</div>
						</div>
						
                    </form>
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveFacility">
                        <?php echo $item['id'] == '' ? $text_insert : $text_update ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=test/facility'" type="button" class="btn btn-sm btn-default btn-bg"><?php echo $text_cancel?></button>
                </div>
            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->

<script type="application/javascript">

    <?php if($_GET['type'] != 'popup'){ ?>
        $('#btnSaveFacility').click(function(){
            showLoading();
            $.post("?route=test/facility/save",$('#frmFacility').serialize(),function(data){
                endLoading();
                var obj = $.parseJSON(data)
                if(obj.errorstext != '')
                {
                    toastr.error(obj.errorstext,"<?php echo $text_errors?>");
                }
                else
                {
                    toastr.options.onHidden = function() { window.location = '?route=test/facility'};
                    toastr.success('Facility has been save', '<?php echo $text_save_success?>', {timeOut: 1000});
                }

            });
        });
    <?php } ?>

</script>