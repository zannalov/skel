#!/bin/sh

# If shell is running BASH and is interactive (interpretation is BASH specific, PS1 only matters on interactive shells)
if [ -n "$BASH_VERSION" ] && ( echo $- | grep i >/dev/null 2>&1 ); then

    # Set variable identifying the chroot you work in (used in the
    # prompt below)
    if [[ -z "$debian_chroot" ]] && [[ -r /etc/debian_chroot ]]; then
        debian_chroot="$( cat /etc/debian_chroot )"
    fi
    
    # Set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
        screen) color_prompt=yes;;
    esac
    
    if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and
        # such a case would tend to support setf rather than setaf.)
        color_prompt=yes
    fi
    
    if [[ z$color_prompt = zyes ]]; then
        export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
        export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt debian_chroot

fi
