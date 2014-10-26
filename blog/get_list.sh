#/bin/sh

genre=$1
sdir="/home/grass/blog/script"
ddir="/home/grass/blog/data/"${genre}

rm ${ddir}/list/*.html
wget -i ${ddir}/list/blog_list.txt -P ${ddir}/list

cat /dev/null > ${ddir}/url_list.txt
find ${ddir}/list/ -name *.html -exec ruby ${sdir}/mk_url_list.rb {} \;

