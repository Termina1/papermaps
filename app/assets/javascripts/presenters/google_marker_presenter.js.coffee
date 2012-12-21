class Papermaps.GoogleMarkerPresenter
  constructor: (@model) ->

  toMarker: (map) ->
    html = JST['views/maps/marker'] @model
    gps = @model.gps()
    position = new google.maps.LatLng(gps[0], gps[1])
    marker = new google.maps.InfoWindow maxWidth: 500, content: html, position: position, zIndex: 100
    marker.open map