#!/usr/local/rbenv/shims/ruby

f_in = open(ARGV[0])
num_of_col = ARGV[2].to_i
i = 0
while l = f_in.gets do
  i = i + 1
  num_of_del = l.split(ARGV[1]).length
  if (num_of_del != num_of_col) then
    p("line"+ i.to_s + " has " + num_of_del.to_s + "cols")
    p l
  end
end  
