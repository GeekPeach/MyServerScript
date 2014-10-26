#!/usr/bin/ruby
require 'nkf'

ddir="/home/grass/blog/data/"+ARGV[0]+"/"

f=open(ddir+"body.txt")
f_out=open(ddir+"body.trns","w")
while l=f.gets
  l.downcase!
#p l
  f_out.write(NKF.nkf('-WwXZ0', l))
end

f.close()
f_out.close()

