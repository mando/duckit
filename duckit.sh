#!/usr/bin/bash

duckit() {
  filename=$(basename -- "$1")
  extension="${filename##*.}"
  filename="${filename%.*}"

  tmp_db=$(mktemp).db

  duck_cmd=""
  if [[ "json" == "$extension" ]]; then
    duck_cmd="read_json('/dev/stdin')"
  elif [[ "csv" == "$extension" ]]; then
    duck_cmd="read_csv('/dev/stdin', store_rejects = true)"
  else
    echo "only csvs and json my guy sorry!"
    return 1
  fi

  duckdb "$tmp_db" "create table t as select * from $duck_cmd" < "$1" && duckdb "$tmp_db"
}
