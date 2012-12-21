class Papermaps.MapsShowView extends Batman.View

  ready: ->
    mapOptions =
      zoom: 8
      center: new google.maps.LatLng 59.863216, 31.040608
      mapTypeId: google.maps.MapTypeId.ROADMAP

    new google.maps.Map($('.map-container')[0], mapOptions);
