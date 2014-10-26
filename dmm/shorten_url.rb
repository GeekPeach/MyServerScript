require 'httparty'
require 'json'

res = HTTParty.post('https://www.googleapis.com/urlshortener/v1/url', 
  :body => { :longUrl => ARGV[0] }.to_json,
  :headers => { 'Content-Type' => 'application/json' } )

p JSON.parse(res.body)["id"]
