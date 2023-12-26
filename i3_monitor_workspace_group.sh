#!/usr/bin/env bash

# original script from here:
# https://www.reddit.com/r/i3wm/comments/5zwbg0/different_workspace_groups_per_monitor/

action="$1"
eval $(xdotool getmouselocation --shell)

focused_workspace=`i3-msg -t get_workspaces | jq --raw-output '.[]|select(.focused).name'`
active_workspace=${focused_workspace: -1}
echo active postfix $active_workspace
if [[ "$action" == "left" ]]; then
    if [ "$active_workspace" -ge "1" ]; then
        active_workspace=$(( $active_workspace -1 ))
    fi
elif [[ "$action" == "right" ]]; then
    active_workspace=$(( $active_workspace + 1 ))
elif [ "$action" == "goto" ] || [ "$action" == "move" ]; then
    active_workspace="$2"
fi
echo after modification $active_workspace

target_workspace=${SCREEN}${active_workspace}

echo combination $target_workspace

if [[ "$action" == "move" ]]; then
    i3-msg "move container to workspace $target_workspace"
elif [[ "$action" == "init" ]]; then
    echo creating starting workspace for every monitor
    for item in `xrandr --listmonitors | tail -n+2 | awk '{printf "NUMBER=%sMONITOR=%s\n",$1,$4;}'`; do
        eval `echo $item | tr ':' '\n'`
        echo number = $NUMBER name = $MONITOR
        target_workspace=${NUMBER}1
        echo target workspace = $target_workspace
        # send that workspace to its monitor
        i3-msg "workspace $target_workspace output $MONITOR"
    done
    # focus the first workspace on output 0
    i3-msg "workspace 01"


else
    echo going to workspace $target_workspace
    i3-msg "workspace $target_workspace"
fi
