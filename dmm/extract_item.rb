# -*- coding: utf-8 -*-
#!/usr/bin/ruby

require 'nokogiri'

doc = nil
sep ="\t"

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

#hinban
#//*[@id="mu"]/div/table/tbody/tr/td[1]/table/tbody/tr[12]/td[2]
#p doc.css("table.mg-b20 > tr > td")[19].text
#p search_val("品番", doc).text
hinban = search_val("品番", doc).text
str_write = hinban

#title
#//*[@id="title"]
#p doc.css("#title").text
str_write = str_write + sep +doc.css("#title").text + sep

#actor
doc.css("#performer > a").each do |actor|
  #print (actor.children)
  #print (",")
  str_write = str_write + actor.children.to_s.gsub(/[\t]/,"|") + "|"
end
#print("\n")
str_write = str_write + sep

#kantoku
#//*[@id="mu"]/div/table/tbody/tr/td[1]/table/tbody/tr[7]/td[2]/a
#p doc.css("table.mg-b20 > tr > td")[9].text
#p search_val("監督", doc).text
str_write = str_write + search_val("監督", doc).text + sep

#maker
#p doc.css("table.mg-b20 > tr > td")[13].text
#p search_val("メーカー", doc).text
str_write = str_write + search_val("メーカー", doc).text + sep

#series
#p doc.css("table.mg-b20 > tr > td")[11].text
#p search_val("シリーズ", doc).text
str_write = str_write + search_val("シリーズ", doc).text + sep

#label
#p doc.css("table.mg-b20 > tr > td")[15].text
#p search_val("レーベル", doc).text
str_write = str_write + search_val("レーベル", doc).text + sep

#janre
#//*[@id="mu"]/div/table/tbody/tr/td[1]/table/tbody/tr[11]/td[2]/a[1]
#p doc.css("table.mg-b20 > tr > td > a").text
jan = search_val("ジャンル", doc)
jan.children.each do |j|
  j.children.each do |a|
    #print a.text + ","
    str_write = str_write + a.text + "|"
  end
end
#print "\n"
str_write += sep

#ave_eval
ave_eval = search_val("平均評価", doc)
/(\d).gif$/ =~ ave_eval.children.attribute("src").value
#p $1
str_write = str_write + $1 + sep

#eroine
#p doc.css("span.eroine_count").text
ene = doc.css("span.eroine_count").text
if (ene == "") then
  str_write = str_write + "0" + sep
else 
  str_write = str_write + ene + sep
end

#descript
#//*[@id="mu"]/div/table/tbody/tr/td[1]/div[4]/text()
desc = doc.xpath('//*[@class="mg-b20 lh4"]/text()').first.content.gsub(/[\r\n]/,"")
str_write = str_write + desc + sep

#image_url
img_url = doc.xpath('//*[@id="' + hinban +'"]').attribute("href").value
str_write = str_write + img_url

w_doc.write(str_write + "\n")
w_doc.close
