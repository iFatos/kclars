class AddQueryvectorToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :queryvector, :text
  end

  def self.down
    remove_column :students, :queryvector
  end
end
