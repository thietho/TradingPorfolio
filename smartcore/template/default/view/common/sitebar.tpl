<div class="app-sidebar app-navigation app-navigation-fixed scroll app-navigation-style-default app-navigation-open-hover dir-left app-navigation-minimized mCustomScrollbar _mCS_1 mCS-autoHide mCS_disabled app-navigation-fixed-absolute" data-type="close-other" data-minimized="minimized">
    <nav>
        <ul>
            <li class="<?php echo $this->request->get['route'] == 'common/dashboard' ? 'active' : '' ?>">
                <a href="<?php echo HTTP_WEB ?>?route=common/dashboard"><span class="icon-home"></span>&nbsp;<?php echo $text_home?></a>
            </li>
            <li><a href="<?php echo HTTP_WEB ?>?route=module/card"><span class="icon-group-work"></span> Danh sách liên hệ</a>
            <li><a href="<?php echo HTTP_WEB ?>?route=module/item"><span class="icon-file-empty"></span> Chứng khoán</a>

        </ul>
    </nav>
</div>