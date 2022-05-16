#!/bin/sh

# If shell is running BASH and is interactive
if [ -n "$BASH_VERSION" ] && ( echo $- | grep i >/dev/null 2>&1 ); then

    # Check the window size after each command and, if necessary, update the
    # values of LINES and COLUMNS.
    shopt -s checkwinsize

fi
