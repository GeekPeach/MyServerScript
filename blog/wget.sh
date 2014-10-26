#/bin/sh

genre=$1
sdir="/home/grass/blog/script"
ddir="/home/grass/blog/data/${genre}"

rm -rf ${ddir}/s.ameblo.jp/

while read l
do
  #echo ${l}
  /usr/local/rbenv/shims/ruby ${sdir}/get_indblog.rb ${l} ${genre}
done < ${ddir}/url_list.txt

