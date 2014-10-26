# -*- coding: utf-8 -*-
#!/usr/bin/ruby

require 'nokogiri'

doc = nil
sep = "|"

File.open(ARGV[0]) do |f|
  doc = Nokogiri::HTML(f)
end

def search_val(key, doc)
  num = 0
  doc.css("table.mg-b20 > tr > td").each do |item|
    if ( item.text.include?(key) ) then
      return doc.css("table.mg-b20 > tr > td")[num + 1]
    end
    num = num + 1
  end
end

w_doc = open(ARGV[1], "a")

str_write = ""
#reviewer
=begin
doc.css("span.tx10.mg-b12 > a.bold").each do |reviewer|
#  p reviewer.text
end
=end

#hinban
#//*[@id="mu"]/div/table/tbody/tr/td[1]/table/tbody/tr[12]/td[2]
#p doc.css("table.mg-b20 > tr > td")[19].text
#p search_val("品番", doc).text
item_no = search_val("品番", doc).text

#title
#//*[@id="title"]
#p doc.css("#title").text
item_title = doc.css("#title").text

#AV comment
#p doc.css("div.mg-b20.lh4").text

#image url
##sample-video
#p doc.css("#sample-video > a").first.attributes["href"].value
begin
  img_url = doc.css("#sample-video > a").first.attributes["href"].value
rescue
  img_url = "nourl"
end

i = 1
num_of_reviewer = doc.xpath('//*[@id="review"]/div[2]/div/ul/li[*]').length

while i <= num_of_reviewer do
  write_str = nil

  rev_title = doc.xpath('//*[@id="review"]/div[2]/div/ul/li['+i.to_s+']/p[1]/b').first.content

  comment = nil
  doc.xpath('//*[@id="review"]/div[2]/div/ul/li['+i.to_s+']/p[2]/text()').each do |com|
    if comment == nil then
      comment = com.content.gsub(/\r\n?/,"")
    else
      comment = comment +" " +com.content.gsub(/\r\n?/,"")
    end
  end
  #p comment
  
  reviewer = ""
  doc.xpath('//*[@id="review"]/div[2]/div/ul/li['+i.to_s+']/p[1]/span[2]/a').each do |r|
    reviewer = r.content
  end
  #p reviewer

  reference = ""
  doc.xpath('//*[@id="review"]/div[2]/div/ul/li['+i.to_s+']/p[3]/span').each do |ref|
    /(\d*)人中、(\d*)人が参考になったと投票しています。/ =~ ref.content
    reference = $2 + "/" + $1
  end
  #p reference

  /d-rating-(.*)/ =~ doc.xpath('//*[@id="review"]/div[2]/div/ul/li['+i.to_s+']/p[1]/span[1]').first.attributes["class"].value
  score = $1.to_i / 10
  
  w_doc.write(reviewer + sep + item_no + sep + item_title + sep + img_url + sep + rev_title + sep + comment + sep + score.to_s + sep + reference + "\n")


  i += 1
end

w_doc.close()
