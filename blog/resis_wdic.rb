#!/usr/bin/ruby

require 'redis'
require 'nokogiri'
require 'json'

ddir = "/home/grass/blog/data/"+ARGV[0]+"/"

doc = open(ddir+"body.mecab.nonum")
sep = " "

#h_all = Hash.new()
r_all = Redis.new
while l = doc.gets
  l.split(sep).each { |word|
    if r_all.get(word) then
      r_all.set word, r_all.get(word).to_i() + 1
    else
      r_all.set word, 1
    end
  }
end

