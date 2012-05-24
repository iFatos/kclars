#
# Author: Fatos Ismali
# 
#
#
require 'json'
require 'open-uri'
class EventsController < ApplicationController
  def index
   
   begin
   file = open("events.txt","r")
   s = file.read
   if s == "1"
   end
   rescue => e
    getGroups
   end
   @events = Event.where("description LIKE '%#{params[:search]}%'").order('id').page(params[:page]).per(10)
   respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.json {render :json => @events }
    end
  end

  def show
   @event = Event.find(params[:id])
  end
  # fetch groups and events
  def getGroups
    file = open("events.txt","w")
    file.write(1)
    file.close
    topics = " "
    offset = 0
    @groups = Group.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
      
    end
    for g in 2766..Group.all.length
         urlname = Group.find(g).groupkey
         puts urlname
         puts g
   	 json_obj = JSON.parse(open("https://api.meetup.com/2/events?key=5d5d103a5b6b1748384575e4e512f40&sign=true&time=,2m&group_urlname=" + urlname + "&page=20").read)

	    if json_obj["meta"]["count"] != 0
	    
	       i = json_obj["meta"]["count"]
	       for x in 0...(i)
 	         puts "x is : #{x}"
		 name = json_obj["results"][x]["name"]
		 description = json_obj["results"][x]["description"]
		 if json_obj["results"][x]["venue"] != nil
                    if json_obj["results"][x]["venue"]["city"] != nil
                     city = json_obj["results"][x]["venue"]["city"]
		    else
   		     city = "London"
  		    end
                    if json_obj["results"][x]["venue"]["address_1"] != nil
 		     address = json_obj["results"][x]["venue"]["address_1"]
                    else 
 	 	     address = "London"
                    end
                 else 
                      city = "London"
 		      address = "London"
       	         end 
                    
                      
               
		 groupid = g
		 mili = json_obj["results"][x]["time"]
                 timedate = Time.at(mili / 1000.0)
                 timedate_array = (timedate.to_s).split(' ')
                 date = timedate_array[0]
                 time = timedate_array[1] 
		 saveEventInDB name, description, city,address, groupid, time, date
		 
	       end
	     
	    end
     end
    
   end

   def saveEventInDB(name, description, city,address, groupid, time, date)
     event = Event.new(:title => name, :description => description, :city => city, :address => address, :group_id => groupid, :time_t => time, :date_t => date)
     event.save 
   end
  
   def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /students/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

end
