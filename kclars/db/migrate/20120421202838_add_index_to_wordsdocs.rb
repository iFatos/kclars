class AddIndexToWordsdocs < ActiveRecord::Migration
  def self.up
   add_index :wordsdocs, :docid
   add_index :wordsdocs, :tf
  end

  def self.down
   remove_index :wordsdocs, :docid
   remove_index :wordsdocs, :tf
  end
end
