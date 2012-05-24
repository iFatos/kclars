require 'net/http'
class Api
 attr_accessor :url
  attr_accessor :uri
 def initialize 
  @url = "http://localhost:3000/getid"
  @uri = URI.parse @url
 end
 def show
   request = Net::HTTP.new(@uri.host, @uri.port)
   @group = request.get("#{@uri.path}/5")
   puts @group.body
 end
 
end

a = Api.new
a.show
