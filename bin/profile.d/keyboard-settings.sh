#!/bin/sh

if ( hash uname >/dev/null 2>/dev/null ); then
    if [ "Linux" = "$( uname )" ]; then
        if ( hash setxkbmap >/dev/null 2>/dev/null ); then
            setxkbmap -option compose:rwin
        fi
    fi
fi
