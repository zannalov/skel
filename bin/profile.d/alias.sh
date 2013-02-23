#!/bin/sh

# If shell is interactive
if ( echo $- | grep i >/dev/null 2>&1 ); then

    # First remove all aliases (no unexpected ones)
    unalias -a

    alias df='df -H -T'
    alias diff='diff --exclude=CVS --exclude=.svn --exclude=.git'
    alias du='du --si --one-file-system --max-depth=1 --total'
    alias free='free -l -m -t'
    alias ls='ls --color=auto -v --si -F -i -l'
    alias ps='ps -A --format=euser,egroup,tname,pid,ppid,rss,args --forest'

fi
