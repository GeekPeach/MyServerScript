# encoding: utf-8
#!/usr/local/rbenv/shims/ruby

require 'httparty'
require 'json'
require 'tumblr_client'
require 'bitly'

dir = '/home/grass/dmm/data/yj'

Tumblr.configure do |config|
        config.consumer_key = "iVyLnW4faZQ0NfNigIxwGlb81EW0XSJh1gKJ7gbd6S09qhSvco"
        config.consumer_secret = "BEMA847uooHx4hk5bt9S41NhFoDah1pZMl5pc01Nal5wm5zxtd"
        config.oauth_token = "d26o8MqxOEm7BK0ode7IXURFSFIxKKuwq8ReUSB3sfQPZsqjp2"
        config.oauth_token_secret = "Ekd8FP8LR0b2WAc4q6OSPuYRkYZXxHp3fYAN7hTtG61i2zIudc"
end

Bitly.configure do |config|
  config.api_version = 3
  config.login = "o_77ke7hvl19"
  config.api_key = "R_3371149364264275b012e2805a434433"
end

def shorten_url(item_id, ima_lurl)
  item_lurl = "http://www.dmm.com/digital/idol/-/detail/=/cid=" + item_id + "/infgold-001"
  check_res = HTTParty.get(item_lurl)
  item_surl = nil
  client = Bitly.client

  if check_res.code == 200 then
    item_surl = client.shorten(item_lurl).short_url
  else
    return nil,nil
  end

  check_img_res = HTTParty.get(ima_lurl)
  if check_img_res.code == 200 then
    ima_surl = client.shorten(ima_lurl).short_url
  else
    return nil, nil
  end

  return item_surl, ima_surl
end

File.open(dir + "/review_uid.tmp") { |f|
  f.each{ |line|
    item_detail = line.split("\t")
    item_surl, ima_surl = shorten_url(item_detail[0], item_detail[3].chomp)
	
    if item_surl.nil? then
      item_detail[0] + " invalid url"
    else
      com_body = '【'+item_detail[2]+'】 '+item_detail[1] +'<a href="' +item_surl +'">詳細はこちら</a>'
      t_client = Tumblr::Client.new
      puts item_detail[3].chomp, item_surl
      #p t_client.photo("kawaiigals.tumblr.com", {:source => item_detail[3].chomp, :caption => com_body})
      system('wget '+item_detail[3].chomp+' -O pic_yj.jpg')
      p t_client.photo("kawaiigals.tumblr.com", {:data => "pic_yj.jpg", :caption => com_body})
    end
  }
}
	
