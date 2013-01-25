class Papermaps.GoogleMarkerPresenter
  constructor: (@model) ->

  toMarker: (map) ->
    html = JST['views/maps/marker'] @model
    gps = @model.gps()
    position = new google.maps.LatLng(gps[0], gps[1])
    marker = new InfoBubble
      map: map,
      content: html,
      position: position,
      shadowStyle: 0,
      padding: 0,
      backgroundColor: 'none',
      borderRadius: 4,
      arrowSize: 0,
      borderWidth: 0,
      disableAutoPan: true,
      hideCloseButton: true,
      backgroundClassName: 'phoney',
    #google.maps.InfoWindow maxWidth: 500, content: html, position: position, zIndex: 100
    marker.open map