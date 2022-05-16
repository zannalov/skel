#!/bin/bash

file="$1"

echo -n "data:$( file -b --mime-type "$1" );base64,$( openssl base64 -in "$1" | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ /g' )" | pbcopy
echo "Copied to clipboard"
