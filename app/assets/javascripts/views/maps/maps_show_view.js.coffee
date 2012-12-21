class Papermaps.MapsShowView extends Batman.View

  ready: ->
    mapOptions =
      zoom: 8
      center: new google.maps.LatLng 59.863216, 31.040608
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map($('.map-container')[0], mapOptions);

    @applyMarkers map

  applyMarkers: (map) ->
    Papermaps.Photo.get('all').forEach (el) ->
      (new Papermaps.GoogleMarkerPresenter el).toMarker()

