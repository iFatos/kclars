class Rsvps < ActiveRecord::Base
 belongs_to :student
 belongs_to :group
 belongs_to :event

end
