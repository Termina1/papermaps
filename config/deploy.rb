require "bundler/capistrano"

set :rvm_ruby_string, '1.9.3@swissamhell'
require "rvm/capistrano"

set :puma_port, 8080

server "62.76.191.134", :web, :app, :db, primary: true

load 'deploy/assets'

set :application, "papermaps"
set :user, "terminal"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:Termina1/papermaps.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do

  task :setup_config, roles: :app do
    #sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    #sudo "ln -nfs #{current_path}/config/puma_init.sh /etc/init.d/puma_#{application}"
    run "mkdir -p #{shared_path}/config"
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/puma.rb #{release_path}/config/puma.rb"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

namespace :puma do
  desc "Start Puma"
  task :start, :except => { :no_release => true } do
    commands = ["#{sudo} start puma_papermaps"]
    run commands.join(" ")
  end
  after "deploy:start", "puma:start"

  desc "Stop Puma"
  task :stop, :except => { :no_release => true } do
    run "#{sudo} stop puma_papermaps"
  end
  after "deploy:stop", "puma:stop"

  desc "Restart Puma"
  task :restart, roles: :app do
    run "#{sudo} stop puma_papermaps"
    run "#{sudo} start puma_papermaps"
  end
  after "deploy:restart", "puma:restart"
end