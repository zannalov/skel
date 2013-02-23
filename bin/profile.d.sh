#!/bin/bash

for f in $HOME/bin/profile.d/* ; do
    if [[ -x "$f" ]]; then
        source "$f"
    fi
done
