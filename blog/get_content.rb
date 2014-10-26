# -*- coding: utf-8 -*-
#!/usr/bin/ruby

require 'nokogiri'

ddir = "/home/grass/blog/data/"+ARGV[1]+"/"

doc = nil
sep = "\t"
t_blog = ARGV[0]
/.*\.jp\/(.*)\/.*/ =~ t_blog
b_name = $1
/.*entry-(\d*)\.html/ =~ t_blog
id = $1

f = open(t_blog)
doc = Nokogiri::HTML(f)
w_doc = open(ddir + "blog_db.new", "a")

str_write = id + sep + b_name + sep

#title
begin
  title = doc.xpath('//*[@id="sub_main"]/div[3]/h3/a').first.content.gsub(/[\r\n]/,"")
rescue
  p t_blog
end

str_write = str_write + title + sep

#body
#           //*[@id="sub_main"]/div[3]/div[2]/div/div[1]/p[2]/text()
doc.xpath('//*[@id="sub_main"]/div[3]/div[2]/div/div[1]').each do |d|
  str_write += d.text().gsub(/[\r\n\t]/,"")
end

w_doc.write(str_write.."\n")

f.close()
w_doc.close()
