set :application,     'galp'                  # le nom de l’application
set :domain,          'galp.selectra.info'    # le domaine internet de l’application
set :rvm_ruby_string, '2.0.0-p0'                # la version de ruby utilisée
set :unicorn_workers, 1                         # le nombre de worker unicorn (un seul pour le staging)

require 'capistrano/selectra'

# Décommenter les lignes suivantes en fonction des besoins de notre application
# load "selectra/carrierwave"
load "selectra/nginx"
load "selectra/postgresql"
#load "selectra/rvm"
#load "selectra/sidekiq"
load "selectra/unicorn"
load "selectra/figaro"
#load "selectra/airbrake"
#load "selectra/sitemaps"
#load "selectra/whenever"