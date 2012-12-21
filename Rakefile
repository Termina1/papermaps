# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

require 'resque/tasks'
require 'resque_scheduler/tasks'
namespace :resque do
  task setup: :environment do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'
  end
end

Papermaps::Application.load_tasks
