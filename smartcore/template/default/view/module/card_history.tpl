<div>
    <h2><?php echo $text_import?></h2>
    <table class="table table-striped table-bordered">
        <tr>
            <th><?php echo $text_no?></th>
            <th class="sort-default" sortcol="orderid"><?php echo $text_orderid?></th>
            <th class="sort-default" sortcol="orderdate"><?php echo $text_importdate?></th>
            <th><?php echo $text_importtype?></th>
            <th class="sort-default" sortcol="fullname"><?php echo $text_importfrom?></th>
            <th class="sort-default" sortcol="status"><?php echo $text_status?></th>

            <th class="sort-default" sortcol="comment"><?php echo $text_comment?></th>
            <th class="sort-default" sortcol="total"><?php echo $text_total?></th>
            <th class="sort-default" sortcol="payment"><?php echo $text_payment?></th>
            <th><?php echo $text_balancedue?></th>


        </tr>
        <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
        <?php if(isset($imports)) { foreach($imports as $import) { ?>
        <tr>
            <td class="text-center"><?php echo ++$index; ?></td>
            <td><button type="button" class="btn btn-success" onclick="elife_Card.viewImport('<?php echo $import['orderid'] ?>')"><?php echo $import['orderid'] ?></button></td>
            <td><?php echo $this->date->formatMySQLDate($import['orderdate']) ?></td>
            <td><?php echo $this->document->ordertype[$import['ordertype']]?></td>
            <td><?php echo $import['fullname'] ?></td>



            <td><?php echo $this->document->getStatus($import['status']) ?></td>

            <td><?php echo $import['comment'] ?></td>
            <td class="number"><?php echo $this->document->currencyFormate($import['total']) ?></td>
            <td class="number"><?php echo $this->document->currencyFormate($import['payment']) ?></td>
            <td class="number"><?php echo $this->document->currencyFormate($import['total']-$import['payment']) ?></td>


        </tr>
        <?php } } ?>
    </table>
</div>
<div>
    <h2><?php echo $text_export?></h2>
    <table class="table table-striped table-bordered">
        <tr>
            <th><?php echo $text_no?></th>
            <th class="sort-default" sortcol="orderid"><?php echo $text_exportid?></th>
            <th class="sort-default" sortcol="orderdate"><?php echo $text_exportdate?></th>
            <th><?php echo $text_exporttype?></th>
            <th class="sort-default" sortcol="fullname"><?php echo $text_exportfrom?></th>
            <th class="sort-default" sortcol="status"><?php echo $text_status?></th>

            <th class="sort-default" sortcol="comment"><?php echo $text_comment?></th>
            <th class="sort-default" sortcol="total"><?php echo $text_total?></th>
            <th class="sort-default" sortcol="payment"><?php echo $text_payment?></th>
            <th><?php echo $text_balancedue?></th>

        </tr>
        <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
        <?php if(isset($imports)) { foreach($exports as $export) { ?>
        <tr>
            <td class="text-center"><?php echo ++$index; ?></td>
            <td><button type="button" class="btn btn-success" onclick="elife_Card.viewImport('<?php echo $export['orderid'] ?>')"><?php echo $export['orderid'] ?></button></td>
            <td><?php echo $this->date->formatMySQLDate($export['orderdate']) ?></td>
            <td><?php echo $this->document->ordertype[$export['ordertype']]?></td>
            <td><?php echo $export['fullname'] ?></td>



            <td><?php echo $this->document->getStatus($export['status']) ?></td>

            <td><?php echo $export['comment'] ?></td>
            <td class="number"><?php echo $this->string->numberFormate($export['total']) ?></td>
            <td class="number"><?php echo $this->string->numberFormate($export['payment']) ?></td>
            <td class="number"><?php echo $this->string->numberFormate($export['total']-$export['payment']) ?></td>


        </tr>
        <?php } } ?>
    </table>
</div>
<div>
    <h2>Sale</h2>
    <table class="table table-striped table-bordered">
        <tr>
            <th><?php echo $text_no?></th>
            <th class="sort-default" sortcol="orderid"><?php echo $text_orderid?></th>
            <th class="sort-default" sortcol="orderdate"><?php echo $text_saledate?></th>
            <th class="sort-default" sortcol="fullname"><?php echo $text_customer?></th>
            <th class="sort-default" sortcol="status"><?php echo $text_status?></th>
            <th class="sort-default" sortcol="comment"><?php echo $text_comment?></th>
            <th class="sort-default" sortcol="total"><?php echo $text_total?></th>
            <th class="sort-default" sortcol="payment"><?php echo $text_payment?></th>
            <th><?php echo $text_balancedue?></th>


        </tr>
        <?php $index = ($objPage['pape']-1) * $objPage['itemsPerPage'];?>
        <?php if(isset($sales)) { foreach($sales as $sale) { ?>
        <tr>
            <td class="text-center"><?php echo ++$index; ?></td>
            <td><button type="button" class="btn btn-success" onclick="elife_Card.viewSale('<?php echo $sale['orderid'] ?>')"><?php echo $sale['orderid'] ?></button></td>
            <td><?php echo $this->date->formatMySQLDate($sale['orderdate']) ?></td>
            <td><?php echo $sale['fullname'] ?></td>



            <td><?php echo $this->document->getStatus($sale['status']) ?></td>

            <td><?php echo $sale['comment'] ?></td>
            <td class="number"><?php echo $this->string->numberFormate($sale['total']) ?></td>

            <td class="number"><?php echo $this->string->numberFormate($sale['payment']) ?></td>
            <td class="number"><?php echo $this->string->numberFormate($sale['total']-$sale['payment']) ?></td>


        </tr>
        <?php } } ?>
    </table>
</div>

<div>
    <h2>Payment</h2>
    <table class="table table-striped table-bordered">
        <tr>
            <th><?php echo $text_no?></th>
            <th class="sort-default" sortcol="orderid"><?php echo $text_invoice_id?></th>
            <th class="sort-default" sortcol="orderdate"><?php echo $text_invoice_date?></th>
            <th>Tài khoản nợ</th>
            <th>Tài khoản có</th>
            <th class="sort-default" sortcol="status"><?php echo $text_status?></th>
            <th class="sort-default" sortcol="comment"><?php echo $text_comment?></th>
            <th class="sort-default" sortcol="comment">Đơn hàng</th>
            <th class="sort-default" sortcol="total">Thanh toán đơn hàng</th>
            <th class="sort-default" sortcol="payment">Khách hàng ứng trước</th>
            <th>Số tiền</th>


        </tr>
        <?php $index = 0;?>
        <?php $sumpay = 0;?>
        <?php $sumdeblt = 0;?>
        <?php if(isset($invioces)) { foreach($invioces as $invioce) { ?>
        <tr>
            <td class="text-center"><?php echo ++$index; ?></td>
            <td><button type="button" class="btn btn-success" onclick="elife_Card.viewSale('<?php echo $invioce['invoiceid'] ?>')"><?php echo $invioce['invoiceid'] ?></button></td>
            <td><?php echo $this->date->formatMySQLDate($invioce['invoicedate']) ?></td>
            <td><?php echo $invioce['accountidto'] ?> - <?php echo $this->document->getAccount($invioce['accountidto']) ?></td>
            <td><?php echo $invioce['accountidfrom'] ?> - <?php echo $this->document->getAccount($invioce['accountidfrom']) ?></td>
            <td><?php echo $invioce['status'] ?></td>
            <td><?php echo $invioce['notes'] ?></td>
            <td><?php echo $invioce['orderid'] ?></td>
            <td class="number"><?php if($invioce['accountidfrom']!='2-1142'){ echo $this->string->numberFormate($invioce['amount']);$sumpay+=$invioce['amount'];} ?></td>

            <td class="number"><?php if($invioce['accountidfrom']=='2-1142'){ echo $this->string->numberFormate($invioce['amount']);$sumdeblt+=$invioce['amount'];} ?></td>
            <td class="number"><?php if($invioce['accountidfrom']!='2-1142'){ echo $this->string->numberFormate($invioce['amount']);}else{ echo $this->string->numberFormate(-1*$invioce['amount']); } ?></td>


        </tr>
        <?php } } ?>
        <tr>
            <td colspan="8">Tổng:</td>

            <td class="number"><?php echo $this->string->numberFormate($sumpay) ?></td>
            <td class="number"><?php echo $this->string->numberFormate($sumdeblt) ?></td>
            <td class="number"><?php echo $this->string->numberFormate($sumpay - $sumdeblt) ?></td>
        </tr>
    </table>
</div>
