<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th><?php echo $text_no?></th>
                <th class="sort-default" sortcol="fullname" cardtype="<?php echo $_GET['cardtype']?>">Name</th>
                <th class="sort-default" sortcol="cardid" cardtype="<?php echo $_GET['cardtype']?>"><?php echo $text_card_id?></th>
                <th><?php echo $text_user_name?></th>
                <th class="sort-default" sortcol="telephone"cardtype="<?php echo $_GET['cardtype']?>"><?php echo $text_phone?></th>
				
                <th class="tool-title-2"><?php echo $text_tool?></th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($cards)) { foreach($cards as $card) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $card['fullname'] ?></td>
                <td><button type="button" class="btn btn-success btn-sm" onclick="elife_Card.view(<?php echo $card['id'] ?>)"><?php echo $card['cardid'] ?></button></td>
                <td>
                    <?php echo $card['account'] ?>
                    <?php if($this->user->checkPermission("cardPermission")){ ?>
                    <?php if($card['account']){ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5" onclick="elife_Card.editPermission('<?php echo $card['cardid']?>')"><span class="fa fa-magic"></span></button>
                    <?php } ?>
                    <?php } ?>
                </td>
				<td><?php echo $card['telephone'] ?></td>
				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnCardSelect"
                            id="<?php echo $card['id']?>"
							cardid="<?php echo $card['cardid']?>"
							account="<?php echo $card['account']?>"
                            cardtype="<?php echo $card['cardtype']?>"
							image="<?php echo $card['image']?>"
							firstname="<?php echo $card['firstname']?>"
							lastname="<?php echo $card['lastname']?>"
                            fullname="<?php echo $card['fullname']?>"
							email="<?php echo $card['email']?>"
							telephone="<?php echo $card['telephone']?>"
							mobilephone="<?php echo $card['mobilephone']?>"
							password="<?php echo $card['password']?>"
							ip="<?php echo $card['ip']?>"
							approved="<?php echo $card['approved']?>"
							activecode="<?php echo $card['activecode']?>"
							added_date="<?php echo $card['added_date']?>"
							updated_date="<?php echo $card['updated_date']?>"
                            addressline1="<?php echo $card['addressline1']?>"
                            addressline2="<?php echo $card['addressline2']?>"
							birthdate="<?php echo $card['birthdate']?>"
							gender="<?php echo $card['gender']?>"
							age="<?php echo $card['age']?>"
							zoneid="<?php echo $card['zoneid']?>"
                            levelcode="<?php echo $card['levelcode']?>"

                            ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                    <?php }else{ ?>
                    <?php if($this->user->checkPermission("cardDel")){ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_Card.showDeleteDialog(<?php echo $card['id']?>, '<?php echo $card['cardid'] ?>')"><span class="fa fa-trash"></span></button>
                    <?php } ?>
                    <?php if($this->user->checkPermission("cardEdit")){ ?>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/card/update&id=<?php echo $card[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                    <?php if($this->user->checkPermission("cardSetAcc")){ ?>
                    <?php if($card['cardtype'] == 'staff'){ ?>
                    <button type="button" onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/card/setAccount&id=<?php echo $card[id] ?>'" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-key"></span></button>
                    <?php } ?>
                    <?php } ?>
                    <?php } ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5" onclick="elife_Card.history('<?php echo $card['cardid']?>')"><span class="fa fa-history"></span></button>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileCard">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value=""><?php echo $text_sort?></option>
                    <option value="cardid"><?php echo $text_card_id?></option>
					<option value="account"><?php echo $text_account?></option>
					<option value="image"><?php echo $text_image?></option>
					<option value="firstname"><?php echo $text_first_name?></option>
					<option value="lastname"><?php echo $text_last_name?></option>
					<option value="email">Email</option>
					<option value="telephone"><?php echo $text_telephone?></option>
					<option value="mobilephone">mobilephone</option>

					
                </select>
            </div>
            <div class="col-md-6">
                <select id="sorttype" class="form-control">
                    <option value=""></option>
                    <option value="asc">ASC</option>
                    <option value="desc">DESC</option>
                </select>
            </div>
            <div class="col-md-6">
                <button type="button" class="btn btn-success form-control" id="btnSortCard"><span class="fa fa-sort"></span> <?php echo $text_sort?></button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($cards)) { foreach($cards as $card) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label><?php echo $text_card_id?>:</label> <?php echo $card['cardid'] ?><br>
		<label><?php echo $text_account?>:</label> <?php echo $card['account'] ?><br>
		<label><?php echo $text_image?>:</label> <?php echo $card['image'] ?><br>
		<label><?php echo $text_first_name?>:</label> <?php echo $card['firstname'] ?><br>
		<label><?php echo $text_last_name?>:</label> <?php echo $card['lastname'] ?><br>
		<label>Email:</label> <?php echo $card['email'] ?><br>
		<label><?php echo $text_telephone?>:</label> <?php echo $card['telephone'] ?><br>
		<label><?php echo $text_mobile_phone?>:</label> <?php echo $card['mobilephone'] ?><br>

		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnCardSelect"
                        cardid="<?php echo $card['id']?>"
							cardid="<?php echo $card['cardid']?>"
							account="<?php echo $card['account']?>"
							image="<?php echo $card['image']?>"
							firstname="<?php echo $card['firstname']?>"
							lastname="<?php echo $card['lastname']?>"
                            fullname="<?php echo $card['fullname']?>"
							email="<?php echo $card['email']?>"
							telephone="<?php echo $card['telephone']?>"
							mobilephone="<?php echo $card['mobilephone']?>"
							password="<?php echo $card['password']?>"
							ip="<?php echo $card['ip']?>"
							approved="<?php echo $card['approved']?>"
							activecode="<?php echo $card['activecode']?>"
							added_date="<?php echo $card['added_date']?>"
							updated_date="<?php echo $card['updated_date']?>"
                            addressline1="<?php echo $card['addressline1']?>"
                            addressline2="<?php echo $card['addressline2']?>"
							birthdate="<?php echo $card['birthdate']?>"
							gender="<?php echo $card['gender']?>"
							age="<?php echo $card['age']?>"
							zoneid="<?php echo $card['zoneid']?>"
							
                        ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                <?php }else{ ?>
            <?php if($this->user->checkPermission("cardDel")){ ?>
            <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_Card.showDeleteDialog(<?php echo $card['id']?>, '<?php echo $card['cardid'] ?>')"><span class="fa fa-trash"></span></button>
            <?php } ?>
            <?php if($this->user->checkPermission("cardEdit")){ ?>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/card/update&id=<?php echo $card[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
            <?php if($this->user->checkPermission("cardSetAcc")){ ?>
            <?php if($card['cardtype'] == 'staff'){ ?>
            <button type="button" onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/card/setAccount&id=<?php echo $card[id] ?>'" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-key"></span></button>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <button type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5" onclick="elife_Card.history('<?php echo $card['cardid']?>')"><span class="fa fa-history"></span></button>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    $(document).ready(function(){
        elife_Card.showTotal("<?php echo $this->string->numberFormate($total)?> items");

    });
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";

    $('#fitermobileCard #sortcol').val(sortcol);
        $('#fitermobileCard #sorttype').val(sorttype);
    
        $('#fitermobileCard #btnSortCard').click(function(){
            $('#frmCardSearch #sorttype').val($('#fitermobileCard #sorttype').val());
            $('#frmCardSearch #sortcol').val($('#fitermobileCard #sortcol').val());
            elife_Card.search();
        });
    $('#card-list-<?php echo $_GET['cardtype']?> th').each(function(e){
        if($(this).attr('sortcol') == sortcol)
        {

            $(this).removeClass('sort-default');
            switch(sorttype)
            {
                case 'asc':
                    $(this).addClass('sort-asc');
                    break;
                case 'desc':
                    $(this).addClass('sort-desc');
                    break;
            }
        }
    });
    $('.sort-default').click(function(){
        $('#frmCardSearch #sorttype').val('asc');
        $('#frmCardSearch #sortcol').val($(this).attr('sortcol'));
        elife_Card.search($(this).attr('cardtype'));
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmCardSearch #sorttype').val('desc');
        $('#frmCardSearch #sortcol').val($(this).attr('sortcol'));
        elife_Card.search($(this).attr('cardtype'));
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmCardSearch #sorttype').val('asc');
        $('#frmCardSearch #sortcol').val($(this).attr('sortcol'));
        elife_Card.search($(this).attr('cardtype'));
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>