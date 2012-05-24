class CreateStdregisters < ActiveRecord::Migration
  def self.up
    create_table :stdregisters do |t|
      t.string :stdid
      t.text :modules
      t.string :tutor

      t.timestamps
    end
  end

  def self.down
    drop_table :stdregisters
  end
end
