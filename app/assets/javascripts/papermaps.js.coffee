window.Papermaps = class Papermaps extends Batman.App
  
  Batman.ViewStore.prefix = 'assets/views'

  @root 'maps#show'

  @on 'run', ->

  @on 'ready', ->
    console?.log "Papermaps ready for use."