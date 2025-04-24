class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string    :name
      t.string    :age
      t.string    :dob
      t.string    :phone_number
      t.string    :email
      t.string    :password_digest
      t.boolean   :admin, default: false

      t.timestamps
    end
  end
end
