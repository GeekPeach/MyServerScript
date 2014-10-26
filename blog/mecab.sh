#/bin/sh

genre=$1
sdir="/home/grass/blog/script"
ddir="/home/grass/blog/data/${genre}"

cut -f4 ${ddir}/blog_db.new > ${ddir}/body.txt
/usr/local/rbenv/shims/ruby ${sdir}/char_trans.rb ${genre}
/usr/local/bin/mecab -O wakati -b 65536 ${ddir}/body.trns > ${ddir}/body.mecab
cat ${ddir}/body.mecab | sed -e 's/ 109 / \"109\" /g' | sed -e 's/ [0-9]\+ / /g' | sed -e 's/^[0-9]\+//g' | sed -e 's/ [0-9]\+$//g' | sed -e 's/ [0-9]\+:[0-9]\+ / /g' | sed -e 's/\([^ ]\)\1\{3,\}/\1\1\1/g' > ${ddir}/body.mecab.nonum

