require 'net/http'
require 'net/https'
require 'open-uri'
require 'nokogiri'
class StdregisterController < ApplicationController

  @htmlresponse = ""
  def index
   begin
   file = open("stdregister.txt","r")
   s = file.read
   if s == "1"
   end
   rescue => e
    getCourseReg
   end
  
   @students = Stdregister.where("stdid LIKE '%#{params[:search]}%'").order('id').page(params[:page]).per(15)
  end

  def getCourseReg
    file = open("stdregister.txt","w")
    file.write(1)
    file.close
    http = Net::HTTP.new("www.dcs.kcl.ac.uk",843)
    req = Net::HTTP::Get.new("/local/coursereg.html")
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req.basic_auth "ismalif", "Dvd-rcd-r044"
    response = http.request(req)
    @htmlresponse = response.body.gsub(/<br\s*>|<br\s*\/>|<dd>/,"")
    parseHTMLResponse
  end
  
  def parseHTMLResponse
    f = File.open("register.html",'r')
    doc = Nokogiri::HTML(@htmlresponse)
    x = doc.xpath('//dl/dt').text
    slice = x.lines.each_slice(2).to_a
    for i in 0..slice.length-1 
            if slice[i] == nil or slice[i][0] == nil or slice[i][1] == nil
            else
		l1 = slice[i][0].split(' ')
		l2 = slice[i][1].split(' ')
		if l1.length == 5
                  if l1[l1.length-1].gsub(/[\W[0-9]']+/,"").length > 4
		   tutor = ""
		 else
		   tutor = l1[l1.length-1].gsub(/[\W[0-9]']+/,"")
		 end
		print "stdid: #{l1[0]}, tutor: #{tutor}, modules: #{l2.to_s.gsub(/[\W']+/," ")}"
                saveEventInDB(l1[0], l2.to_s.gsub(/[\W']+/," "), tutor) 
		end
		if l1.length == 4
		 if l1[l1.length-1].gsub(/[\W[0-9]']+/,"").length > 4
		   tutor = ""
		 else
		   tutor = l1[l1.length-1].gsub(/[\W[0-9]']+/,"")
		 end
		print "stdid: #{l1[0]}, tutor: #{tutor}, modules: #{l2.to_s.gsub(/[\W']+/," ")}"
                saveEventInDB(l1[0], l2.to_s.gsub(/[\W']+/," "), tutor) 
	 	end
             end
        end
  end
  def show
   @student = Stdregister.find(params[:id])
  end



  def saveEventInDB(stdid, modules, tutor)
     student = Stdregister.new(:stdid => stdid, :modules => modules, :tutor => tutor)
     student.save 
  end

end
