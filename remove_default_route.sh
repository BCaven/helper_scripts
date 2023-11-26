#!/bin/sh

# in linux, ethernet should take priority, so this script is here to remove that from the routing table (lol)

default_device=`route -n | awk "NR==3{print;exit}" | grep -E en`
echo $default_device
