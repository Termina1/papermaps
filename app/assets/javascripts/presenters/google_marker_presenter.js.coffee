class Papermaps.GoogleMarkerPresenter
  constructor: (@model) ->

  toMarker: ->
    html = JST['views/maps/marker']()
    console.log @model
    #marker = google.maps.InfoWindow content: html, position: new google.maps.