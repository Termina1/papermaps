Papermaps::Application.routes.draw do

  resources :photos

  require 'resque/server'
  mount Resque::Server.new, :at => "/resque"

  root 'photos#show'

end
