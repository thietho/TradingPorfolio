<div class="app-sidebar app-navigation app-navigation-fixed scroll app-navigation-style-default app-navigation-open-hover dir-left app-navigation-minimized mCustomScrollbar _mCS_1 mCS-autoHide mCS_disabled app-navigation-fixed-absolute" data-type="close-other" data-minimized="minimized">
    <nav>
        <ul>
            <li class="<?php echo $this->request->get['route'] == 'common/dashboard' ? 'active' : '' ?>">
                <a href="<?php echo HTTP_WEB ?>?route=common/dashboard"><span class="icon-home"></span>&nbsp;<?php echo $text_home?></a>
            </li>
            <li><a href="<?php echo HTTP_WEB ?>?route=module/card"><span class="icon-group-work"></span> Danh sách liên hệ</a>
            <li><a href="<?php echo HTTP_WEB ?>?route=module/item"><span class="icon-file-empty"></span> Chứng khoán</a>
            <li><a href="<?php echo HTTP_WEB ?>?route=module/accountstock"><span class="icon-briefcase"></span> Tài khoản</a>
            <li><a href="<?php echo HTTP_WEB ?>?route=module/transaction"><span class="icon-layers"></span> Giao dịch</a>
            <li><a href="<?php echo HTTP_WEB ?>?route=module/dividendcash"><span class="icon-layers"></span> Cổ tức tiền mặt</a>
            <li><a href="<?php echo HTTP_WEB ?>?route=module/dividendstock"><span class="icon-layers"></span> Cổ tức cổ phiếu</a>
            <li><a href="<?php echo HTTP_WEB ?>?route=module/margin"><span class="icon-layers"></span>Khoản vay</a>
            <li><a href="<?php echo HTTP_WEB ?>?route=module/invoice"><span class="icon-pencil"></span> Thu chi</a>

        </ul>
    </nav>
</div>