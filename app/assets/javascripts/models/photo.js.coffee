class Papermaps.Photo extends Batman.Model
  @storageKey: 'photos'
  @persist Batman.RailsStorage

  @encode 'username'
  @encode 'urls'
  @encode 'gps'
  @encode 'description'
  @encode 'data', Batman.Encoders.railsDate
