#!/bin/bash
LC_ALL=C

rm ../data/img_list.txt
rm ../data/img_url.txt
rm ../data/tmp_img_url.txt
rm ../data/name.txt
rm ../data/tmp.jpg

for year in `seq 2016 2017`
do
  for mon in `seq -w 12`
  do
    curl http://youngjump.jp/gravure/archive/${year}/${mon}/ > ../data/index.html
    grep "こちらからチェック" ../data/index.html | sed -e 's|.*gravure/\(.*\)/photo/?p=\(.*\)" target=.*|http://youngjump.jp/gravure/\1/\2/photo/|' >> ../data/img_list.txt
    grep -B2 "こちらからチェック" ../data/index.html |  grep "<h3>" | sed -e 's/.*<h3>\(.*\)<\/h3>.*/\1/' >> ../data/name.txt
  done
done

paste -d, ../data/img_list.txt ../data/name.txt > ../data/img_list_n.txt

cat ../data/img_list_n.txt | while read line 
do
  for i in `seq 1 100`
  do
    img_url=`echo ${line} | cut -f1 -d,`${i}.jpg
    name=`echo ${line} | cut -f2 -d,`
    curl -o ../data/tmp.jpg ${img_url}
    file ../data/tmp.jpg | grep JPEG
    if [ $? = 0 ] ; then
      echo ${img_url},${name} >> ../data/tmp_img_url.txt
    else
      break
    fi
  done
done

join -v1 <(sort ../data/tmp_img_url.txt) <(sort ../data/posted_img.txt) > ../data/img_url.txt

