"use strict";var app_demo_dashboard={
    rickshaw:function(){
        if($("#dashboard-chart-line").length>0)
        {
            var a=[
                {x:0,y:14},
                {x:1,y:12},
                {x:2,y:18},
                {x:3,y:17},
                {x:4,y:15},
                {x:5,y:11},
                {x:6,y:15},
                {x:7,y:13},
                {x:8,y:16},
                {x:9,y:18},
                {x:10,y:16},
                {x:11,y:18},
                {x:12,y:16},
                {x:13,y:15},
                {x:14,y:15},
                {x:15,y:15},
                {x:16,y:17},
                {x:17,y:16},
                {x:18,y:19},
                {x:19,y:20},
                {x:20,y:22},
                {x:21,y:23},
                {x:22,y:21},
                {x:23,y:18},
                {x:24,y:19},
                {x:25,y:15},
                {x:26,y:16},
                {x:27,y:17},
                {x:28,y:19},
                {x:29,y:22},
                {x:30,y:24}],
                b=[
                    {x:0,y:12},
                    {x:1,y:10},
                    {x:2,y:14},
                    {x:3,y:15},
                    {x:4,y:11},
                    {x:5,y:9},
                    {x:6,y:14},
                    {x:7,y:12},
                    {x:8,y:13},
                    {x:9,y:16},
                    {x:10,y:15},
                    {x:11,y:16},
                    {x:12,y:13},
                    {x:13,y:10},
                    {x:14,y:8},
                    {x:15,y:11},
                    {x:16,y:13},
                    {x:17,y:15},
                    {x:18,y:16},
                    {x:19,y:19},
                    {x:20,y:20},
                    {x:21,y:19},
                    {x:22,y:17},
                    {x:23,y:14},
                    {x:24,y:15},
                    {x:25,y:12},
                    {x:26,y:14},
                    {x:27,y:13},
                    {x:28,y:15},
                    {x:29,y:18},
                    {x:30,y:21}],
                c=new Rickshaw.Graph({
                    element:document.getElementById("dashboard-chart-line"),
                    renderer:"lineplot",
                    min:5,
                    max:25,
                    padding:{top:10},
                    series:[{
                        data:a,
                        color:"#2D3349",
                        name:"Purchase click"
                    },
                        {
                            data:b,
                            color:"#76AB3C",
                            name:"Sales"
                        }
                    ]
                });
            new Rickshaw.Graph.Axis.X({
                graph:c,orientation:"bottom",
                element:document.querySelector("#xaxis")
            }),
                new Rickshaw.Graph.Axis.Y({
                    graph:c,
                    orientation:"left",
                    element:document.querySelector("#yaxis")});
            new Rickshaw.Graph.HoverDetail({
                graph:c,formatter:function(a,b,c){
                    var d='<span class="detail_swatch" style="background-color: '+a.color+'"></span>',
                        e=d+a.name+": "+parseInt(c)+"<br>";
                    return e
                }
            }),
                c.render();
            var f=function(){
                c.configure({
                    width:$("#dashboard-chart-line").width(),
                    height:$("#dashboard-chart-line").height()
                }),
                    c.render()};
            window.addEventListener("resize",f),f()
        }
    },
    map:function(){
        if($("#dashboard-map").length>0){
            var a=[];
            a.names=["Shopnumone","Best Shoptwo","Third Awesome","Alltranding","Shop Name"],
                a.sales=["135","121","107","83","77"],
                $("#dashboard-map").vectorMap({
                    map:"us_aea_en",
                    backgroundColor:"#FFF",
                    regionsSelectable:!1,
                    regionStyle:{
                        selected:{fill:"#2D3349"},
                        initial:{fill:"#DBE0E4"}},
                    markers:[[61.18,-149.53],[21.18,-157.49],[40.66,-73.56],[41.52,-87.37],[35.22,-80.84]],
                    markerStyle:{initial:{fill:"#2D3349",stroke:"#2D3349"}},
                    onMarkerTipShow:function(b,c,d){
                        c.html("<b>"+a.names[d]+"</b><br/><b>Sales: </b>"+a.sales[d]+"</br>")
                    }
                })
        }
    }
};
$(function(){app_demo_dashboard.rickshaw(),app_demo_dashboard.map()});
/* IN DOWNLOADED PACKAGE YOU WILL FIND WELL STRUCTURED, FORMATTED AND COMMENTED SOURCE CODE */