#!/bin/bash

FULL_PATH=`pwd`/$0
BASE_NAME=`basename $FULL_PATH`
CUR_DIR=`echo $FULL_PATH | sed s/$BASE_NAME//`
pushd $CUR_DIR > /dev/null

if [ ! -f a.out ]; then gcc hackjsontocsv.c; fi;

GAME_ID="$1"
AUTH="{\"user_id\":\"ID_HERE\",\"key\":\"KEY_HERE\"}"
curl --data "{\"game_id\":$GAME_ID,\"human\":true,\"identify\":true,\"auth\":$AUTH}" "http://arisgames.org/server/json.php/v2.log.getLogsForGame" | sed -e 's/^[^[]*//' -e 's/[^]]*$//' | grep -v -E '^\s*$' > game_data.json
./a.out game_data.json > game_data.csv

popd > /dev/null

