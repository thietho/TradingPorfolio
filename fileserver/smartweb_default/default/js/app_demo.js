"use strict";var app_demo={page_like:{load:function(){var a=window.location.href;$.get("assets/php/get_likes.php?page="+a,function(a){$("#page-like").html('<span class="icon-heart"></span> '+a+" likes")}),$("#page-like").on("click",function(){return $.get("assets/php/like.php?page="+a,function(a){$("#page-like").html('<span class="icon-heart"></span> '+a+" likes")}),$(this).unbind("click"),!1})}},solutions:{bank:{change_password:function(){$("#show_password").change(function(){$(this).is(":checked")?$("#old_password, #rep_password, #new_password").attr("type","text"):$("#old_password, #rep_password, #new_password").attr("type","password")})},change_pin:function(){$("#modal-change-pin").on("shown.bs.modal",function(){$("input.mask_pin").mask("99-99"),$("input.mask_pin").focus()})}}},googlemap:function(){if($("#google_world_map").length>0){var a=new google.maps.LatLng(0,0),b={zoom:1,center:a,mapTypeId:google.maps.MapTypeId.ROADMAP};new google.maps.Map(document.getElementById("google_world_map"),b)}if($("#google_map_markers").length>0){var d=new google.maps.LatLng(50.43,30.6),e={zoom:8,center:d,mapTypeId:google.maps.MapTypeId.ROADMAP},f=new google.maps.Map(document.getElementById("google_map_markers"),e),g=new google.maps.LatLng(50.37,30.65),g=(new google.maps.Marker({position:g,map:f,title:"Marker 1"}),new google.maps.LatLng(50.5,30.55)),g=(new google.maps.Marker({position:g,map:f,title:"Marker 2"}),new google.maps.LatLng(50.8,30.55));new google.maps.Marker({position:g,map:f,title:"Marker 3"})}if($("#google_map_style").length>0){var i=[{featureType:"landscape",stylers:[{saturation:-100},{lightness:65},{visibility:"on"}]},{featureType:"poi",stylers:[{saturation:-100},{lightness:51},{visibility:"simplified"}]},{featureType:"road.highway",stylers:[{saturation:-100},{visibility:"simplified"}]},{featureType:"road.arterial",stylers:[{saturation:-100},{lightness:30},{visibility:"on"}]},{featureType:"road.local",stylers:[{saturation:-100},{lightness:40},{visibility:"on"}]},{featureType:"transit",stylers:[{saturation:-100},{visibility:"simplified"}]},{featureType:"administrative.province",stylers:[{visibility:"off"}]},{featureType:"water",elementType:"labels",stylers:[{visibility:"on"},{lightness:-25},{saturation:-100}]},{featureType:"water",elementType:"geometry",stylers:[{hue:"#ffff00"},{lightness:-25},{saturation:-97}]}],j=new google.maps.LatLng(50.43,30.6),k={styles:i,zoom:8,center:j,mapTypeId:google.maps.MapTypeId.ROADMAP};new google.maps.Map(document.getElementById("google_map_style"),k)}},jvectormap:function(){$("#jvm-world-map").length>0&&$("#jvm-world-map").vectorMap({map:"world_mill_en",backgroundColor:"#F5F5F5",regionsSelectable:!0,regionStyle:{selected:{fill:"#4FB5DD"},initial:{fill:"#2D3349"}}}),$("#jvm-us_map").length>0&&$("#jvm-us_map").vectorMap({map:"us_aea_en",backgroundColor:"#F5F5F5",regionsSelectable:!0,regionStyle:{selected:{fill:"#4FB5DD"},initial:{fill:"#2D3349"}}}),$("#jvm-world-map-markers").length>0&&$("#jvm-world-map-markers").vectorMap({map:"world_mill_en",backgroundColor:"#F5F5F5",normalizeFunction:"polynomial",regionStyle:{selected:{fill:"#4FB5DD"},initial:{fill:"#2D3349"}},markerStyle:{initial:{fill:"#4FB5DD",stroke:"#2D3349"}},markers:[{latLng:[41.9,12.45],name:"Vatican City"},{latLng:[43.73,7.41],name:"Monaco"},{latLng:[-.52,166.93],name:"Nauru"},{latLng:[-8.51,179.21],name:"Tuvalu"},{latLng:[43.93,12.46],name:"San Marino"},{latLng:[47.14,9.52],name:"Liechtenstein"},{latLng:[7.11,171.06],name:"Marshall Islands"},{latLng:[17.3,-62.73],name:"Saint Kitts and Nevis"},{latLng:[3.2,73.22],name:"Maldives"},{latLng:[35.88,14.5],name:"Malta"},{latLng:[12.05,-61.75],name:"Grenada"},{latLng:[13.16,-61.23],name:"Saint Vincent and the Grenadines"},{latLng:[13.16,-59.55],name:"Barbados"},{latLng:[17.11,-61.85],name:"Antigua and Barbuda"},{latLng:[-4.61,55.45],name:"Seychelles"},{latLng:[7.35,134.46],name:"Palau"},{latLng:[42.5,1.51],name:"Andorra"},{latLng:[14.01,-60.98],name:"Saint Lucia"},{latLng:[6.91,158.18],name:"Federated States of Micronesia"},{latLng:[1.3,103.8],name:"Singapore"},{latLng:[1.46,173.03],name:"Kiribati"},{latLng:[-21.13,-175.2],name:"Tonga"},{latLng:[15.3,-61.38],name:"Dominica"},{latLng:[-20.2,57.5],name:"Mauritius"},{latLng:[26.02,50.55],name:"Bahrain"},{latLng:[.33,6.73],name:"S\xe3o Tom\xe9 and Pr\xedncipe"}]}),$("#jvm-us-map-labels").length>0&&$("#jvm-us-map-labels").vectorMap({map:"us_aea_en",backgroundColor:"#F5F5F5",regionStyle:{selected:{fill:"#4FB5DD"},initial:{fill:"#2D3349"}},regionLabelStyle:{initial:{fill:"#FFF"},hover:{fill:"#4FB5DD"}},labels:{regions:{render:function(a){var b=["US-RI","US-DC","US-DE","US-MD"];return-1===b.indexOf(a)?a.split("-")[1]:void 0},offsets:function(a){return{CA:[-10,10],ID:[0,40],OK:[25,0],LA:[-20,0],FL:[45,0],KY:[10,5],VA:[15,5],MI:[30,30],AK:[50,-25],HI:[25,50]}[a.split("-")[1]]}}}})},charts:{morris:function(){$("#morris-line-example").length>0&&(Morris.Line({element:"morris-line-example",data:[{y:"2006",a:100,b:90},{y:"2007",a:75,b:65},{y:"2008",a:50,b:40},{y:"2009",a:75,b:65},{y:"2010",a:50,b:40},{y:"2011",a:75,b:65},{y:"2012",a:100,b:90}],xkey:"y",ykeys:["a","b"],labels:["Series A","Series B"],resize:!0,lineColors:["#2D3349","#76AB3C"]}),Morris.Area({element:"morris-area-example",data:[{y:"2006",a:100,b:90},{y:"2007",a:75,b:65},{y:"2008",a:50,b:40},{y:"2009",a:75,b:65},{y:"2010",a:50,b:40},{y:"2011",a:75,b:65},{y:"2012",a:100,b:90}],xkey:"y",ykeys:["a","b"],labels:["Series A","Series B"],resize:!0,lineColors:["#4FB5DD","#F69F00"]}),Morris.Bar({element:"morris-bar-example",data:[{y:"2006",a:100,b:90},{y:"2007",a:75,b:65},{y:"2008",a:50,b:40},{y:"2009",a:75,b:65},{y:"2010",a:50,b:40},{y:"2011",a:75,b:65},{y:"2012",a:100,b:90}],xkey:"y",ykeys:["a","b"],labels:["Series A","Series B"],barColors:["#2D3349","#F04E51"]}),Morris.Donut({element:"morris-donut-example",data:[{label:"Download Sales",value:12},{label:"In-Store Sales",value:30},{label:"Mail-Order Sales",value:20}],colors:["#2D3349","#4FB5DD","#F04E51"]}))},rickshaw:function(){if($("#charts-lineplot").length>0){for(var a=[],b=[],c=[],d=0;10>d;d+=.3)a.push({x:d,y:Math.sin(d)}),c.push({x:d,y:Math.sin(d-1.57)}),b.push({x:d,y:Math.cos(d)});var e=new Rickshaw.Graph({element:document.getElementById("charts-lineplot"),renderer:"lineplot",min:-1.2,max:1.2,padding:{top:.1},series:[{data:a,color:"#2D3349",name:"sin"},{data:c,color:"#76AB3C",name:"sin2"},{data:b,color:"#4FB5DD",name:"cos"}]});new Rickshaw.Graph.HoverDetail({graph:e});e.render();var g=function(){e.configure({width:$("#charts-lineplot").width(),height:$("#charts-lineplot").height()}),e.render()};window.addEventListener("resize",g),g();for(var h=[[],[],[]],i=new Rickshaw.Fixtures.RandomData(50),d=0;50>d;d++)i.addData(h);var j=new Rickshaw.Graph({element:document.getElementById("charts-lines"),renderer:"line",min:50,series:[{color:"#76AB3C",data:h[0],name:"New York"},{color:"#4FB5DD",data:h[1],name:"London"},{color:"#F04E51",data:h[2],name:"Tokyo"}]});j.render();var l=(new Rickshaw.Graph.HoverDetail({graph:j}),new Rickshaw.Graph.Axis.Time({graph:j}));l.render();var m=function(){j.configure({width:$("#charts-lines").width(),height:$("#charts-lines").height()}),j.render()};window.addEventListener("resize",m),m();var n=new Rickshaw.Graph({unstack:!0,element:document.querySelector("#charts-column"),min:30,renderer:"bar",series:[{color:"#2D3349",data:[{x:0,y:50},{x:1,y:52},{x:2,y:36},{x:3,y:42},{x:4,y:36},{x:5,y:50}]},{color:"#4FB5DD",data:[{x:0,y:48},{x:1,y:40},{x:2,y:45},{x:3,y:32},{x:4,y:33},{x:5,y:45}]},{color:"#F04E51",data:[{x:0,y:43},{x:1,y:35},{x:2,y:46},{x:3,y:49},{x:4,y:34},{x:5,y:42}]}]});n.render();var o=function(){n.configure({width:$("#charts-column").width(),height:$("#charts-column").height()}),n.render()};new Rickshaw.Graph.HoverDetail({graph:n});window.addEventListener("resize",o),o();for(var h=[[],[],[]],i=new Rickshaw.Fixtures.RandomData(100),d=0;100>d;d++)i.addData(h);var p=new Rickshaw.Graph({element:document.getElementById("charts-legend"),renderer:"area",width:$("#charts-legend").width(),series:[{color:"#2D3349",data:h[0],name:"Total"},{color:"#4FB5DD",data:h[1],name:"New"},{color:"#F04E51",data:h[2],name:"Returned"}]});p.render();var q=new Rickshaw.Graph.Legend({graph:p,element:document.getElementById("legend")}),u=(new Rickshaw.Graph.Behavior.Series.Toggle({graph:p,legend:q}),new Rickshaw.Graph.Behavior.Series.Order({graph:p,legend:q}),new Rickshaw.Graph.Behavior.Series.Highlight({graph:p,legend:q}),function(){p.configure({width:$("#charts-legend").width(),height:$("#charts-legend").height()}),p.render()});window.addEventListener("resize",u),u()}}}};$(function(){app_demo.googlemap(),app_demo.jvectormap(),app_demo.solutions.bank.change_password(),app_demo.solutions.bank.change_pin(),app_demo.charts.morris(),app_demo.charts.rickshaw(),setTimeout(function(){app_demo.page_like.load()},1e3)});
/* IN DOWNLOADED PACKAGE YOU WILL FIND WELL STRUCTURED, FORMATTED AND COMMENTED SOURCE CODE */