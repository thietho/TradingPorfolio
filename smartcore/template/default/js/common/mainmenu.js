$(document).ready(function () {
    $(".main-menu a").click(function () {
        return false;
    });


    $(".expand-sign").click(function () {
        console.log('click');
        var parent = $(this).parent().parent();
        parent.toggleClass('expanded');
        parent.siblings(".expanded").removeClass('expanded');

    });


    $(".main-menu a span.title").click(function () {
        window.location.href = $(this).parent().attr("href");
    });
});
