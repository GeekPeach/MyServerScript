#!/bin/bash

rm ../data/img_list.txt
rm ../data/img_url.txt

for year in `seq 2016 2016`
do
  for mon in `seq -w 12`
  do
    curl http://youngjump.jp/gravure/archive/${year}/${mon}/ > ../data/index.html
    grep "こちらからチェック" ../data/index.html | sed -e 's|.*gravure/\(.*\)/photo/?p=\(.*\)" target=.*|http://youngjump.jp/gravure/\1/\2/photo/|' >> ../data/img_list.txt
  done
done


cat ../data/img_list.txt | while read line 
do
  for i in `seq 1 100`
  do
    curl -o ../data/tmp.jpg ${line}${i}.jpg
    file ../data/tmp.jpg | grep JPEG
    if [ $? = 0 ] ; then
      echo ${line}${i}.jpg >> ../data/img_url.txt
    else
      break
    fi
  done
done
      
