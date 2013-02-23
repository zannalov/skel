#!/bin/sh

# If we have completion
if ( type _command 2>/dev/null | grep 'function' 1>/dev/null 2>/dev/null ); then
    complete -F _command sit
fi
