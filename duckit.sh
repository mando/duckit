#!/usr/bin/bash

duckit() {
  filename=$(basename -- "$1")
  extension="${filename##*.}"
  filename="${filename%.*}"

  tmp_db=$(mktemp).db

  duck_cmd=""
  if [[ "json" == "$extension" ]]; then
    duck_cmd="read_json('$1')"
  elif [[ "csv" == "$extension" ]]; then
    duck_cmd="read_csv('$1', store_rejects = true)"
  elif [[ "xlsx" == "$extension" ]]; then
    duck_cmd="read_xlsx('$1')";
  else
    echo "only csvs and xlsx and json my guy sorry!"
    return 1
  fi

  duckdb -init /dev/fd/3 3<<<$(
cat <<EOF
.print "Creating table 't' from $1"
create table t as select * from $duck_cmd;
describe t;
.echo off
EOF
  )
} 
