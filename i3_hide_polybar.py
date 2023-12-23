#!/usr/bin/env python3.11
"""
Toggle polybar upon MOD press using pynput.

Script to check if the MOD key has been pressed.
NOTE: only works on X
NOTE: this program is unnecessary when using sway

BUG: pynput is not yet compatable with python 3.12 because
of dependency `evdev`

used to toggle polybar as visible or hidden in place of a i3 binding
because i3 does not trigger the binding if multiple keys are pressed
in conjunction with a mod key

An example of this script can be found here:
https://www.reddit.com/r/i3wm/comments/10sdnaj/i_made_a_python_script_to_hide_and_show_the/
"""
from pynput.keyboard import Key, Listener
import os


def on_press(key):
    """Show the polybar."""
    if key == Key.cmd:
        os.system('polybar-msg cmd show')


def on_release(key):
    """Hide the polybar."""
    if key == Key.cmd:
        os.system('polybar-msg cmd hide')


def main():
    """Driver for the program."""
    # make sure we dont start a new process if one is already running
    os.system(f"for pid in `ps aux | grep -v {os.getpid()} | awk '/i3_hide_polybar.py/ {{print $2}}'`; do kill $pid ; done")

    # start the listener
    with Listener(
        on_press=on_press,
        on_release=on_release
    ) as listener:

        listener.join()


if __name__ == "__main__":
    main()
