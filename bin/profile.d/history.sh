#!/bin/sh

# Set the maximum size of the history, effectively infinite
export HISTSIZE="65535"

# If shell is running BASH (these variables and shopt are BASH specific)
if [ -n "$BASH_VERSION" ]; then

    # Record and display the date and timestamp of each command
    export HISTTIMEFORMAT='%F %T '

    # Choose the location of my history file
    # Comment one of these two out
    #unset HISTFILE
    export HISTFILE="${HOME}/.bash_history"

    # Don't store reduntant data, thanks
    export HISTCONTROL="ignorespace:ignoredups:erasedups"

    # Append to the history file, don't overwrite it
    shopt -s histappend

fi
