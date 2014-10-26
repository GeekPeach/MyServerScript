#!/usr/bin/ruby

ddir = "/home/grass/blog/data/"+ARGV[0]+"/"
sep = "\t"

f = open(ddir+"sum_wdic.tmp")
f_out = open(ddir+"sum_wdic.sum", "w")

while l = f.gets
  val = l.split(sep)
  val_new = val[4].to_i()
  val_all = val[1].to_i() + val_new
  val3 = val[2].to_i() + val_new
  val2 = val[3].to_i() + val_new
  f_out.write(val[0].to_s()+sep+val_all.to_s()+sep+val3.to_s()+sep+val2.to_s()+sep+val_new.to_s()+"\n")
  #p(val[0].to_s()+sep+val_all.to_s()+sep+val3.to_s()+sep+val2.to_s()+sep+val_new.to_s()+"\n")
end

f.close()
f_out.close()

