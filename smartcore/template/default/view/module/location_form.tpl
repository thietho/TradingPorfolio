
<div class="container container-boxed">
    <div id="module-title" class="pull-left">
        <?php if($item['id'] == ""){ ?>
        Add new Location
        <?php } else { ?>
        Edit Location
        <?php }?>
    </div>
    <div id="module-path" class="pull-right">
        Home / Location list /
        <?php if($item['id'] == ""){ ?>
        Add new Location
        <?php } else { ?>
        Edit Location
        <?php } ?>
    </div>
    <div class="clearfix"></div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmLocation">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-group">
						<label class="col-md-3 control-label">Khu vực</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="locationname" id="locationname" placeholder="Location Name"
                                       value="<?php echo $item['locationname'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">X</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="xval" id="xval" placeholder="X"
                                       value="<?php echo $item['xval'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Y</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm"
                                       name="yval" id="yval" placeholder="Y"
                                       value="<?php echo $item['yval'] ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Khu vực trực thuộc</label>
						<div class="col-md-9">
                            <select name="parent" id="parent" class="bs-select">
                                <option value="0">--Root--</option>
                                <?php foreach($locations as $location){ ?>
                                <option value="<?php echo $location['id']?>"><?php echo $this->string->setLoopStr('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',$location['level'])?><?php echo $location['locationname']?></option>
                                <?php } ?>
                            </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Phí nhận hàng</label>
						<div class="col-md-9">
							<input type="text" class="form-control input-sm number"
                                       name="shipfee" id="shipfee" placeholder="Ship fee"
                                       value="<?php echo $item['shipfee'] ?>">
						</div>
					</div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Phí giao</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm number"
                                   name="shipfeeorder" id="shipfeeorder" placeholder="Ship fee"
                                   value="<?php echo $item['shipfeeorder'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Freeship cho đơn hàng</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm number"
                                   name="freeshiporder" id="freeshiporder" placeholder="Freeship cho đơn hàng"
                                   value="<?php echo $item['freeshiporder'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Thứ tự</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm"
                                   name="sortorder" id="sortorder" placeholder="Sort Order"
                                   value="<?php echo $item['sortorder'] ?>">
                        </div>
                    </div>
					
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 margin-top-30">
                <div class="text-center">
                    <button type="button" class="btn btn-sm btn-default btn-bg <?php echo $item['id'] == '' ? 'btn-success' : 'btn-info' ?>" id="btnSaveLocation">
                        <?php echo $item['id'] == '' ? 'Insert' : 'Update' ?>
                    </button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/location'" type="button" class="btn btn-sm btn-default btn-bg">Cancel</button>
                </div>
            </div>
        </div>

    </div>
    <!-- END BLOCk -->
</div>
<!-- END PAGE CONTAINER -->

<script type="application/javascript" defer>

$(document).ready(function () {
    $('#frmLocation #parent').selectpicker('val',"<?php echo $item['parent']?>");
});

$('#btnSaveLocation').click(function(){
    showLoading();
    $.post("?route=module/location/save",$('#frmLocation').serialize(),function(data){
        endLoading();
        var obj = $.parseJSON(data)
        if(obj.errorstext != '')
        {
            toastr.error(obj.errorstext,"Errors");
        }
        else
        {
            toastr.options.onHidden = function() { window.location = '?route=module/location'};
            toastr.success('Location has been save', 'Save success', {timeOut: 1000});
        }

    });
});


</script>