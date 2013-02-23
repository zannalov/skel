#!/bin/sh

# If shell is interactive
if ( echo $- | grep i >/dev/null 2>&1 ); then

    # Remove all aliases
    unalias -a

fi
