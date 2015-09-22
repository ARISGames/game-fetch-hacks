#!/bin/bash

FULL_PATH=`pwd`/$0
BASE_NAME=`basename $FULL_PATH`
CUR_DIR=`echo $FULL_PATH | sed s/$BASE_NAME//`
pushd $CUR_DIR > /dev/null

GAME_ID="$1"
AUTH="{\"user_id\":\"ID_HERE\",\"key\":\"KEY_HERE\"}"
curl --data "{\"game_id\":$GAME_ID,\"human\":true,\"identify\":true,\"auth\":$AUTH}" "http://arisgames.org/server/json.php/v2.notes.exportNotes" | sed -e 's/^.*data":"//' -e 's/","returnCode.*$//' -e 's/\\//g' | grep -v -E '^\s*$' > url.txt
wget `cat url.txt`
rm url.txt

popd > /dev/null

