require_relative '../config/sidekiq'

class TaskManagementJob
  include Sidekiq::Worker

  def perform(task_id)
    @tm = TaskManagement.find_by(id: task_id)

    if @tm.present?
      @user = @tm.user
      if @user.present? && @user.email.present?
        puts "Email send to #{@user.email}"
      end
    end
  end
end
