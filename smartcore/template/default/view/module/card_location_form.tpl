<form id="frmCardLocation">
    <div>
        <div class="form-group">
            <label class="col-md-3 control-label"><?php echo $text_loction_name?></label>
            <div class="col-md-9">
                <input type="text" class="form-control input-control"
                       name="locationname" id="locationname" placeholder="<?php echo $text_loction_name?>" value="<?php echo $item['locationname']?>">
                <input type="hidden" name="cardid" id="cardid" value="<?php echo $item['cardid']?>">
                <input type="hidden" name="id" id="id" value="<?php echo $item['id']?>">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label"><?php echo $text_contact_name?></label>
            <div class="col-md-9">
                <input type="text" class="form-control input-control"
                       name="contactname" id="contactname" placeholder="<?php echo $text_contact_name?>"
                       value="<?php echo $item['contactname'] ?>">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label"><?php echo $text_address_line_1?></label>
            <div class="col-md-9">
                <input type="text" class="form-control input-control"
                       name="addressline1" id="addressline1" placeholder="<?php echo $text_address_line_1?>"
                       value="<?php echo $item['addressline1'] ?>">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label"><?php echo $text_address_line_2?></label>
            <div class="col-md-9">
                <input type="text" class="form-control input-control"
                       name="addressline2" id="addressline2" placeholder="<?php echo $text_address_line_2?>"
                       value="<?php echo $item['addressline2'] ?>">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label"><?php echo $text_phone?></label>
            <div class="col-md-9">
                <input type="text" class="form-control input-control"
                       name="phone" id="phone" placeholder="<?php echo $text_phone?>" value="<?php echo $item['phone']?>">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">Email</label>
            <div class="col-md-9">
                <input type="text" class="form-control input-control"
                       name="email" id="email" placeholder="Email" value="<?php echo $item['email']?>">
            </div>
        </div>
    </div>

</form>