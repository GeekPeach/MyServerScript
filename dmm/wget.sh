#!/bin/sh

cd /home/grass/dmm/data/${1}
rm -rf www.dmm.*/
wget -nv -i ${1}.txt -r -l 1 -I "/digital/"
