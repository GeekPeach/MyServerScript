#!/usr/bin/ruby

require 'nokogiri'

doc = nil
sep = "\t"

File.open(ARGV[0]) do |f|
  doc = Nokogiri::HTML(f)
end

w_doc = open("url_list.txt", "a")

str_write = ""

doc.xpath('//*[@id="mainCol"]/div[3]/ul[3]/li[*]/dl/dd[1]/p/a').each do |ref|
  p ref.attributes["href"].value
  str_write = ref.attributes["href"].value
  w_doc.write(str_write + "\n")
end

