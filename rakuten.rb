require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_price(str)
  str.delete! ","
  str.slice(/[0-9]+/).to_i
end

MIN_PRICE = 5000

uri = ARGV[0] || exit
doc = Nokogiri::HTML(open(uri))

lowest_price = MIN_PRICE
doc.css('div.roomPrice ul').each do |plan|
  if(/(1名|1室)/ =~ plan.css('li.roomNumber').text) 
    price = get_price(plan.css('li.roomPrice').text)
    lowest_price = price if lowest_price > price
  end
end

p lowest_price



