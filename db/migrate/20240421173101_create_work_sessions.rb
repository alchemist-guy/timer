class CreateWorkSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :work_sessions do |t|
      t.datetime :start_time, null: false                # When the session started
      t.datetime :end_time 
      t.integer :user_id

      t.timestamps
    end
  end
end
