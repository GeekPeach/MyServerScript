#/bin/sh

genre=$1
sdir="/home/grass/blog/script"
ddir="/home/grass/blog/data/${genre}"

LC_ALL=C sort ${ddir}/sum_wdic.dump > ${ddir}/sum_wdic.sort
#LC_ALL=C join -t$'\t' -j1 -a1 -a2 ${ddir}/sum_wdic.tsv ${ddir}/sum_wdic.sort > ${ddir}/sum_wdic.tmp
LC_ALL=C join -t$'\t' -j1 -a1 ${ddir}/sum_wdic.tsv ${ddir}/sum_wdic.sort | cut -f1-2,4-6 > ${ddir}/sum_wdic.tsv.tmp
LC_ALL=C join -t$'\t' -j1 -v2 ${ddir}/sum_wdic.tsv ${ddir}/sum_wdic.sort | sort -r -k2,2 > ${ddir}/wdic.new
awk -F'\t' '{ print $1, "0", "0", "0", $2 }' ${ddir}/wdic.new | sed -e 's/ /\t/g' > ${ddir}/sum_wdic.new.tmp
cat ${ddir}/sum_wdic.new.tmp ${ddir}/sum_wdic.tsv.tmp > ${ddir}/sum_wdic.tmp
/usr/local/rbenv/shims/ruby ${sdir}/sum_wdic.rb ${genre}
LC_ALL=C sort -k1,1 -t$'\t'  ${ddir}/sum_wdic.sum > ${ddir}/sum_wdic.tsv
#rm ${ddir}/sum_wdic.tmp

