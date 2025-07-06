require 'sinatra/base'
require 'sinatra/contrib'
require 'active_model_serializers'
require_relative '../serializers/task_management_serializer'

class TaskMangementsController < Sinatra::Base
  helpers UserHelper
  register Sinatra::ActiveRecordExtension
  helpers Sinatra::JSON
  register Sinatra::Namespace

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
    update_params = request_payload.slice("id", "title", "description", "date", "start_time", "end_time")
  end

  def get_task_management(id)
    @task_management = current_user.task_managements.find_by(id: id)
    halt 404, json(message: "Task not found") unless @task_management
  end

  def error_message
    halt 422, json(message: @task_management.errors.full_messages[0])
  end

  namespace '/api/v1' do
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
        error_message
      end
    end

    put '/tasks/:id' do
      get_task_management(params[:id])
      error_message unless @task_management.update(update_params)

      halt 200, json(message: "Task updated successfully")
    end

    delete '/tasks/:id' do
      get_task_management(params[:id])
      error_message unless @task_management.destroy
      halt 200, json(message: "Task deleted successfully")
    end
  end
end
