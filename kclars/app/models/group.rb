require 'kaminari'
class Group < ActiveRecord::Base
 attr_accessible :title, :description, :city, :zip, :groupkey, :topics
 has_many :events
 scope :search, lambda {|val| where("description LIKE ?","%#{val}%") } 
def self.search(search)
   if search
    find(:all, :conditions => ['description LIKE ? or title LIKE ?', "%#{search}%", "%#{search}%"])
   else
    find(:all)
   end

 end
end
