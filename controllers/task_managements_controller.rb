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

  def create_params
    request_payload = JSON.parse(request.body.read)
    create_params = request_payload.slice("title", "description", "date", "start_time", "end_time")
  end

  def update_params
    request_payload = JSON.parse(request.body.read)
    create_params = request_payload.slice("id", "title", "description", "date", "start_time", "end_time")
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
    @task_management = current_user.task_managements.new(create_params)
    if @task_management.save
      response = ActiveModelSerializers::SerializableResource.new(@task_management, serializer: TaskMangementSerializer).as_json
      response.to_json
    else
      status 422
      json(message: @task_management.errors.full_messages[0])
    end
  end

  put '/tasks/:id' do
    @task_management = current_user.task_managements.find_by(id: params[:id])

    if @task_management.present?
      @task_management.update(update_params)
      status 200
      json(message: "Task updated successfully")
    else
      status 404
      json(message: "Task not found")
    end
  end
end
