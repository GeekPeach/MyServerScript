#!/bin/sh

ddir="/home/grass/dmm/data/${1}"
sdir="/home/grass/dmm/script"

sed -i -e '1,1d' ${ddir}/bad_url_rev.txt
head -1 ${ddir}/bad_url_rev.txt | cut -f3,7 > ${ddir}/bad_url_rev.tmp

/usr/local/rbenv/shims/ruby ${sdir}/twi_new_com4badurl.rb

