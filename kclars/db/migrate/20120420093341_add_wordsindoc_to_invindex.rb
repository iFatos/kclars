class AddWordsindocToInvindex < ActiveRecord::Migration
  def self.up
    add_column :invindices, :wordsindoc, :text
  end

  def self.down
    remove_column :invindices, :wordsindoc
  end
end
