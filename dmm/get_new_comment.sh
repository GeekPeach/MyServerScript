#!/bin/sh
ddir="/home/grass/dmm/data/${1}"
#ddir="."

mv ${ddir}/review_uid.sort ${ddir}/review_uid.old.sort

LC_ALL=C sort -k1,1 ${ddir}/review_uid.txt > ${ddir}/review_uid.sort
#sort -k1,1 ${ddir}/review_uid.txt.old > ${ddir}/review_uid.old.sort

LC_ALL=C join -j1 -v2 -t$'\t' ${ddir}/review_uid.old.sort ${ddir}/review_uid.sort >> ${ddir}/review_uid.new

