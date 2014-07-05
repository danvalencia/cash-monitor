set :application, "CashMonitor"

unicorn_pid = "/tmp/unicorn.pid"

set :unicorn_pid, unicorn_pid 

# set :rake, lambda { "#{fetch(:bundle_cmd, "bundle")} exec rake" }

# set(:latest_release)  { fetch(:current_path) }
# set(:release_path)    { fetch(:current_path) }
# set(:current_release) { fetch(:current_path) }

# set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
# set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
# set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

# Use our ruby-1.9.2-p290@my_site gemset
# default_environment["PATH"]         = "--"
# default_environment["GEM_HOME"]     = "--"
# default_environment["GEM_PATH"]     = "--"
# default_environment["RUBY_VERSION"] = "ruby-1.9.2-p290"

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
# set :format, :pretty
# set :log_level, :debug

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5
# namespace :previous_deploy do

#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       # Your restart mechanism here, for example:
#       # execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end

#   after :finishing, 'deploy:cleanup'

# end

namespace :deploy do

  desc "Deploy your application"
  task :default do
    update
    force_restart
  end

  # desc "Setup your git-based deployment app"
  # task :setup do
  #   dirs = [fetch(:deploy_to), fetch(:shared_path)]
  #   dirs += fetch(:shared_children).map { |d| File.join(fetch(:shared_path), d) }
  #   run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
  #   run "git clone #{repository} #{current_path}"
  # end

  # task :precompile do
  #   on :app, reject: lambda { |h| h.properties.no_release } do
  #     within fetch(:latest_release_directory)
  #       with rails_env: fetch(:rails_env) do
  #         execute :rake, 'assets:precompile'
  #       end
  #     end
  #   end
  # end

  task :cold do
    update
    migrate
  end

  task :update do
    transaction do
      update_code
    end
  end

  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end
 

  # desc "Update the deployed code."
  # task :update_code, reject: lambda{ |h| h.properties.no_release } do
  #   within fetch(:latest_release_directory)
  #     with rails_env: fetch(:rails_env) do
  #       execute :rake, 'assets:precompile'
  #     end
  #   end
  # end

  #   run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
  #   finalize_update
  # end

  # desc "Update the database (overwritten to avoid symlink)"
  # task :migrations do
  #   transaction do
  #     update_code
  #   end
  #   migrate
  #   restart
  # end

  # task :finalize_update, :except => { :no_release => true } do
  #   run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

  #   # mkdir -p is making sure that the directories are there for some SCM's that don't
  #   # save empty folders
  #   run <<-CMD
  #     sudo rm -rf #{latest_release}/log #{latest_release}/public/system #{latest_release}/tmp/pids &&
  #     mkdir -p #{latest_release}/public &&
  #     mkdir -p #{latest_release}/tmp &&
  #     ln -s #{shared_path}/log #{latest_release}/log &&
  #     ln -s #{shared_path}/system #{latest_release}/public/system &&
  #     ln -s #{shared_path}/pids #{latest_release}/tmp/pids &&
  #     ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml
  #   CMD

  #   if fetch(:normalize_asset_timestamps, true)
  #     stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
  #     asset_paths = fetch(:public_children, %w(images stylesheets javascripts)).map { |p| "#{latest_release}/public/#{p}" }.join(" ")
  #     run "find #{asset_paths} -exec touch -t #{stamp} {} ';'; true", :env => { "TZ" => "UTC" }
  #   end
  # end

  desc "Zero-downtime restart of Unicorn"
  task :restart do
    on roles(:app), reject: lambda { |h| h.properties.no_release } do
      execute :kill, "-s USR2 `cat #{unicorn_pid}`" 
    end
  end

  desc "Force a restart of Unicorn"
  task :force_restart do
    stop
    start
  end

  desc "Start unicorn"
  task :start do
    on roles(:app), reject: lambda { |h| h.properties.no_release } do
      execute "cd #{current_path} && /usr/local/rvm/bin/rvm default do bundle exec unicorn_rails -c config/unicorn.rb -E production -D" 
    end
  end

  desc "Stop unicorn"
  task :stop do
    on roles(:app), reject: lambda { |h| h.properties.no_release } do
      execute :kill, "-s QUIT `cat #{unicorn_pid}`" 
    end
  end

  # namespace :rollback do
  #   desc "Moves the repo back to the previous version of HEAD"
  #   task :repo, :except => { :no_release => true } do
  #     set :branch, "HEAD@{1}"
  #     deploy.default
  #   end

  #   desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
  #   task :cleanup, :except => { :no_release => true } do
  #     run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
  #   end

  #   desc "Rolls back to the previously deployed version."
  #   task :default do
  #     rollback.repo
  #     rollback.cleanup
  #   end
  # end
end

def run_rake(cmd)
  run "cd #{current_path}; #{rake} #{cmd}"
end
