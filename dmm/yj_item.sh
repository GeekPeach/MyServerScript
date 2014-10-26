#!/bin/sh
genre="yj"
sdir="/home/grass/dmm/script"
ddir="/home/grass/dmm/data/${genre}"
name=${1}

sh mk_dl_list.sh ${name}
sh ${sdir}/wget.sh ${genre}
#sh ${sdir}/mk_yj_review.sh ${genre}
sh ${sdir}/mk_yj_item.sh ${genre}
#sh ${sdir}/add_uniqid.sh ${genre}
#sh ${sdir}/get_new_comment.sh ${genre}
sh ${sdir}/get_new_item.sh ${genre}
