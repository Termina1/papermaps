class Papermaps.MapsController extends Batman.Controller

  routingKey: 'maps'

  show: ->
    @set 'maps', {}