require 'net/http'
require "net/https"
@http=Net::HTTP.new('www.dcs.kcl.ac.uk', 443)
@http.use_ssl = true
@http.verify_mode = OpenSSL::SSL::VERIFY_NONE
@http.start() {|http|
req = Net::HTTP::Get.new('../coursereg.html')
req.basic_auth 'ismalif', 'Dvd-rcd-r044'
response = http.request(req)
print response.body
}
