#!/bin/sh

# If shell is interactive (don't print this before running an SSH command, for example)
if ( echo $- | grep i >/dev/null 2>&1 ); then

    # If not in screen, list open screen sessions
    if [[ "" == "${WINDOW}" ]]; then
        screen -ls
    fi

fi
