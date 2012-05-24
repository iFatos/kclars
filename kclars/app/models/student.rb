class Student < ActiveRecord::Base
 serialize :queryvector 
 validates :name, :username, :email, :presence => true
 validates :username, :email, :uniqueness => true, :on => :create

 email_regex = /^[a-zA-Z]+[.]([a-zA-Z]+[-_]*[a-zA-Z]+)*@kcl.ac.uk$/
 validates :email, :format => { :with => email_regex } 
 #validate :check_id
 has_many :votes, :dependent => :destroy
 has_many :events, :through => :votes, :source => "event_id"

 before_save :remove_stop_words
 
 #private 
 
 #def  check_id
 #  if Stdregister.find_by_stdid(self.stdid).blank? 
 #    errors.add(:stdid, "student id does not exist in INF dept")
 # 
 #  end
 #end

  
   def remove_stop_words
    if self.bhistory != nil
     string = self.bhistory
     stop_words = %w{a about above after again against all am an and any are aren't as at be because been before being below between both but by can't cannot could couldn't \
     did didn't do does doesn't doing don't down during each few for from further had hadn't has hasn't have haven't having he he'd himself his how how's i i'd i'll i'm i've if in into \
     is isn't it it's its itself let's me more most mustn't my myself no nor not of off on once only or other ought our ours ourselves out over own same shan't she she'd she'll she's should \
     shouldn't so some such than that that's hte their hteirs them themselves then there there's these they they'd they'll they're they've this those through to too under until up very was wasn't \
     we we'd we'll we're we've were weren't what what's when when's where where's which while who who's whom why why's with won't would wouldn't you you'd you'll you're you've your yours \
     yourself yourselves php html js cgi login owa index auth srf ppsecur redirect htm}
     
     words = string.scan(/\w+/)
     key_words = words.select { |word| !stop_words.include?(word) }
     self.bhistory = key_words.join(' ')
     build_query_vector(self.bhistory)       
    end
   end
   
   def build_query_vector(string)
     hash = Hash.new(0)
     words = string.downcase.scan(/[\w']+/) 
     for w in words
      hash[w] += 1
     end
     etf = euclideanNormalizedScore(hash)
     self.queryvector = etf
     self.queryvector = Hash[queryvector.to_a.shuffle[0..10]]

   end  
  
   def euclideanNormalizedScore(t)
    sum = 0
    t.each { |k, v| sum += v ** 2}
    t.each { |k, v| p = t[k].to_f / sum; s = p.round(3); t[k] = s }
    return t
   end
 

  
 









end
