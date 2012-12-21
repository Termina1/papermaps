class Papermaps.Photo extends Batman.Model
  @storageKey: 'photos'
  @persist Batman.RailsStorage

  @encode 'username'
  @encode 'urls'
  @encode 'gps'
  @encode 'description'
  @encode 'time'
  @encode 'low_resolution_image_url'
  @encode 'standard_resolution_image_url'
  @encode 'thumbnail_image_url'
  @encode 'latitude'
  @encode 'longitude'

  thumb: ->
    @get 'thumbnail_image_url'

  gps: ->
    [@get('latitude'), @get('longitude')]
