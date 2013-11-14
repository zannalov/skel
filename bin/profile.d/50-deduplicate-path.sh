#!/bin/sh

# First remove any leading, trailing, or multiple colons
export PATH="$( printf "$PATH" | sed 's/^:\+//;s/:\+$//;s/:\+/:/;' )"

# Remove all subsequent duplicate entries from the path, leaving only the first
# of each entry in the intended order
export PATH="$( printf "$PATH" | awk 'BEGIN{ORS=":";RS=":"}$0&&!a[$0]++' )"

# Remove the trailing record separator character left behind by awk
export PATH="${PATH%:}"
