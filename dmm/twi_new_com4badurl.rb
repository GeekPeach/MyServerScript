# encoding: utf-8
#!/usr/local/rbenv/shims/ruby

require 'httparty'
require 'json'
require 'twitter'
require 'bitly'

dir = '/home/grass/dmm/data/osi'

@client = Twitter::REST::Client.new(
      :consumer_key       => "DZ9kXsn7fZ6tKLP6qfpzj1Klv",
      :consumer_secret    => "U5m1skypKXeTm0kQFCqftwFWVQ1agT4iX0c0519V8FuOOOdrBg",
      :access_token       => "76378686-BMlXWPHSwOKfy9aOv8qfM4CxN6ShEbhcdHIoRAk8e",
      :access_token_secret => "CcXe6ZjKr7U4LDpXiT8CefBAgVIcenUfqPicbUWFpXUgO")

Bitly.configure do |config|
  config.api_version = 3
  config.login = "o_77ke7hvl19"
  config.api_key = "R_3371149364264275b012e2805a434433"
end

def shorten_url(item_id)
  mod_item_id = item_id.sub(/00/,"")
  item_lurl = "http://www.dmm.co.jp/digital/videoa/-/detail/=/cid=" + mod_item_id + "/infgold-001"
  check_res = HTTParty.get(item_lurl)
  item_surl = nil
  client = Bitly.client
  if check_res.code == 200 then
    item_surl = client.shorten(item_lurl).short_url
  else
    return nil,nil
  end

  ima_lurl = "http://pics.dmm.co.jp/digital/video/" + item_id + "/" + item_id +"pl.jpg"
  ima_surl = client.shorten(ima_lurl).short_url

  return item_surl, ima_surl
end

File.open(dir + "/bad_url_rev.tmp") { |f|
  f.each{ |line|
    id_comment = line.split("\t")
    item_surl, ima_surl = shorten_url(id_comment[0])

    if item_surl.nil? then
      p id_comment[0] + " invalid url"
    else
      p id_comment[0] + " posted"
      twi_body = id_comment[1][0,82]+"...画像は→"+ima_surl+"詳細は→"+item_surl
    
#      p twi_body
      @client.update twi_body
    end
  }
}

