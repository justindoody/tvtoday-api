require 'dotenv'
require 'dotenv/tasks'
Dotenv.load '.env.deploy'

require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :user, ENV['REMOTE_USER']
set :domain, ENV['DOMAIN']
set :identity_file, ENV['SSH_KEY']
set :port, ENV['REMOTE_PORT']
set :deploy_to, ENV['DEPLOY_TO']
set :repository, ENV['REPO']
set :branch, 'master'

set :shared_paths, ['log', '.env.production']
set :rvm_path, ENV['RVM_PATH']

task :environment do
  invoke :'rvm:use[default]'
end

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! "touch \"#{deploy_to}/shared/.env.production\""
  queue  "echo \"-----> Be sure to edit 'shared/.env.production'.\""
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
    to(:launch) { invoke :restart }
  end
end

task :restart do
  queue "passenger-config restart-app #{deploy_to}"
end