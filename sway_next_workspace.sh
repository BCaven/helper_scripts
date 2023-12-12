#!/usr/bin/env sh

swaysome="$HOME/.cargo/bin/swaysome"
current=`swaymsg -p -t get_workspaces | grep focused | sed -n -E 's/.*[0-9]([0-9]).*/\1/p'`
echo $current
if [ "$1" == "-r" ] ; then
    new=$(( $current + 1 ))
    $swaysome focus $new
elif [ "$1" == "-l" ] ; then
    if [ "$current" -ge "1" ] ; then
        new=$(( $current - 1 ))
        $swaysome focus $new
    fi

fi
