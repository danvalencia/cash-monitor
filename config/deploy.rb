require "bundler/capistrano"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, "Cash Monitor"
set :repository,  "git@bitbucket.org:danvalencia/cashmonitor-2.git"

set :scm, :git

production_server = "ec2-54-245-26-209.us-west-2.compute.amazonaws.com"

role :web, production_server                          # Your HTTP server, Apache/etc
role :app, production_server                          # This may be the same as your `Web` server
role :db,  production_server, :primary => true # This is where Rails migrations will run

set :user, "ubuntu"
set :use_sudo, false

before "deploy:finalize_update" do
  run "rm -f #{release_path}/config/database.yml; ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "mkdir -p #{release_path}/tmp"
  run "ln -nfs #{shared_path}/sockets #{release_path}/tmp/sockets"
end

namespace :deploy do
  task :start do
    run "sudo bluepill load /etc/bluepill/#{application}.pill"
  end
  task :stop do
    run "sudo bluepill #{application} stop"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "sudo bluepill #{application} restart"
  end
  task :status do
    run "sudo bluepill #{application} status"
  end
  task :schema_load, :roles => :db, :primary => true do
    run "cd #{current_path} && rake db:schema:load RAILS_ENV=#{rails_env}"
  end
end