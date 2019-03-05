#!/bin/sh

# Set the maximum size of the history, effectively infinite
export HISTSIZE="65535"

# If shell is running BASH (these variables and shopt are BASH specific)
if [ -n "$BASH_VERSION" ]; then

    # Record and display the date and timestamp of each command
    export HISTTIMEFORMAT='%F %T '

    # Choose the location of my history file
    # Comment one of these two out
    #unset HISTFILE
    export HISTFILE="${HOME}/.bash_history"

    # Don't store reduntant data, thanks
    export HISTCONTROL="ignorespace:ignoredups:erasedups"

    # Append to the history file, don't overwrite it
    shopt -s histappend

	# Save/Reload history post-command execution. If you choose to use this option, monitor .bash_history true history with:
		# watch -n1 "tail -n20 .bash_history
	# EXPLANATION OF COMMANDS used below:
		# history -n: MUST be included before `history -w` to read from .bash_history (commands saved from other terminals)
		# history -w: MUST be included to save history to file and erase dups
		# history -a: DO NOT USE, instead use `history -w` as `history -a` does not trigger dup removal
		# history -c: MUST be included to prevent damage to history buffer after issuing commands
		# history -r: Must be included to restore history buffer from file, and establishing cross-terminal session history
	PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
fi
