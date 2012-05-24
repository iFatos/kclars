class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :event_id
      t.integer :student_id
      t.float :vote
      t.timestamps
    end
  add_index :votes, :student_id
  add_index :votes, :event_id
  add_index :votes, [:student_id, :event_id], :unique => true
  end
 
  def self.down
    drop_table :votes
  end
end
