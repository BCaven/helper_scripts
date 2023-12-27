#!/usr/bin/env bash

# original script from here:
# https://www.reddit.com/r/i3wm/comments/5zwbg0/different_workspace_groups_per_monitor/

action="$1"
# eval $(xdotool getmouselocation --shell) # sadly this thinks all the screens are just one big screen

# using i3-msg
# script grabbed from here: https://www.reddit.com/r/i3wm/comments/gsdrsy/can_i_get_the_currently_active_output_screen/
focused_workspace=`i3-msg -t get_workspaces|jq '.[] | select(.focused).name'`
SCREEN=`i3-msg -t get_outputs | jq -r ".[] | select((.active) and (.current_workspace==$focused_workspace)).name"`
echo $SCREEN
active_workspace=${focused_workspace//\"}
active_workspace=${active_workspace: -1}
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

target_workspace=${SCREEN}-${active_workspace}

echo combination $target_workspace

if [[ "$action" == "move" ]]; then
    i3-msg "move container to workspace $target_workspace"
elif [[ "$action" == "init" ]]; then
    echo creating starting workspace for every monitor
    for item in `xrandr --query | grep " connected" | cut -d" " -f1`; do
        target_workspace=${item}-1
        echo target workspace = $target_workspace
        # send that workspace to its monitor
        echo sending $target_workspace to $item
        i3-msg "focus output $item , workspace $target_workspace"
        #i3-msg "workspace $target_workspace"
    done


else
    echo going to workspace $target_workspace
    i3-msg "workspace $target_workspace"
fi
