#!/bin/sh

# If we have completion
if [ "$( type -t _command 2>/dev/null )" = "function" ]; then
    complete -F _command sit
fi
