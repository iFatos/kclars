class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :name
      t.string :username
      t.string :stdid
      t.string :email
      t.string :password
      t.text   :bhistory
      t.text :modules
      t.text :rsvps
      t.string :tutor

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
