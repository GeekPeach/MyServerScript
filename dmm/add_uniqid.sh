#!/bin/sh

sdir="/home/grass/dmm/script"
ddir="/home/grass/dmm/data/${1}"

sed -i -e 's/\t/ /g' ${ddir}/review.csv
sed -i -e 's/|/\t/g' ${ddir}/review.csv
cut -f1,2 ${ddir}/review.csv > ${ddir}/name_id.txt

while read l
do
  echo ${l} | md5sum | cut -b -12
done < ${ddir}/name_id.txt > ${ddir}/md5.txt

rm ${ddir}/review_uid.txt
cd ${ddir}
split -d -l 5000 ${ddir}/review.csv review
split -d -l 5000 ${ddir}/md5.txt md5_
#mv ${sdir}/review0* ${ddir}/
#mv ${sdir}/md5_0* ${ddir}/

for i in `seq 0 2`
do
  paste ${ddir}/md5_0${i} ${ddir}/review0${i} >> ${ddir}/review_uid.txt
done

