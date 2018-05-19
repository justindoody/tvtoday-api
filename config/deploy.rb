require 'dotenv'
require 'dotenv/tasks'
Dotenv.load '.env.deploy'

require 'mina/git'
require 'mina/rails'
require 'mina/rvm'

set :user, ENV['REMOTE_USER']
set :domain, ENV['DOMAIN']
set :identity_file, ENV['SSH_KEY']
set :port, ENV['REMOTE_PORT']
set :deploy_to, ENV['DEPLOY_TO']
set :repository, ENV['REPO']
set :branch, 'master'

set :shared_dirs, fetch(:shared_dirs, []).push('log')
set :shared_files, fetch(:shared_files, []).push('.env.production')
set :rvm_path, ENV['RVM_PATH']

task :remote_environment do
  invoke :'rvm:use', '2.3.7@default'
end

# task :setup do
#   command! %[mkdir -p "#{shared_path}/log"]
#   command! %[chmod g+rx,u+rwx "#{shared_path}/log"]

#   command! "touch \"#{shared_path}/.env.production\""
#   comment "Be sure to edit 'shared/.env.production'."
# end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
    invoke :'bundle:clean'
    on(:launch) { invoke :restart }
  end
end

task :restart do
  comment 'Restart application'
  command "passenger-config restart-app #{fetch(:deploy_to)}"
end