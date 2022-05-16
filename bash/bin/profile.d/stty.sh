#!/bin/sh

# If shell is interactive
if ( echo $- | grep i >/dev/null 2>&1 ); then

    # Disable start/stop keystrokes, expect us to do it with external commands
    stty start "" stop "" &>/dev/null

fi
