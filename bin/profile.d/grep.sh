#!/bin/sh

export GREP_OPTIONS=""
export GREP_OPTIONS="$GREP_OPTIONS"' --colour=auto' # I like color

if ( _version_gte "$( grep -V | head -n 1 | sed 's/[^0-9]*\([0-9]*\.[0-9]*\).*/\1/' )" "2.5.2" ); then
    export GREP_OPTIONS="$GREP_OPTIONS"' --exclude-dir="CVS"' # Exclude CVS directories
    export GREP_OPTIONS="$GREP_OPTIONS"' --exclude-dir=".svn"' # Exclude Subversion directories
    export GREP_OPTIONS="$GREP_OPTIONS"' --exclude-dir=".git"' # Exclude Git directory
fi
