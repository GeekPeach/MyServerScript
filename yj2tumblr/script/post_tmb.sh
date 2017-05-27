#!/bin/bash

cd /Users/shimizukoutarou/Develop/MyServerScript/yj2tumblr/script

url=`head -1 ../data/img_url.txt | cut -f1 -d,`
name=`head -1 ../data/img_url.txt | cut -f2 -d,`

ruby post_tmb2.rb ${url} ${name}
head -1 ../data/img_url.txt >> ../data/posted_img.txt
sed -i -e '1d' ../data/img_url.txt
rm pic_yj.jpg

