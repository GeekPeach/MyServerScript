#!/bin/sh
ddir="/home/grass/dmm/data/${1}"
#ddir="."

echo "dummy line" >> ${ddir}/review_uid.new
awk -F';' -v OFS='\t' '{print "","",$1,$2,$7,"",$6,$5,""}' ${ddir}/item.csv >> ${ddir}/review_uid.new

