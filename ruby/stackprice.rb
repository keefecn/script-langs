#!/usr/bin/ruby
require 'net/http'

#
#usage:  ./stackprice.rb goog
#
def usage()
   if ARGV.length < 1 
        print "usage: *.rb [stack] \n"
        exit 0;
   end 
end

begin
  # show usage
  usage();

  host = "www.smartmoney.com"
  link = "/eqsnaps/index.cfm?story=snapshot&symbol="+ARGV[0]
  # Create a new HTTP connection
  httpCon = Net::HTTP.new( host, 80 )

  # Perform a HEAD request
  resp = httpCon.get( link, nil )

  stroffset = resp.body =~ /class="price">/

  subset = resp.body.slice(stroffset+14, 10)

  limit = subset.index('<')

  print ARGV[0] + " current stock price " + subset[0..limit-1] +
          " (from stockmoney.com)\n"

end

