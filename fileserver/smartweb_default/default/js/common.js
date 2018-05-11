function escapeUnicode(str) {
    str= str.toLowerCase();
    str= str.replace(/Ã |Ã¡|áº¡|áº£|Ã£|Ã¢|áº§|áº¥|áº­|áº©|áº«|Äƒ|áº±|áº¯|áº·|áº³|áºµ/g,"a");
    str= str.replace(/Ã¨|Ã©|áº¹|áº»|áº½|Ãª|á»�|áº¿|á»‡|á»ƒ|á»…/g,"e");
    str= str.replace(/Ã¬|Ã­|á»‹|á»‰|Ä©/g,"i");
    str= str.replace(/Ã²|Ã³|á»�|á»�|Ãµ|Ã´|á»“|á»‘|á»™|á»•|á»—|Æ¡|á»�|á»›|á»£|á»Ÿ|á»¡/g,"o");
    str= str.replace(/Ã¹|Ãº|á»¥|á»§|Å©|Æ°|á»«|á»©|á»±|á»­|á»¯/g,"u");
    str= str.replace(/á»³|Ã½|á»µ|á»·|á»¹/g,"y");
    str= str.replace(/Ä‘/g,"d");
    str= str.replace(/!|@|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\;|\'| |\"|\&|\#|\[|\]|~|$|_/g,"-");
    /* tÃ¬m vÃ  thay tháº¿ cÃ¡c kÃ­ tá»± Ä‘áº·c biá»‡t trong chuá»—i sang kÃ­ tá»± - */
    str= str.replace(/-+-/g,"-"); //thay tháº¿ 2- thÃ nh 1-
    str= str.replace(/^\-+|\-+$/g,"");
    //cáº¯t bá»� kÃ½ tá»± - á»Ÿ Ä‘áº§u vÃ  cuá»‘i chuá»—i
    return str;
}

/*******************************************************************/
/***************************** VALIDATION **************************/
function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}
/*******************************************************************/
/***************************** END VALIDATION **************************/

toastr.options.timeOut = 30000; // How long the toast will display without user interaction
toastr.options.extendedTimeOut = 60; // How long the toast will display after a user hovers over it
toastr.options.closeButton = true;

function showLoading()
{
    $('#loading').removeClass('hidden');
}
function endLoading()
{
    $('#loading').addClass('hidden');
}
function goPage(url,eid) {
    showLoading();
    $('#'+eid).load(encodeURI(url),function () {
        endLoading();
    });
}
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.split(search).join(replacement);
};

function strReplace(search,replace,str)
{
    return str.replaceAll(search,replace);
}
function stringtoNumber(str)
{
    str = (""+str).replace(/,/g,"");
    var num = str*1;
    return Number(num);
}
function formateNumber(num)
{
    if(num =="")
        return 0;

    num = String(num).replace(/,/g,"");
    num = Number(num);
    ar = (""+num).split("\.");
    div = ar[0];
    mod = ar[1];
    //console.log(div + '--' + mod);
    arr = new Array();
    block = "";

    for(i=div.length-1; i>=0 ; i--)
    {

        block = div[i] + block;

        if(block.length == 3)
        {
            arr.unshift(block);
            block ="";
        }

    }
    arr.unshift(block);

    divnum = arr.join(",");
    divnum = trim(divnum,",")
    divnum = divnum.replace("-,","-")

    if(mod == undefined){

        return divnum;
    }
    else
    {
        var p = mod.substr(0,4);
        return divnum+"\."+p;
    }

}
function formatDouble (num,c, d, t)
{
    var n = num,
        c = isNaN(c = Math.abs(c)) ? 0 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;
    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
}

function currencyFormate(num)
{
    var n = formatDouble(num);
    return currencyprefix + n + currencysubfix;
}
function isNumber(char)
{
    if( char!=8 && char!=0 && (char<45 || char>57) )
    {
        //display error message
        //$("#errmsg").html("Digits Only").show().fadeOut("slow");
        return false;
    }
    else true
}
function trim(str, chars) {
    return ltrim(rtrim(str, chars), chars);
}
function ltrim(str, chars) {
    chars = chars || "\\s";
    return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
}

function rtrim(str, chars) {
    chars = chars || "\\s";
    return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
}
function numberReady()
{
    $(".number").change(function (e)
    {
        num = formateNumber($(this).val().replace(/,/g,""));
        $(this).val(num)
    });
    $(".number").keypress(function (e)
    {
        return isNumber(e.which);
    });

    $('.number').focus(function(e) {
        if(this.value == 0)
            this.value = "";
    });
    $('.number').blur(function(e) {
        if(this.value == "")
            this.value = 0;
    });

    $(".number").each(function(index){
        //alert(formateNumber($(this).val()))
        $(this).val(formateNumber($(this).val()));
        //$(this).html(formateNumber($(this).html()))

    });

    $(".double").change(function (e)
    {
        num = formateNumber($(this).val().replace(/,/g,""));
        $(this).val(num)
    });
    $(".double").keypress(function (e)
    {
        return isNumber(e.which);
    });

    $('.double').focus(function(e) {
        if(this.value == 0)
            this.value = "";
    });
    $('.double').blur(function(e) {
        if(this.value == "")
            this.value = "";
    });

    $(".double").each(function(index){
        //alert(formateNumber($(this).val()))
        //$(this).val(formatDouble($(this).val()));
        //$(this).html(formateNumber($(this).html()))

    });
    $('.image-control').hover(function () {
        $('.btnSelectImage').show();
        $('.image-control button').show();
    }, function () {

        if($('.image-control img').attr('src')!='')
        {
            $('.btnSelectImage').hide();
            $('.image-control button').hide();
        }

    })
}

function toDateNumber(num)
{
    if(num<10)
        return "0"+num;
    else
        return num;
}
function dateShow(dt)
{
    dt = new Date(dt);
    return toDateNumber(dt.getDate())+ "-" + toDateNumber(dt.getMonth()+1) + "-"+dt.getFullYear();
}
function timeShow(dt) {
    dt = new Date(dt);
    var time = "";
    if(dt.getHours()<12)
    {
        time = dt.getHours() + ":"+toDateNumber(dt.getMinutes())+" am";
    }
    else
    {
        if(dt.getHours() == 12)
            time = dt.getHours() + ":"+toDateNumber(dt.getMinutes())+" pm";
        else
            time = time = dt.getHours() -12 + ":"+toDateNumber(dt.getMinutes())+" pm";
    }

    return time;
}
function dateView(datemysql)
{
    var t = datemysql.split(/[- :]/);

    var dt = new Date(t[0], t[1]-1, t[2], t[3], t[4], t[5]);
    //alert(dt.getFullYear())
    return dateShow(dt)
}

function timeView(datemysql)
{
    var t = datemysql.split(/[- :]/);
    var dt = new Date(t[0], t[1]-1, t[2], t[3], t[4], t[5]);
    return timeShow(dt);
}

function showFullDate(dt) {
    var d = new Date(dt);
    var day = new Array();
    day[0] = "Sunday";
    day[1] = "Monday";
    day[2] = "Tueday";
    day[3] = "Wednesday";
    day[4] = "Thursday";
    day[5] = "Friday";
    day[6] = "Saturday";
    var month = new Array();
    month[0] = "January";
    month[1] = "February";
    month[2] = "March";
    month[3] = "April";
    month[4] = "May";
    month[5] = "June";
    month[6] = "July";
    month[7] = "August";
    month[8] = "September";
    month[9] = "October";
    month[10] = "November";
    month[11] = "December";

    return day[d.getDay()]+ " "+d.getDate()+" "+month[d.getMonth()] + " "+timeShow(d);
}

function openDialog(url,width,height) {
    //var result = window.showModalDialog(url, "", "dialogWidth:"+width+"px; dialogHeight:"+height+"px;");
    win = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=0, left=0, width="+width+", height="+height);
}
function PrintElem(elem)
{
    var mywindow = window.open('', 'PRINT', 'height=400,width=600');

    mywindow.document.write('<html><head><title>' + document.title  + '</title>');
    mywindow.document.write('</head><body >');
    mywindow.document.write(document.getElementById(elem).innerHTML);
    mywindow.document.write('</body></html>');

    mywindow.document.close(); // necessary for IE >= 10
    mywindow.focus(); // necessary for IE >= 10*/

    mywindow.print();
    mywindow.close();

    return true;
}
function PrintHtml(html)
{
    var mywindow = window.open('', 'PRINT', 'height=500,width=800');

    mywindow.document.write('<html><head><title>' + document.title  + '</title>');
    mywindow.document.write('</head><body >');
    mywindow.document.write(html);
    mywindow.document.write('</body></html>');

    mywindow.document.close(); // necessary for IE >= 10
    mywindow.focus(); // necessary for IE >= 10*/
    setTimeout(function () {
        mywindow.print();
        mywindow.close();
    },2000)


    return true;
}
/***************************** DIALOG ******************************/
/*******************************************************************/
/*** SIMPLE DIALOG ***/
function showSimpleModal($title, $content, $callback, $text_cancel, $text_ok) {
    var $template = '<div id="simpleModal" class="modal fade" aria-hidden="true" aria-labelledby="simpleModalLabel" role="dialog" tabindex="-1" style="display: none;">';
    $template += '<div class="modal-dialog">';
    $template += '<div class="modal-content">';
    $template += '<div class="modal-header">';
    $template += '<button class="close" aria-hidden="true" data-dismiss="modal" type="button">Ã—</button>';
    $template += '<h4 id="simpleModalLabel" class="modal-title">'+ $title +'</h4>';
    $template += '</div>';
    $template += '<div class="modal-body">';
    $template += '<p>'+ $content +'</p>';
    $template += '</div>';
    $template += '<div class="modal-footer">';
    $template += '<button class="btn btn-default" type="button" onclick="closeSimpleModal()">'+ $text_cancel +'</button>';
    $template += '<button class="btn btn-primary" type="button" onclick="'+ $callback +'">'+ $text_ok +'</button>';
    $template += '</div></div></div></div>';

    $('body').append($template);
    $("#simpleModal").modal('show');
}

function closeSimpleModal() {
    var jSimpleModal = $("#simpleModal");
    jSimpleModal.modal('hide');
    $('.modal-backdrop').remove();
    jSimpleModal.remove();
}
function viewTransation(id,ordertype) {
    switch (ordertype)
    {
        case "ESA":
            return "?route=module/sale&id="+id;
        case "IPO":
        case "IPC":
        case "IIN":
        case "IRO":
            return "?route=module/import/update&id="+id;
        case "EIN":
        case "EPC":
        case "ERO":
        case "EDE":
            return "?route=module/export/view&id="+id;
        case "CHK":
            id = id.replace("CHK-",'');
            return "?route=module/checkinventory/update&id="+id;
    }
}
function viewOrder(orderid,ordertype) {
    var url = viewTransation(orderid,ordertype);
    window.open(url);
}
/*******************************************************************/
/***************************** END DIALOG **************************/
//File
function getFileName(fullPath) {
    if (fullPath) {
        var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
        var filename = fullPath.substring(startIndex);
        if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
            filename = filename.substring(1);
        }
        return filename;
    }
}
function download(data, filename, type) {
    var file = new Blob([data], {type: type});
    if (window.navigator.msSaveOrOpenBlob) // IE10+
        window.navigator.msSaveOrOpenBlob(file, filename);
    else { // Others
        var a = document.createElement("a"),
            url = URL.createObjectURL(file);
        a.href = url;
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        setTimeout(function() {
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);
        }, 0);
    }
}
$(document).ready(function () {
    numberReady();
});