require 'open-uri'
require 'json'

class GetGroups
   
  def initialize 
    
  end

  def getGroups()
    topics = " "
    json_obj = JSON.parse(open("http://api.meetup.com/groups?radius=25.0&order=ctime&format=json&lat=51.5200004578&page=20&zip=EC1A+4DD&city=london&offset=100&fields=&country=uk&lon=-0.10000000149&sig_id=12309961&sig=1ebaf539d25ad17717d216e79d3e79c488bb312b").read)

    if json_obj["meta"]["count"] == 0
    else
       i = json_obj["meta"]["count"]
       for x in 0..(i-1)
         name = json_obj["results"][x]["name"]
         description = json_obj["results"][x]["description"]
         city = json_obj["results"][x]["city"]
         zipcode = json_obj["results"][x]["zip"]
         link = json_obj["results"][x]["link"]
         topics_length = json_obj["results"][x]["topics"].length
         for t in 0..(topics_length-1)           
            topics = topics + " " + json_obj["results"][x]["topics"][t]["name"]
         end
         saveGroupInDB name, description, city, zipcode, link, topics
       end
    end
   end

   def saveGroupInDB(name, description, city, zipcode, link, topics)
     group = Group.new(:title => name, :description => description, :city => city, :zip => zipcode, :link => link, :topics => topics)
     group.save 
   end

end

