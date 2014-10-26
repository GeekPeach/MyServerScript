#!/usr/bin/ruby

require 'redis'

ddir = "/home/grass/blog/data/"+ARGV[0]+"/"

sep = " "

r_all = Redis.new

r_all.keys("*").each { |id|
  puts id+"\t"+r_all.get(id)
}

