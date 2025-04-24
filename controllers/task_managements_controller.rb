require 'sinatra/base'
require 'sinatra/contrib'
require 'active_model_serializers'
require_relative '../serializers/task_management_serializer'

class TaskMangementsController < Sinatra::Base
  helpers UserHelper
  register Sinatra::ActiveRecordExtension
  helpers Sinatra::JSON

  before do
    content_type :json
  end

  get '/tasks' do
    @tasks = TaskManagement.all

    response = ActiveModelSerializers::SerializableResource.new(@tasks, each_serializer: TaskMangementSerializer).as_json
    response.to_json
  end

  # post '/tasks' do

  # end
end
