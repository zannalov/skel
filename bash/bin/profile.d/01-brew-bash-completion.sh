#!/bin/sh

if [ "$( type -t brew 2>/dev/null )" = "file" ]; then
    if [ -f $( brew --prefix )/etc/bash_completion ]; then
        . $( brew --prefix )/etc/bash_completion
    fi
fi
