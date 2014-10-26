#!/usr/bin/ruby

require 'twitter'
@client = Twitter::REST::Client.new(
      :consumer_key       => "DZ9kXsn7fZ6tKLP6qfpzj1Klv",
      :consumer_secret    => "U5m1skypKXeTm0kQFCqftwFWVQ1agT4iX0c0519V8FuOOOdrBg",
      :access_token       => "76378686-BMlXWPHSwOKfy9aOv8qfM4CxN6ShEbhcdHIoRAk8e",
      :access_token_secret => "CcXe6ZjKr7U4LDpXiT8CefBAgVIcenUfqPicbUWFpXUgO")
@client.update ARGV[0]
