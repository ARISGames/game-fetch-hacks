#!/bin/bash

FULL_PATH=`pwd`/$0
BASE_NAME=`basename $FULL_PATH`
CUR_DIR=`echo $FULL_PATH | sed s/$BASE_NAME//`
pushd $CUR_DIR > /dev/null

if [ ! -d notes ]; then mkdir notes; fi;

for i in $@; do ./getNotes.sh $i; mv *.zip notes/; done;

popd > /dev/null

