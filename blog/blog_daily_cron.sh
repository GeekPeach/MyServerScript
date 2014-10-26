#/bin/sh

genre=$1
sdir="/home/grass/blog/script"
ddir="/home/grass/blog/data/${genre}"

sh ${sdir}/wget.sh ${genre}
rm ${ddir}/blog_db.new
#find ${ddir}/ -name *.html -mmin -1440 -exec /usr/local/rbenv/shims/ruby ${sdir}/get_content.rb {} ${genre} \;
find ${ddir}/ -name *.html -exec /usr/local/rbenv/shims/ruby ${sdir}/get_content.rb {} ${genre} \;

sh ${sdir}/mecab.sh ${genre}
/usr/local/rbenv/shims/ruby ${sdir}/resis_wdic.rb ${genre}
cat ${ddir}/blog_db.new >> ${ddir}/blog_db.csv

/usr/local/rbenv/shims/ruby ${sdir}/dump_wdic.rb ${genre} > ${ddir}/sum_wdic.dump

sh ${sdir}/sum_wdic.sh ${genre}
redis-cli flushdb

