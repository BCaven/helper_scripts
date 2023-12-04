#!/usr/bin/env sh


bed_time="2300" # TODO: link bed time and wake time to Oura API
wake_time="0600"
watchlist="watchlist.txt"
woken_up="false"

while [ $# -gt 0 ]
do
    case $1 in
        -b) shift; bed_time="$1";;
        -w) shift; wake_time="$1";;
        -l) shift; watchlist="$1";;
        *) echo "`basename $0`: usage [-b HHMM | -w HHMM | -l FILENAME]"; exit 1;;
    esac
done

while [ "$woken_up" = "false" ] ;
do
    time=`date +%H%M`
    if [ "$time" -gt "$bed_time" ] ; then
        echo "normal mode - past bedtime"
        for item in `cat $watchlist`;
        do
            killall $item
        done
    elif [ "$time" -lt "$wake_time" ] ; then
        echo "normal model - before wake time"
        for item in `cat $watchlist`;
        do
            killall -9 $item
        done
    fi
    sleep 5m
done
