class Papermaps.MapsController extends Batman.Controller

  routingKey: 'maps'

  show: ->
    Papermaps.Photo.load =>
      console.log 111