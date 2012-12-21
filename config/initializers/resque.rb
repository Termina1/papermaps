require 'resque'
Resque.redis = "localhost:6379"

require 'resque_scheduler'
require 'resque_scheduler/server'