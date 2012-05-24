class Event < ActiveRecord::Base
 belongs_to :group
 has_many :votes, :dependent => :destroy
 has_many :students, :through => :votes 
scope :search, lambda {|val| where("description LIKE ?","%#{val}%") } 
def self.search(search)
   if search
    find(:all, :conditions => ['description LIKE ? or title LIKE ?', "%#{search}%", "%#{search}%"])
   else
    find(:all)
   end

 end

end
