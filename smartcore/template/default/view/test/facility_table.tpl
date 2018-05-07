<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th><?php echo $text_no?></th>
                <th class="sort-default" sortcol="propertyname">Property name</th>
				<th class="sort-default" sortcol="locationid">Locationid</th>
				<th class="sort-default" sortcol="primaryuse">Primary use</th>
				<th class="sort-default" sortcol="businessunit">Business unit</th>
				<th class="sort-default" sortcol="propertystreetaddress1">Property street address1</th>
				<th class="sort-default" sortcol="propertystreetaddress2">Property street address2</th>
				<th class="sort-default" sortcol="propertycity">Property City</th>
				<th class="sort-default" sortcol="propertystate">Property State</th>
				<th class="sort-default" sortcol="propertyzip">Property Zip</th>
				<th class="sort-default" sortcol="propertycountry">Property country</th>
				<th class="sort-default" sortcol="type"><?php echo $text_type?></th>
				<th class="sort-default" sortcol="portfolioid">Portfolioid</th>
				
                <th class="tool-title"><?php echo $text_tool?></th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($facilitys)) { foreach($facilitys as $facility) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><?php echo $facility['propertyname'] ?></td>
				<td><?php echo $facility['locationid'] ?></td>
				<td><?php echo $facility['primaryuse'] ?></td>
				<td><?php echo $facility['businessunit'] ?></td>
				<td><?php echo $facility['propertystreetaddress1'] ?></td>
				<td><?php echo $facility['propertystreetaddress2'] ?></td>
				<td><?php echo $facility['propertycity'] ?></td>
				<td><?php echo $facility['propertystate'] ?></td>
				<td><?php echo $facility['propertyzip'] ?></td>
				<td><?php echo $facility['propertycountry'] ?></td>
				<td><?php echo $facility['type'] ?></td>
				<td><?php echo $facility['portfolioid'] ?></td>
				
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnFacilitySelect"
                            facilityid="<?php echo $facility['id']?>"
							propertyname="<?php echo $facility['propertyname']?>"
							locationid="<?php echo $facility['locationid']?>"
							primaryuse="<?php echo $facility['primaryuse']?>"
							businessunit="<?php echo $facility['businessunit']?>"
							propertystreetaddress1="<?php echo $facility['propertystreetaddress1']?>"
							propertystreetaddress2="<?php echo $facility['propertystreetaddress2']?>"
							propertycity="<?php echo $facility['propertycity']?>"
							propertystate="<?php echo $facility['propertystate']?>"
							propertyzip="<?php echo $facility['propertyzip']?>"
							propertycountry="<?php echo $facility['propertycountry']?>"
							type="<?php echo $facility['type']?>"
							portfolioid="<?php echo $facility['portfolioid']?>"
							
                            ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                    <?php }else{ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_Facility.showDeleteDialog(<?php echo $facility['id']?>, '<?php echo $facility['propertyname'] ?>')"><span class="fa fa-trash"></span></button>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=test/facility/update&id=<?php echo $facility[id] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>

<div class="mobile-show">
    <div class="block" id="fitermobileFacility">
        <div class="form-group">

            <div class="col-md-6">
                <select id="sortcol" class="form-control">
                    <option value=""><?php echo $text_sort?></option>
                    <option value="propertyname">Property name</option>
					<option value="locationid">Locationid</option>
					<option value="primaryuse">Primary use</option>
					<option value="businessunit">Business unit</option>
					<option value="propertystreetaddress1">Property street address1</option>
					<option value="propertystreetaddress2">Property street address2</option>
					<option value="propertycity">Property City</option>
					<option value="propertystate">Property State</option>
					<option value="propertyzip">Property Zip</option>
					<option value="propertycountry">Property country</option>
					<option value="type"><?php echo $text_type?></option>
					<option value="portfolioid">Portfolioid</option>
					
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
                <button type="button" class="btn btn-success form-control" id="btnSortFacility"><span class="fa fa-sort"></span> <?php echo $text_sort?></button>
            </div>
        </div>
    </div>
    <?php $index = 1;?>
    <?php if(isset($facilitys)) { foreach($facilitys as $facility) { ?>
    <div class="itemrow">
        <label>#</label> <?php echo $index++ ?><br>
        <label>Property name:</label> <?php echo $facility['propertyname'] ?><br>
		<label>Locationid:</label> <?php echo $facility['locationid'] ?><br>
		<label>Primary use:</label> <?php echo $facility['primaryuse'] ?><br>
		<label>Business unit:</label> <?php echo $facility['businessunit'] ?><br>
		<label>Property street address1:</label> <?php echo $facility['propertystreetaddress1'] ?><br>
		<label>Property street address2:</label> <?php echo $facility['propertystreetaddress2'] ?><br>
		<label>Property City:</label> <?php echo $facility['propertycity'] ?><br>
		<label>Property State:</label> <?php echo $facility['propertystate'] ?><br>
		<label>Property Zip:</label> <?php echo $facility['propertyzip'] ?><br>
		<label>Property country:</label> <?php echo $facility['propertycountry'] ?><br>
		<label>Type:</label> <?php echo $facility['type'] ?><br>
		<label>Portfolioid:</label> <?php echo $facility['portfolioid'] ?><br>
		
        <div class="clear-mobile"></div>
        <div class="pull-right">
            <?php if($_GET['type'] == 'popup'){ ?>
                <button class="btn btn-sm btn-primary btnFacilitySelect"
                        facilityid="<?php echo $facility['id']?>"
							propertyname="<?php echo $facility['propertyname']?>"
							locationid="<?php echo $facility['locationid']?>"
							primaryuse="<?php echo $facility['primaryuse']?>"
							businessunit="<?php echo $facility['businessunit']?>"
							propertystreetaddress1="<?php echo $facility['propertystreetaddress1']?>"
							propertystreetaddress2="<?php echo $facility['propertystreetaddress2']?>"
							propertycity="<?php echo $facility['propertycity']?>"
							propertystate="<?php echo $facility['propertystate']?>"
							propertyzip="<?php echo $facility['propertyzip']?>"
							propertycountry="<?php echo $facility['propertycountry']?>"
							type="<?php echo $facility['type']?>"
							portfolioid="<?php echo $facility['portfolioid']?>"
							
                        ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                <?php }else{ ?>
            <button type="button" class="btn btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="elife_Facility.showDeleteDialog(<?php echo $facility['id']?>, '<?php echo $facility['propertyname'] ?>')"><span class="fa fa-trash"></span></button>
            <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=test/facility/update&id=<?php echo $facility[id] ?>'" type="button" class="btn btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
            <?php } ?>
        </div>
        <div class="clear-mobile"></div>
    </div>
    <?php } } ?>
</div>

<?php echo $pagination?>
<script type="application/javascript">
    var sortcol = "<?php echo $_GET['sortcol']?>";
    var sorttype = "<?php echo $_GET['sorttype']?>";
    $('#fitermobileFacility #sortcol').val(sortcol);
        $('#fitermobileFacility #sorttype').val(sorttype);
    
        $('#fitermobileFacility #btnSortFacility').click(function(){
            $('#frmFacilitySearch #sorttype').val($('#fitermobileFacility #sorttype').val());
            $('#frmFacilitySearch #sortcol').val($('#fitermobileFacility #sortcol').val());
            elife_Facility.search();
        });
    $('#facility-list th').each(function(e){
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
        $('#frmFacilitySearch #sorttype').val('asc');
        $('#frmFacilitySearch #sortcol').val($(this).attr('sortcol'));
        elife_Facility.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-asc').click(function(){
        $('#frmFacilitySearch #sorttype').val('desc');
        $('#frmFacilitySearch #sortcol').val($(this).attr('sortcol'));
        elife_Facility.search();
        $(this).removeClass('sort-asc');
        $(this).addClass('sort-desc');
    });
    $('.sort-desc').click(function(){
        $('#frmFacilitySearch #sorttype').val('asc');
        $('#frmFacilitySearch #sortcol').val($(this).attr('sortcol'));
        elife_Facility.search();
        $(this).removeClass('sort-desc');
        $(this).addClass('sort-asc');

    });


</script>