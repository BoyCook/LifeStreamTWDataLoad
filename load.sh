#!/bin/bash

HOST=127.0.0.1:8080

# Create bags - todo use load_dir
curl -X PUT -H 'Content-Type: application/json' -d @bags/tweets.json http://$HOST/bags/tweets
curl -X PUT -H 'Content-Type: application/json' -d @bags/blogs.json http://$HOST/bags/blogs
curl -X PUT -H 'Content-Type: application/json' -d @bags/blogs.json http://$HOST/bags/static

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

# ContentType - File - Bag - Name
function load_file() {	
	curl -X PUT -H "Content-Type: $1" --data-binary "@$2" http://$HOST/bags/$3/tiddlers/$4
}

# load_dir bags 6
load_dir tweets 23
load_dir blogs 7

load_file image/jpeg static/images/craig.jpg static craig.jpg

load_file application/vnd.ms-fontobject static/css/Elusive-Icons.eot static Elusive-Icons.eot
load_file image/svg+xml static/css/Elusive-Icons.svg static Elusive-Icons.svg
load_file application/x-font-ttf static/css/Elusive-Icons.ttf static Elusive-Icons.ttf
load_file application/octet-stream static/css/Elusive-Icons.woff static Elusive-Icons.woff

load_file text/css static/css/default.css static default.css
load_file text/css static/css/layout.css static layout.css
load_file text/css static/css/elusive-webfont.css static elusive-webfont.css
load_file text/javascript static/js/default.js static default.js
