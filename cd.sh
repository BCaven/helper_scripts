#!/usr/bin/env sh

H=
TDIR="$HOME"
LS_FLAGS="--color"
usage() {
    echo "USAGE: [FLAGS] [DIRECTORY] [LS FLAGS]"
    H=$1
}
while [ $# -gt 0 ];
do
    case $1 in
        -h) usage "1";;
        -*) LS_FLAGS="$LS_FLAGS $1";;
        *) TDIR=$1 ;;
    esac
    shift
done

if [ "$H" != "1" ]; then
    echo $LS_FLAGS
    cd $TDIR
    clear && pwd && ls $LS_FLAGS
fi
unset H
unset TDIR
unset LS_FLAGS
