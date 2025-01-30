#!/usr/bin/env sh

# used as an automatic status check for emacs daemons on remote machines
# does not automatically start the daemon if not detected since that choice
# was supposed to be left to the user

if ps aux | grep -E "^jcaven.*emacs -nw$"; then
    echo emacs is running
else
    echo emacs is not running
fi
