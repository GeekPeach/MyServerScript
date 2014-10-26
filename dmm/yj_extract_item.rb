# -*- coding: utf-8 -*-
#!/usr/bin/ruby

require 'nokogiri'

doc = nil
sep = ";"

File.open(ARGV[0]) do |f|
  doc = Nokogiri::HTML(f)
end

w_doc = open(ARGV[1], "a")

str_write = ""

#hinban
hinban = doc.xpath('//*[@class="mg-b20"]/tr[8]/td[2]').first.content
str_write = hinban + sep

#title
str_write = str_write + doc.xpath('//*[@id="title"]').first.content + sep

#actor
#p doc.xpath('//*[@id="mu"]/div/table/tbody/tr/td[1]/table/tbody/tr[5]/td[2]/a').first.content
str_write = str_write + doc.xpath('//*[@class="mg-b20"]/tr[4]/td[2]').first.content.gsub(/[\r\n]/,"") + sep

#series
str_write = str_write + doc.xpath('//*[@class="mg-b20"]/tr[5]/td[2]').first.content.gsub(/[\r\n]/,"") + sep

#ave_eval
/\/([^\/]*).gif$/ =~ doc.xpath('//*[@class="mg-b20"]/tr[9]/td[2]/img').attribute("src").value
str_write = str_write + $1 + sep

#description //*[@id="mu"]/div/table/tbody/tr/td[1]/div[4]/text()[1]
str_write = str_write + doc.xpath('//*[@class="mg-b20 lh4"]/text()').first.content.gsub(/[\r\n]/,"") + sep

#image_url
str_write = str_write + doc.xpath('//*[@id="' + hinban +'"]').attribute("href").value

w_doc.write(str_write + "\n")
w_doc.close
