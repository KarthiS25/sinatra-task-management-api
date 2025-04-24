require 'sinatra'
require "sinatra/activerecord"
require 'sinatra/reloader'
require 'active_model_serializers'
require 'sinatra/contrib'
require 'securerandom'
require 'dotenv/load'

set :port, 3000

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