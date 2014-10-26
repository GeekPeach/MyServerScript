#!/bin/sh
ddir="/home/grass/dmm/data/${1}"
sdir="/home/grass/dmm/script"
rm ${ddir}/item.csv

find ${ddir}/www.dmm.com/digital -name index.html > ${ddir}/index_list.txt

while read l
do
  i=`/usr/local/rbenv/shims/ruby ${sdir}/yj_extract_item.rb ${l} ${ddir}"/item.csv"`
done < ${ddir}/index_list.txt

