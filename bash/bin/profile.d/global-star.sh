#!/bin/sh

# If shell is running BASH (shopt is BASH specific)
if [ -n "$BASH_VERSION" ]; then

    # If set, the pattern "**" used in a pathname expansion context will match
    # all files and zero or more directories and subdirectories.
    shopt -s globstar >/dev/null 2>/dev/null

fi
