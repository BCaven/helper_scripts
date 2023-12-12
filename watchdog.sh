#!/usr/bin/env sh

# BUG: in sway, if the application is in full screen mode, it will not be deleted

bed_time="2300" # TODO: link bed time and wake time to Oura API
wake_time="0600"
watchlist="watchlist.txt"

while [ $# -gt 1 ]
do
    case $1 in
        -b) shift; bed_time="$1";;
        -w) shift; wake_time="$1";;
        -l) shift; watchlist="$1";;
        *) echo "`basename $0`: usage [-b HHMM | -w HHMM | -l FILENAME]"; exit 1;;
    esac
done


kill_programs () {
    for item in `cat $watchlist`;
    do
        # TODO: implement sway-friendly version
        killall -9 $item
    done
}

while true ;
do
    time=`date +%H%M`
    # if time is between bed_time and wake_time - kill programs
    # options:
    # bed time is before wake time - bed_time < time && time < wake_time
    # bed time is after wake time - bed_time < time || time < wake_time

    if [ "$bed_time" -lt "$wake_time" ] && [ "$bed_time" -lt "$time" ] && [ "$time" -lt "$wake_time" ] ; then
        kill_programs
    elif [ "$wake_time" -lt "$bed_time" ] ; then
        if [ "$bed_time" -lt "$time" ] || [ "$time" -lt "$wake_time" ] ; then
            kill_programs
        fi
    fi


    sleep 5m
done
