<div class="desktop-show">
    <table class="table"></table>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <tr>
                <th><?php echo $text_no?></th>
                <th>Khu vực</th>
                <th>Phí nhận hàng</th>
                <th>Phí giao hàng</th>
                <th>Freeship cho đơn hàng</th>
                <th class="tool-title"><?php echo $text_tool?></th>
            </tr>
            <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
            <?php if(isset($locations)) { foreach($locations as $location) { ?>
            <tr>
                <td class="text-center"><?php echo ++$index; ?></td>
                <td><div class="margin-left-<?php echo $location['level']*10 ?>"><?php echo $location['locationname'] ?></div></td>
                <td class="number"><?php echo $this->document->currencyFormate($location['shipfee']) ?></td>
                <td class="number"><?php echo $this->document->currencyFormate($location['shipfeeorder']) ?></td>
                <td class="number"><?php echo $this->document->currencyFormate($location['freeshiporder']) ?></td>
                <td class="text-center">
                    <?php if($_GET['type'] == 'popup'){ ?>
                    <button class="btn btn-sm btn-primary btnAccountSelect" id="btnSeleteAccount-<?php echo $location['id']?>"
                            id="<?php echo $location['id']?>"
                            locationname="<?php echo $location['locationname']?>"
                            parent="<?php echo $location['parent']?>"
                            onclick="onSeleteLocation('<?php echo $location['id']?>')"
                    ><span class="fa fa-check"></span> <?php echo $text_select?></button>
                    <?php }else{ ?>
                    <?php if($this->user->checkPermission("locationDel")){ ?>
                    <button type="button" class="btn btn-sm btn-default btn-icon btn-danger btn-warning margin-0 margin-right-5" onclick="Account.showDeleteDialog('<?php echo $location['id']?>', '<?php echo $location['locationname'] ?>')"><span class="fa fa-trash"></span></button>
                    <?php } ?>
                    <?php if($this->user->checkPermission("locationEdit")){ ?>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/location/update&id=<?php echo $location['id'] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-edit"></span></button>
                    <?php } ?>
                    <?php if($this->user->checkPermission("locationAdd")){ ?>
                    <button onclick="window.location.href='<?php echo HTTP_WEB ?>?route=module/location/insert&parent=<?php echo $location['id'] ?>'" type="button" class="btn btn-sm btn-default btn-icon btn-edit btn-info margin-0 margin-right-5"><span class="fa fa-plus"></span></button>
                    <?php } ?>
                    <?php } ?>
                </td>
            </tr>
            <?php } } ?>
        </table>
    </div>
</div>