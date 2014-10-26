#!/bin/sh
genre="osi"
sdir="/home/grass/dmm/script"
ddir="/home/grass/dmm/data/${genre}"

awk -F'\t' -v OFS='\t' '{print "","",$1,$2,$12,"",$11,"",""}' ${ddir}/item.uniq >> ${ddir}/review_uid.new

cat /dev/null > ${ddir}/item.uniq

