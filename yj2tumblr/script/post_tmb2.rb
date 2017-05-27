# encoding: utf-8
#!/usr/local/rbenv/shims/ruby

require 'json'
require 'tumblr_client'

dir = '../data/'
url = ARGV[0]
name_j = ARGV[1]

/.*gravure\/(.*)\/(.*)\/photo\// =~ url
name = $1
no = $2

#p "http://youngjump.jp/gravure/"+name+"/photo/?p="+no

Tumblr.configure do |config|
        config.consumer_key = "iVyLnW4faZQ0NfNigIxwGlb81EW0XSJh1gKJ7gbd6S09qhSvco"
        config.consumer_secret = "BEMA847uooHx4hk5bt9S41NhFoDah1pZMl5pc01Nal5wm5zxtd"
        config.oauth_token = "d26o8MqxOEm7BK0ode7IXURFSFIxKKuwq8ReUSB3sfQPZsqjp2"
        config.oauth_token_secret = "Ekd8FP8LR0b2WAc4q6OSPuYRkYZXxHp3fYAN7hTtG61i2zIudc"
end

t_client = Tumblr::Client.new
system('curl '+ url +' -o pic_yj.jpg')
#p t_client.photo("cawaiigals.tumblr.com", {:state => "queue", :data => "pic_yj.jpg"})
p t_client.photo("cawaiigals.tumblr.com", 
		{:state => "queue",
		 :data => "pic_yj.jpg",
		 :caption => name_j+" : "+"http://youngjump.jp/gravure/"+name+"/photo/?p="+no,
		 :tags => [name_j, name]})

