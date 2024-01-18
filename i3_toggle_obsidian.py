#!/usr/bin/env python3.12
"""
Toggle obsidian.

Small script to save changes to files when obsidian is closed and to
check for remote changes when obsidian is opened.
"""

# using the python equivalent of i3-msg
# pip install i3ipc
import i3ipc
import os
OBSIDIAN_VAULT = "/home/bake/Documents/obsidian-workspace"


def main():
    """Run when the obsidian hotkey is hit."""
    i3 = i3ipc.Connection()
    tree = i3.get_tree()
    for con in tree:
        if con.window:
            if con.window_class == "obsidian":
                # toggle obsidian
                i3.command('[class="obsidian"] scratchpad show; sticky enable')
                if con.workspace().name == "__i3_scratch":
                    # load from github
                    print("pulling from github")
                    return_val = os.system(
                        f'(cd {OBSIDIAN_VAULT} && pwd && git pull --rebase)')
                    if return_val != 0:
                        os.system('dunstify "Obsidian Workspace: failed to pull from remote"')
                else:
                    # push to github
                    print("pushing to github")
                    return_val = os.system(
                        f'(cd {OBSIDIAN_VAULT} && git add -A && git commit -m "automated update" && git push -u origin main)'
                    )
                    if return_val != 0:
                        os.system('dunstify "Obsidian Workspace: failed to push to remote"')


if __name__ == "__main__":
    main()
