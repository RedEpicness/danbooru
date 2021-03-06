set :user, "danbooru"
set :rails_env, "production"
set :delayed_job_workers, 8

append :linked_files, ".env.production"

server "fribooru", :roles => %w(web app cron worker), :primary => true
#server "shima", :roles => %w(web app)
#server "saitou", :roles => %w(web app)
#server "oogaki", :roles => %w(worker)

set :rbenv_ruby, "2.7.0"
#set :rbenv_prefix, "/usr/bin/rbenv"

set :newrelic_appname, "FRIbooru"
after "deploy:finished", "newrelic:notice_deployment"
