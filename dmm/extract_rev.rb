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
  p reviewer.text
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

#comment
i = 0
reviewer = 0
doc.css("ul.review-list > li > p").each do |comment|
  if ( i % 4 == 1) then
    if ( comment['id'] != nil ) then
      if (comment['id'].include?("filter_link")) then
        i -= 1
      end
    else
      #p doc.css("span.tx10.mg-b12 > a.bold")[reviewer].text
      str_write = doc.css("span.tx10.mg-b12 > a.bold")[reviewer].text + sep + item_no + sep + item_title + sep + img_url + sep + doc.css("ul.review-list > li > p > b")[reviewer].text + sep
      #p comment.text
      str_write = str_write + comment.text.gsub(/\r\n?/,"") + sep
      #star
      #//*[@id="review"]/div[2]/div/ul/li[1]/p[1]/span[1]
      #p doc.search("ul.review-list > li > p > span").first.attributes["class"].value
      /d-rating-(.*)/ =~ doc.css("ul.review-list > li")[reviewer].xpath(".//p//span").first.attributes["class"].value
      #p $1.to_i / 10
      score = $1.to_i / 10
      str_write = str_write + score.to_s + sep

      #//*[@id="review"]/div[2]/div/ul/li[4]/p[3]/span
      /(\d*)人中、(\d*)人が参考になったと投票しています。/ =~ doc.css("p.tx10").xpath(".//span")[reviewer].text
      str_write = str_write + $2 + "/" + $1
      w_doc.write(str_write + "\n")
p str_write
      reviewer += 1
    end
  end
  i += 1
end

w_doc.close()
