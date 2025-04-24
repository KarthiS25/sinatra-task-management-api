require 'sinatra/base'
require 'sinatra/contrib'
require 'active_model_serializers'
require_relative '../serializers/task_management_serializer'
require 'pry'

class TaskMangementsController < Sinatra::Base
  helpers UserHelper
  register Sinatra::ActiveRecordExtension
  helpers Sinatra::JSON

  before do
    protected!
    content_type :json
  end

  get '/tasks' do
    if current_user.admin?
      @task_managements = TaskManagement.all
    else
      @task_managements = current_user.task_managements
    end

    response = ActiveModelSerializers::SerializableResource.new(@task_managements, each_serializer: TaskMangementSerializer).as_json
    response.to_json
  end

  post '/tasks' do
    request_payload = JSON.parse(response.body.read)
    title = request_payload[:title]
    description = request_payload[:description]
    date = request_payload[:date]
    start_time = request_payload[:start_time]
    end_time = request_payload[:end_time]
    @task_management = current_user.task_managements.create(title: title,
                                                            description: description,
                                                            date: date,
                                                            start_time: start_time,
                                                            end_time: end_time
                                                            )

    response = ActiveModelSerializers::SerializableResource.new(@task_management, serializer: TaskMangementSerializer).as_json
    response.to_json
  end
end
