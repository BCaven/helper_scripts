#!/bin/bash -

Usage() { echo "$0 FontFile"; exit 1; }
[ "$#" -ne 1 ] && Usage
fontfile="$1"
width=70
list=`fc-query --format='%{charset}\n' "$fontfile"`

for range in $list
do IFS=- read start end <<<"$range"
    if [ "$end" ]
    then
        start=$((16#$start))
        end=$((16#$end))
        for((i=start;i<=end;i++)); do
            printf -v char '\\U%x' "$i"
            printf '%b' "$char"
        done
    else
        printf '%b' "\\U$start"
    fi
done | grep -oP '.{'"$width"'}'