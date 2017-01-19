#!/bin/sh

my_grep_options=(--color=auto) # I like color, without deprecation warnings

if ( _version_gte "$( grep -V | head -n 1 | sed 's/[^0-9]*\([0-9]*\.[0-9]*\).*/\1/' )" "2.5.2" ); then
    # The following adds new options for grep to exclude: CVS, .cvs, .git, .hg, .svn directories
    my_grep_options=(${my_grep_options[@]}  --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn --exclude-dir=CVS)
    alias grep="${BASH_ALIASES[grep]:-grep} my_grep_options"
fi
