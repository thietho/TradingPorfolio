/************************************************************************************************/
/********** HANDLE COUNT NEW MESAGE COMING **********/
/*************************************************************************************************/
var $loopSoundMessageComingId;
var $timePlaySoundMessageComming;
var audioMessageIncoming = new Audio('<?php echo DIR_IMAGE ?>contact_incoming.mp3');
audioMessageIncoming.addEventListener('ended', function(){
    if ($timePlaySoundMessageComming === 0) {
        var $route = '<?php echo $_GET["route"] ?>';
        if ($route == "core/message") {
            window.location.reload();
        }
    }
});

function playWarningMessageComingSound() {
    $timePlaySoundMessageComming = 1;
    $loopSoundMessageComingId = setInterval(repeatMessageComingSound, 3000);
}
function repeatMessageComingSound() {
    $timePlaySoundMessageComming--;
    if ($timePlaySoundMessageComming === 0) {
        clearInterval($loopSoundMessageComingId);
    }
    audioMessageIncoming.play();
}


function handleMessageNotify() {
    var jMessageUnread = $('.message_unread');
    //count unread message
    $.get("?route=core/message/countunread", function (data) {
        var count = parseInt(data);
        if(count > 0) {
            jMessageUnread.html(data);
            jMessageUnread.show();
        } else {
            jMessageUnread.hide();
        }
    });
    setInterval(function () {
        $.get("?route=core/message/countunread", function (data) {
            var count = parseInt(data);
            if(count > 0) {
                var oldCount = parseInt(jMessageUnread.html());
                if(oldCount < count) {
                    playWarningMessageComingSound();
                }

                jMessageUnread.html(data);
                jMessageUnread.show();
            } else {
                jMessageUnread.hide();
            }
        });
    }, 40000); //30 seconds
}
/*************************************************************************************************/





/*************************************************************************************************/
/********** HANDLE COUNT NEW ORDER COMING **********/
/*************************************************************************************************/
var $loopSoundOrderComingId;
var $timePlaySoundOrderComming;
var audioOrderIncoming = new Audio('<?php echo DIR_IMAGE ?>order_incoming.mp3');
audioOrderIncoming.addEventListener('ended', function(){
    if ($timePlaySoundOrderComming === 0) {
        var $route = '<?php echo $_GET["route"] ?>';
        if ($route == "core/smartorder") {
            window.location.reload();
        }
    }
});

function playWarningOrderComingSound() {
    $timePlaySoundOrderComming = 1;
    $loopSoundOrderComingId = setInterval(repeatOrderComingSound, 3000);
}
function repeatOrderComingSound() {
    $timePlaySoundOrderComming--;
    if ($timePlaySoundOrderComming === 0) {
        clearInterval($loopSoundOrderComingId);
    }
    audioOrderIncoming.play();
}


function handleOrderNotify() {
    var jOrderUnread = $('.order_unread');
    //count unread message
    $.get("?route=core/smartorder/countunread", function (data) {
        var count = parseInt(data);
        if(count > 0) {
            jOrderUnread.html(data);
            jOrderUnread.show();
        } else {
            jOrderUnread.hide();
        }
    });
    setInterval(function () {
        $.get("?route=core/smartorder/countunread", function (data) {
            var count = parseInt(data);
            if(count > 0) {
                var oldCount = parseInt(jOrderUnread.html());
                if(oldCount < count) {
                    playWarningOrderComingSound();
                }
                jOrderUnread.html(data);
                jOrderUnread.show();
            } else {
                jOrderUnread.hide();
            }
        });
    }, 60000); //60 seconds
}
/*************************************************************************************************/


$(document).ready(function() {
    var x = "<?php echo $this->user->isLogged() ? 1 : 0 ?>";
    if('1' == x) {
        console.log('handle Message');
        handleMessageNotify();
        handleOrderNotify();
    }
});


