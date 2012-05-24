class AddTfToWordsdocs < ActiveRecord::Migration
  def self.up
    add_column :wordsdocs, :tf, :text
  end

  def self.down
    remove_column :wordsdocs, :tf
  end
end
