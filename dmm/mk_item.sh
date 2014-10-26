#!/bin/sh
ddir="/home/grass/dmm/data/${1}"
sdir="/home/grass/dmm/script"
rm ${ddir}/item.txt

find ${ddir}/www.dmm.co.jp/digital/videoa -name index.html > ${ddir}/index_list.txt

while read l
do
  i=`/usr/local/rbenv/shims/ruby ${sdir}/extract_item.rb ${l} ${ddir}"/item.txt"`
done < ${ddir}/index_list.txt

