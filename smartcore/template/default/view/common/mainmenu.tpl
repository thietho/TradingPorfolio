
<div class="app-navigation-horizontal">
<nav>
    <ul>
        <li class="<?php echo $this->request->get['route'] == 'module/product' ? 'active' : '' ?> openable">
            <a href="<?php echo HTTP_WEB ?>?route=module/product"><span class="icon-home"></span>&nbsp;Product</a>
        </li>
        <li class="openable">
            <a href="#"><span class="icon-archive"></span>&nbsp;<?php echo $text_category?></a>
            <ul>
                <li class="<?php echo $this->request->get['route'] == 'module/unit' ? 'active' : '' ?>">
                    <a href="<?php echo HTTP_WEB ?>?route=module/unit"><span class="icon-archive"></span>&nbsp;Unit</a>

                </li>
                <li class="<?php echo $this->request->get['route'] == 'module/card' ? 'active' : '' ?> ">
                    <a href="<?php echo HTTP_WEB ?>?route=module/card"><span class="icon-users2"></span>&nbsp;<?php echo $text_card?></a>

                </li>
                <li class="<?php echo $this->request->get['route'] == 'module/store' ? 'active' : '' ?> ">
                    <a href="<?php echo HTTP_WEB ?>?route=module/store"><span class="icon-store"></span>&nbsp;<?php echo $text_store?></a>

                </li>
                <li class="<?php echo $this->request->get['route'] == 'module/accounts' ? 'active' : '' ?> ">
                    <a href="<?php echo HTTP_WEB ?>?route=module/accounts"><span class="icon-document"></span>&nbsp;Accounts</a>

                </li>
                <li class="<?php echo $this->request->get['route'] == 'module/invoice' ? 'active' : '' ?> ">
                    <a href="<?php echo HTTP_WEB ?>?route=module/invoice"><span class="icon-register"></span>&nbsp;<?php echo $text_invoice?></a>

                </li>
                <li class="<?php echo $this->request->get['route'] == 'module/paymentmethod' ? 'active' : '' ?> ">
                    <a href="<?php echo HTTP_WEB ?>?route=module/paymentmethod"><span class="icon-credit-card"></span>&nbsp;Paymentmethod</a>

                </li>

            </ul>
        </li>


        <li class="<?php echo $this->request->get['route'] == 'module/orderstatus' ? 'active' : '' ?> openable">
            <a href="<?php echo HTTP_WEB ?>?route=module/orderstatus"><span class="icon-credit-card"></span>&nbsp;<?php echo $text_order_status?></a>

        </li>
        <li class="<?php echo $this->request->get['route'] == 'module/import' ? 'active' : '' ?> openable">
            <a href="<?php echo HTTP_WEB ?>?route=module/import"><span class="icon-inbox2"></span>&nbsp;Import</a>

        </li>
        <li class="<?php echo $this->request->get['route'] == 'module/sale' ? 'active' : '' ?> openable">
            <a href="<?php echo HTTP_WEB ?>?route=module/sale"><span class="icon-store"></span>&nbsp;Sale</a>

        </li>
        <li class="<?php echo $this->request->get['route'] == 'module/stocktransfer' ? 'active' : '' ?> openable">
            <a href="<?php echo HTTP_WEB ?>?route=module/stocktransfer"><span class="icon-tab"></span>&nbsp;Stock Transfer</a>

        </li>
    </ul>
</nav>
</div>
