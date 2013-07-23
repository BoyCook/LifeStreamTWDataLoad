#!/bin/bash

HOST=127.0.0.1:8080

# Create bags - todo use load_dir
curl -X PUT -H 'Content-Type: application/json' -d @bags/tweets.json http://$HOST/bags/tweets
curl -X PUT -H 'Content-Type: application/json' -d @bags/blogs.json http://$HOST/bags/blogs

function load_dir() {	
	DIR=$1
	LEN=$2
	cd $DIR
	for FILE in *
	do
		if [ -f "$FILE" ]
		then
			NAME=${FILE:0:$LEN}
			# echo $NAME
			curl -X PUT -H 'Content-Type: application/json' -d "@$FILE" http://$HOST/bags/$DIR/tiddlers/$NAME
		fi	
	done
	cd ../
}

# load_dir bags 6
load_dir tweets 23
load_dir blogs 7
