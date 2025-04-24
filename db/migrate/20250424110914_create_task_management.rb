class CreateTaskManagement < ActiveRecord::Migration[7.2]
  def change
    create_table :task_managements do |t|
      t.string      :title
      t.text        :description
      t.date        :date
      t.datetime    :start_time
      t.datetime    :end_time
      t.references  :user
      t.string      :job_id
    end
  end
end
