Installation
============

    $ git init ~/.zannalov-skel
    $ cd ~/.zannalov-skel
    $ git config core.worktree "$HOME"
    $ git remote add origin git@github.com:zannalov/skel
    $ git fetch
    $ git checkout master

If there are conflicts at this point, that means something in my skeleton
conflicts with that which is already on your machine. There are a couple ways
of going about solving this. Here are a few ideas:

1.  Start your own machine-specific branch, commit those files, then merge in from my master branch (resolving the conflicts as you see fit).
2.  Move your files out of the way, then run the checkout command again
3.  Clone this repository as a plain-old repository and selectively import the bits you want

Machine-specific ignores
========================

You may either maintain your own branch (committing to your own ~/.gitignore),
or you may add things to the repository-specific ignore file.

    # This would exclude the ".bash_profile" file from your home directory, but
    # not, for example, "~/test-directory/.bash_profile"
    $ echo '/.bash_profile' >> ~/.zannalov-skel/.git/info/exclude

Working with the repository
===========================

You must be within its directory

    $ cd ~/.zannalov-skel

Or you must use the --git-dir option

    $ git --git-dir=~/.zannalov-skel/.git
