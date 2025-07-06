require 'sinatra'
require "sinatra/activerecord"
require 'sinatra/reloader'
require 'active_model_serializers'
require 'sinatra/contrib'
require 'securerandom'
require 'dotenv/load'
require 'redis'
require_relative 'config/sidekiq'

set :port, 3000
set :environment, ENV['APP_ENV'] || :development

# Models
require_relative 'models/user'
require_relative 'models/task_management'

# Helpers
require_relative 'helpers/user_helper'

# Controllers
require_relative 'controllers/users_controller'
require_relative 'controllers/task_managements_controller'
use UsersController
use TaskMangementsController