#!/usr/bin/ruby
#usage:  ./rubyhttp.rb www.baidu.com
require 'net/http'

# Get the first argument from the command-line (the URL)
url = ARGV[0]

#
#usage:  ./rubyhttp.rb [host]
#
def usage()
   if ARGV.length < 1
   	print "usage: ./rubyhttp.rb [host] \n"
	exit 0;
   end
end

begin
  # show usage
  usage()
   
  # Create a new HTTP connection
  httpCon = Net::HTTP.new( url, 80 )

  # Perform a HEAD request
  resp, data = httpCon.head( "/", nil )

  # If it succeeded (200 is success)
  if resp.code == "200" then

    # Iterate through the response hash
    resp.each {|key,val|

      # If the key is the os, print the value
      if key == "os" then
        print "  The os at "+url+" is "+val+"\n"
      end

      # If the key is the server, print the value
      if key == "server" then
        print "  The server at "+url+" is "+val+"\n"
      end
    }
  end
end
