class Papermaps.MapsController extends Batman.Controller

  routingKey: 'maps'

  show: ->
    do Papermaps.Photo.load