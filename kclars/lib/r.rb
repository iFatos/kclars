#!/usr/bin/env ruby

begin
file = open("myfile.txt","r")
puts file.read == "1"
file.close
rescue => e
file = open("myfile.txt","w")
file.write(1)
file.close
end
