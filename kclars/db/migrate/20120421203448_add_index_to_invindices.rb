class AddIndexToInvindices < ActiveRecord::Migration
  def self.up
   add_index :invindices, :word
   add_index :invindices, :docid
  end

  def self.down
   remove_index :invindices, :word
   remove_index :invindices, :docid
  end
end
