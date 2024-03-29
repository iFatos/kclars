class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups, do |t|
      t.string :title
      t.text :description
      t.string :city
      t.string :zip
      t.string :groupkey
      t.text :topics
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
