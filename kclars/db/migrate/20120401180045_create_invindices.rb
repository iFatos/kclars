class CreateInvindices < ActiveRecord::Migration
  def self.up
    create_table :invindices do |t|
      t.string :word
      t.text :docid
      t.integer :frequency
      

      t.timestamps
    end
  end

  def self.down
    drop_table :invindices
  end
end
