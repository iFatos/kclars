class CreateWordsdocs < ActiveRecord::Migration
  def self.up
    create_table :wordsdocs do |t|
      t.integer :docid
      t.integer :words
      t.text :tf
      t.timestamps
    end
  add_index :wordsdocs, :docid
  add_index :wordsdocs, :tf
  add_index :wordsdocs, :words

  end
  
  def self.down
    drop_table :wordsdocs
  end
end
