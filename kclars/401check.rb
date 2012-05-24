#!/usr/bin/env ruby
require 'json'
require 'open-uri'
begin
json_obj = JSON.parse(open("https://api.meetup.com/2/events?key=5d5d103a5b6b1748384575e4e512f40&sign=true&group_urlname=grad-dc&page=20").read)
puts "success"
rescue => e
 puts "400 Bad request error"
end
