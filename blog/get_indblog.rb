#!/usr/bin/ruby

require 'nokogiri'
require 'httparty'

ddir = "/home/grass/blog/data/"+ARGV[1]+"/"

doc = nil
sep = "\t"
tblog = ARGV[0]
w_file = open(ddir +"download_list.txt", "w")

url = tblog + "entrylist.html"
/.*\.jp\/(.*)\/.*/ =~ url
b_name = $1

`wget -nv -O #{ddir}"entrylist.html" #{url}`

File.open(ddir + "entrylist.html") do |f|
  doc = Nokogiri::HTML(f)
end

last_url = doc.xpath('//*[@id="sub_main"]/div[2]/a[5]').first.attributes["href"].value
/.*entrylist-(\d*)\.html/ =~ last_url
#p $1
last = $1.to_i()

for i in 1..last do
  e_list = tblog + "entrylist-" + i.to_s() + ".html"
  `wget -nv -O #{ddir}temp.html #{e_list}`
  
  f = open(ddir + "temp.html")
  doc = Nokogiri::HTML(f)
  
  doc.xpath('//*[@id="recent_entries_list"]/ul/li[*]/div[1]/p[1]/a').each do |u|
    w_file.write(u.attributes["href"].value + "\n")
  end
end

w_file.close()

`wget -nc -nv -i #{ddir}download_list.txt -P #{ddir}ameblo.jp/#{b_name}`

