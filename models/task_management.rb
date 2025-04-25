require_relative '../jobs/task_management_job'

class TaskManagement < ActiveRecord::Base
  belongs_to :user

  after_commit :trigger_mail_job
  validates :title, presence: true, uniqueness: { scope: :user_id, message: "has already been taken for this user" }

  def trigger_mail_job
    if saved_changes_to_start_time?
      remove_existing_job if self.job_id.present?

      jid = TaskManagementJob.perform_at(self.start_time - 1.hours, self.id)
      self.update(job_id: jid)
    end
  end

  def remove_existing_job
    scheduled = Sidekiq::ScheduledSet.new
    scheduled.select { |job| job.delete if self.job_id == job.jid.to_s }
    self.update(job_id: nil)
  end
end
