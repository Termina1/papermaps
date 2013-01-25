window.Papermaps = class Papermaps extends Batman.App

  Batman.ViewStore.prefix = 'assets/views'

  @root 'maps#show'

  @on 'run', ->
    for key, value of JST
      try
        Batman.View.store.set key.split('/').slice(1).join('/'), value()
      catch e