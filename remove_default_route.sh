#!/bin/sh

# in linux, ethernet should take priority, so this script is here to remove that from the routing table (lol)

default_device=`route -n | awk 'NR==3{print $8;exit}'`
wifi_device="wlp3s0"
if [[ "$default_device" != "$wifi_device" ]]; then
	echo "not using wifi"
	route del default
else
	echo "using wifi as default"
fi
