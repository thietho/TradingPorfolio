<div class="container">
    <div id="module-title" class="pull-left">
        <?php echo $text_card_infomation?>
    </div>
    <div id="module-path" class="pull-right">
        <?php echo $text_home?> / <?php echo $text_card_list?> / <?php echo $text_card_infomation?>
    </div>
    <!-- START BLOCk -->
    <div class="block">
        <div class="row">
            <form class="form-horizontal" id="frmCardView">
                <input type="hidden" id="id" name="id" value="<?php echo $item['id'] ?>">
                <input type="hidden" id="cardid" name="cardid" value="<?php echo $item['cardid'] ?>">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_card_type?></label>
                        <label class="col-md-9"><?php echo $this->document->cardtype[$item['cardtype']]?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_first_name?></label>
                        <label class="col-md-9"><?php echo $item['firstname']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_last_name?></label>
                        <label class="col-md-9"><?php echo $item['lastname']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_full_name?></label>
                        <label class="col-md-9"><?php echo $item['fullname']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_company_name?></label>
                        <label class="col-md-9"><?php echo $item['companyname']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_tax_code?></label>
                        <label class="col-md-9"><?php echo $item['taxcode']?></label>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_image?></label>
                        <label class="col-md-9"><img id="imgimage" width="auto" height="64" src="<?php echo DIR_USERIMAGE ?>autosize-0x64/<?php echo $item['image'] ?>" /></label>

                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Email</label>
                        <label class="col-md-9"><?php echo $item['email']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_telephone?></label>
                        <label class="col-md-9"><?php echo $item['telephone']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_mobile_phone?></label>
                        <label class="col-md-9"><?php echo $item['mobilephone']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_address_line_1?></label>
                        <label class="col-md-9"><?php echo $item['addressline1']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_address_line_2?></label>
                        <label class="col-md-9"><?php echo $item['addressline2']?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_birthdate?></label>
                        <label class="col-md-9"><?php echo $this->date->formatMySQLDate($item['birthdate']) ?></label>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label"><?php echo $text_notes?></label>
                        <label class="col-md-9"><?php echo $item['notes']?></label>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- END BLOCk -->
    <h2><?php echo $text_list_locations?></h2>
    <div class="block">
        <div class="row">
            <table class="table table-striped table-bordered">
                <tr>
                    <th><?php echo $text_no?></th>
                    <th><?php echo $text_loction_name?></th>
                    <th><?php echo $text_contact_name?></th>
                    <th><?php echo $text_phone?></th>
                    <th>Email</th>
                    <th><?php echo $text_address_line_1?></th>
                    <th><?php echo $text_address_line_1?></th>
                    <th class="tool-title"><?php echo $text_tool?></th>
                </tr>
                <tbody id="listlocations">

                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- END PAGE CONTAINER -->
<script type="text/javascript">
    $(document).ready(function () {
        elife_Card.loadLocations("<?php echo $item['cardid'] ?>");
    });
</script>