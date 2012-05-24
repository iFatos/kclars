
require './lib/GetGroups.rb'
class GroupsController < ApplicationController
  
  def index
   begin
   file = open("myfile.txt","r")
   s = file.read
   if s == "1"
   end
   rescue => e
    getGroups
   end
   @groups = Group.where("description LIKE '%#{params[:search]}%'").order('id').page(params[:page]).per(15)

  end
  def new
  end
  
  def show
   @group = Group.find(params[:id])
  end


  def getGroups
    file = open("myfile.txt","w")
    file.write(1)
    file.close
    topics = " "
    offset = 0
    
    json_obj = JSON.parse(open("http://api.meetup.com/groups?radius=25.0&order=ctime&format=json&lat=51.5200004578&page=20&zip=EC1A+4DD&city=london&offset=0&fields=&country=uk&lon=-0.10000000149&sig_id=12309961&sig=1ebaf539d25ad17717d216e79d3e79c488bb312b").read)

    while(json_obj["meta"]["count"] != 0)
    
       i = json_obj["meta"]["count"]
       for x in 0..(i-1)
         name = json_obj["results"][x]["name"]
         description = json_obj["results"][x]["description"]
         city = json_obj["results"][x]["city"]
         zipcode = json_obj["results"][x]["zip"]
         groupname = json_obj["results"][x]["group_urlname"]
         topics_length = json_obj["results"][x]["topics"].length
         for t in 0..(topics_length-1)  
            topic_itself = json_obj["results"][x]["topics"][t]["name"]         
            topics = topics + " " + ((topic_itself == nil) ? "Empty" : topic_itself)
         end
         saveGroupInDB name, description, city, zipcode, groupname, topics
         topics = " "
       end
       offset += 1
       json_obj = JSON.parse(open("http://api.meetup.com/groups?radius=25.0&order=ctime&format=json&lat=51.5200004578&page=20&zip=EC1A+4DD&city=london&offset=" + offset.to_s + "&fields=&country=uk&lon=-0.10000000149&sig_id=12309961&sig=1ebaf539d25ad17717d216e79d3e79c488bb312b").read)
    end
    
   end

   def saveGroupInDB(name, description, city, zipcode, groupname, topics)
     group = Group.new(:title => name, :description => description, :city => city, :zip => zipcode.to_s, :groupkey => groupname, :topics => topics)
     group.save 
   end

  def getid
    @groupid = Group.find(params[:id])
    
  end
  def create 
   redirect_to :action => :index   
  end

  def invindex
   @groups = Group.all
   
   
  end

end
