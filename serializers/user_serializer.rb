class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :dob, :phone_number, :email
end
