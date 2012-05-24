class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :city
      t.string :address
      t.integer :group_id
      t.string :lon
      t.string :lat
      t.time :time_t
      t.date :date_t
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
