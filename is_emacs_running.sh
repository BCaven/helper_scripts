#!/usr/bin/env sh

if ps aux | grep -E "^jcaven.*emacs -nw$"; then
    echo emacs is running
else
    echo emacs is not running
fi
