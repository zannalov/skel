#!/bin/sh

# Comment one of these two out
#export LESSHISTFILE="/dev/null"
export LESSHISTFILE="${HOME}/.lesshst"

# Set the maximum size of the history, effectively infinite
export LESSHISTSIZE="65535"

# Set command line options
export LESS=""
export LESS="$LESS"' --no-lessopen' # Don't run through XXD or the like
export LESS="$LESS"' --RAW-CONTROL-CHARS' # Pass ANSI Color Codes (ESC[...m) through
export LESS="$LESS"' --chop-long-lines' # :set nowrap
export LESS="$LESS"' --dumb' # Suppress error if terminal is dumb
export LESS="$LESS"' --force' # Suppress error if file is special
export LESS="$LESS"' --ignore-case' # Ignore search case if search is lower case
export LESS="$LESS"' --buffers=-1' # Infinite buffer space
export LESS="$LESS"' --shift=4' # Left-right keys
