class Stdregister < ActiveRecord::Base
attr_accessible :stdid, :modules, :tutor
scope :search, lambda {|val| where("stdid LIKE ?","%#{val}%") } 
def self.search(search)
   if search
    find(:all, :conditions => ['stdid LIKE ?', "%#{search}%"])
   else
    find(:all)
   end

 end
end
