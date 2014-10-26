#!/bin/sh

ddir="/home/grass/dmm/data/${1}"
sdir="/home/grass/dmm/script"

head -1 ${ddir}/review_uid.new | cut -f3,4,5,7 | awk -F'\t' -v OFS='\t' '{print $1,$4,$2,$3}' > ${ddir}/review_uid.tmp
sed -i -e '1,1d' ${ddir}/review_uid.new

/usr/local/rbenv/shims/ruby ${sdir}/twi_new_com.rb

