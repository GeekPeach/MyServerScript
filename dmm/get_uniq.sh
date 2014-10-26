#!/bin/sh
ddir="/home/grass/dmm/data/${1}"
#ddir="."
tfile=${2}

mv ${ddir}/${tfile}.sort ${ddir}/${tfile}.old.sort

LC_ALL=C sort -k1,1 ${ddir}/${tfile}.txt > ${ddir}/${tfile}.sort
#sort -k1,1 ${ddir}/${tfile}.txt.old > ${ddir}/${tfile}.old.sort

LC_ALL=C join -j1 -v2 -t$'\t' ${ddir}/${tfile}.old.sort ${ddir}/${tfile}.sort >> ${ddir}/${tfile}.uniq

