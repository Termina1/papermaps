Papermaps::Application.routes.draw do

  resources :photos, only: [:show, :index]

  require 'resque/server'
  mount Resque::Server.new, :at => "/resque"

  root 'photos#show'

end
