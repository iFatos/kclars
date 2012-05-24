class CreateRsvps < ActiveRecord::Migration
  def self.up
    create_table :rsvps do |t|
      t.integer :student_id
      t.integer :group_id
      t.integer :event_id
      t.date :rsvpdate

      t.timestamps
    end
  end

  def self.down
    drop_table :rsvps
  end
end
