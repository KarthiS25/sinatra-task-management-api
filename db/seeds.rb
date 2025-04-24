require 'active_support/core_ext/integer/time'

users = []
users << { email: "john.admin@exampl.com", password: "Password$5000", name: "John", age: "25", dob: "25/11/1998", admin: true }
users << { email: "john@exampl.com", password: "Password$5000", name: "John", age: "25", dob: "25/11/1998", admin: false }

puts "User creation start"
User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!("users")

User.create(users)

puts "Users created successfully..."

puts "Task management create start"
TaskManagement.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!("task_managements")

user = User.where(admin: false).first
TaskManagement.create(title: "Event booking", description: "Sample text", date: Time.now.utc + 5.days, start_time: Time.now.utc + 5.days, end_time: Time.now.utc + 5.days + 2.hours, user_id: user.id)

puts "Task created successfully..."
