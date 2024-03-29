class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.string :title
      t.date :ndate
      t.time :ntime
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :departments
  end
end
