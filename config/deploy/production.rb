set :stage, :production
set :rails_env, :production
set :deploy_to, "/home/deploy/apps/spree_deploy"
set :branch, :master
server "13.250.113.48", user: "deploy", roles: %w(web app db)