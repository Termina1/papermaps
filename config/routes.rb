Papermaps::Application.routes.draw do

  require 'resque/server'
  mount Resque::Server.new, :at => "/resque"
  root 'home#index'

end
