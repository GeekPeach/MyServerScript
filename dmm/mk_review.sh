#!/bin/sh
ddir="/home/grass/dmm/data/${1}"
sdir="/home/grass/dmm/script"
rm ${ddir}/review.csv

find ${ddir}/www.dmm.co.jp/digital -name index.html > ${ddir}/index_list.txt

while read l
do
  i=`/usr/local/rbenv/shims/ruby ${sdir}/extract_rev.rb ${l} ${ddir}"/review.csv"`
done < ${ddir}/index_list.txt

