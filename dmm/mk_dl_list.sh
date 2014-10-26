#!/bin/sh
sdir="/home/grass/dmm/script"
ddir="/home/grass/dmm/data/yj"

cat /dev/null > ${ddir}"/yj.txt"

for i in `seq 1 10`
do
  echo http://www.dmm.com/search/=/searchstr=${1}/sort=ranking/page=${i}/ >> ${ddir}"/yj.txt"
done

