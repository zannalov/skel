#!/bin/sh

# If shell is interactive
if ( echo $- | grep i >/dev/null 2>&1 ); then

    # First remove all aliases (no unexpected ones)
    unalias -a

    alias d='date -u +%Y-%m-%d-%H%M%Sz'
    alias diff='diff --exclude=CVS --exclude=.svn --exclude=.git'
    alias free='free -l -m -t'

    if [ "Darwin" = "$( uname )" ]; then
        alias df='df -H'
        alias du='du -x -d 1 -c'
        alias ls='ls -G -v -F -i -l'
        alias ps='ps -A -o pid,ppid,rss,args'
    fi

    if [ "Linux" = "$( uname )" ]; then
        alias df='df -H -T'
        alias du='du --si --one-file-system --max-depth=1 --total'
        alias ls='ls --color=auto -v --si -F -i -l'
        alias ps='ps -A --format=euser,egroup,tname,pid,ppid,rss,args --forest'
    fi

fi
