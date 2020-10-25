#!/bin/sh

args="$@ --host=0.0.0.0 -p 80"

file=/data/db.json
if [ -f $file ]; then
    echo "Found db.json, trying to open"
    args="$args db.json"
fi

file=/data/file.js
if [ -f $file ]; then
    echo "Found file.js seed file, trying to open"
    args="$args file.js"
fi

while getopts ":d:" opt; do
  case $opt in
    d) sample_data="$OPTARG"
      args="extras/${args//-d }"
    ;;
    \?) # echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

echo "Starting json-server with these arguments >>> $args "

json-server $args


