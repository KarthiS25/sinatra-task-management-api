require 'active_model_serializers'
require_relative 'user_serializer'

class TaskMangementSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :date, :start_time, :end_time, :user

  def user
    ActiveModelSerializers::SerializableResource.new(object.user, serializer: UserSerializer)
  end
end
