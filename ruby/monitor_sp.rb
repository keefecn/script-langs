#!/usr/bin/ruby
require 'net/http'
require 'net/smtp'

#
# Usage: ./monitor_sp.rb <symbol> <high> <low> <email_address>
# Eg: ./monitor_sp.rb goog 622.01 619.99 wuqifu@localhost
#
def usage()
   if ARGV.length < 4
   	print "usage: ./monitor_sp.rb <symbol> <high> <low> <email_address> \n"
	exit 0;
   end
end

#
# Given a web-site and link, return the stock price
#
def getStockQuote(host, link)

    # Create a new HTTP connection
    httpCon = Net::HTTP.new( host, 80 )

    # Perform a HEAD request
    resp = httpCon.get( link, nil )

    stroffset = resp.body =~ /class="price">/

    subset = resp.body.slice(stroffset+14, 10)

    limit = subset.index('<')

    return subset[0..limit-1].to_f

end

#
# Send a message (msg) to a user.
# Note: assumes the SMTP server is on the same host.
#
def sendStockAlert( user, msg )

    lmsg = [ "Subject: Stock Alert\n", "\n", msg ]
    Net::SMTP.start('localhost') do |smtp|
      smtp.sendmail( lmsg, "rubystockmonitor@localhost", [user] )
    end

end

#
# Our main program, checks the stock within the price band every two
# minutes, emails and exits if the stock price strays from the band.
#
# Usage: ./monitor_sp.rb <symbol> <high> <low> <email_address>
#
begin
  #show usage
  usage();

  host = "www.smartmoney.com"
  link = "/eqsnaps/index.cfm?story=snapshot&symbol="+ARGV[0]
  user = ARGV[3]

  high = ARGV[1].to_f
  low = ARGV[2].to_f

  # Test send mail
  msg="stock notice.\n"
  sendStockAlert( user, msg )
  while 1
    price = getStockQuote(host, link)
    print "current price ", price, "\n"

    if (price > high) || (price < low) then

      if (price > high) then
        msg = "Stock "+ARGV[0]+" has exceeded the price of "+high.to_s+
               "\n"+host+link+"\n"
      end

      if (price < low) then
        msg = "Stock "+ARGV[0]+" has fallen below the price of "+low.to_s+
               "\n"+host+link+"\n"

      end

      sendStockAlert( user, msg )

      exit

    end

    sleep 120

  end

end

