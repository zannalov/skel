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

my_grep_options=(--color=auto) # I like color, without deprecation warnings

if ( _version_gte "$( grep -V | head -n 1 | sed 's/[^0-9]*\([0-9]*\.[0-9]*\).*/\1/' )" "2.5.2" ); then
    # The following adds new options for grep to exclude: CVS, .cvs, .git, .hg, .svn directories
    my_grep_options=(
        ${my_grep_options[@]} --exclude-dir=CVS)    # Excludes CVS directories for CVS
        ${my_grep_options[@]} --exclude-dir=.cvs)   # Excludes .cvs directories for CVS
        ${my_grep_options[@]} --exclude-dir=.git)   # Excludes .git directories for Git
        ${my_grep_options[@]} --exclude-dir=.hg)    # Excludes .hg directories for Mercurial
        ${my_grep_options[@]} --exclude-dir=.svn)   # Excludes .svn directors for Subversion
    )
    alias grep="grep $my_grep_options"
    unset my_grep_options
fi
