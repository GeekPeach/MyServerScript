#!/bin/sh

genre=${1}
sdir="/home/grass/dmm/script"
ddir="/home/grass/dmm/data/${genre}"

sh ${sdir}/wget.sh ${genre}
sh ${sdir}/mk_review.sh ${genre}
sh ${sdir}/add_uniqid.sh ${genre}
sh ${sdir}/get_new_comment.sh ${genre}

sh ${sdir}/mk_item.sh ${genre}
sh ${sdir}/get_uniq.sh ${genre} "item"
sh ${sdir}/item2rev.sh

