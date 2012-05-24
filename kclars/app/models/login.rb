class Login < ActiveRecord::Base
 
 validate :authenticate
 
 def authenticate(username, password)
   user = Student.find_by_username(username) 
   if user.nil? | user.blank? | user.password != password 
    error.add(:username, "username does not exist or password does not match!") 
   end
 end
   
   

end
