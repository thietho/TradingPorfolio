// dom ready
$(function () {
    if (window.google && google.maps) {
        // Map script is already loaded
        initializeMap();
    } else {
        lazyLoadGoogleMap();
    }
});

function lazyLoadGoogleMap() {
    $.getScript("http://maps.google.com/maps/api/js?sensor=true&callback=initializeMap")
        .done(function (script, textStatus) {
            //alert("Google map script loaded successfully");
        })
        .fail(function (jqxhr, settings, ex) {
            //alert("Could not load Google Map script: " + jqxhr);
        });
}

function initializeMap() {
    initialize($lat, $lng, $zoom);
}

function initialize(x, y, zoom) {
    var geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(x, y);
    var myOptions =
    {
        zoom: zoom,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

    var markerobj = new google.maps.Marker({
        map: map,
        position: latlng,
        draggable: false
    });
}