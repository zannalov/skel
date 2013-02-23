#!/bin/sh

export GREP_OPTIONS=""
export GREP_OPTIONS="$GREP_OPTIONS"' --colour=auto' # I like color
export GREP_OPTIONS="$GREP_OPTIONS"' --exclude-dir="CVS"' # Exclude CVS directories
export GREP_OPTIONS="$GREP_OPTIONS"' --exclude-dir=".svn"' # Exclude Subversion directories
export GREP_OPTIONS="$GREP_OPTIONS"' --exclude-dir=".git"' # Exclude Git directory
