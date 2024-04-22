class CreateDesktime < ActiveRecord::Migration[7.1]
  def change
    create_table :desktimes do |t|
      t.datetime :date
      t.integer :duration
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
