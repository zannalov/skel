Installation
============

First clone this repository into your home directory

    $ git clone --config core.worktree="$HOME" git@github.com:zannalov/skel ~/.zannalov

Add any machine-specific ignore files to the repository's exclude file instead of ~/.gitignore

    # This would exclude the ".bash_profile" file from your home directory, but not, for example, "~/test-directory/.bash_profile"
    $ echo '/.bash_profile' >> ~/.zannalov/.git/info/exclude

Working with the repository
===========================

You must be within its directory

    $ cd ~/.zannalov

Or you must use the --git-dir option

    $ git --git-dir=~/.zannalov/.git
