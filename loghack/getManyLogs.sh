#!/bin/bash

FULL_PATH=`pwd`/$0
BASE_NAME=`basename $FULL_PATH`
CUR_DIR=`echo $FULL_PATH | sed s/$BASE_NAME//`
pushd $CUR_DIR > /dev/null

if [ ! -d logs ]; then mkdir logs; fi;

for i in $@; do ./getLogs.sh $i; mv game_data.csv logs/${i}_game_data.csv; done;

popd > /dev/null

