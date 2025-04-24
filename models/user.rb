class User < ActiveRecord::Base
  has_secure_password
  has_many :task_managements, dependent: :destroy
end
