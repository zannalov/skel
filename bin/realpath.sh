#! /bin/sh

# Because the "realpath" command cannot be expected to exist, here is a quick
# pure-SH way of accomplishing the same thing by use of the "pwd -P" command

start="$(pwd)"
dir="${1%/*}"
file="${1##*/}"

# If there are no slashes in the provided path, it's just a location
# underneath the current directory
if [ "$1" = "$dir" ]; then
    echo "$start/$1"
    return 0
fi

# Get the full parent directory for the target path
cd "$dir" || exit 1
dir="$(pwd -P)"

# Go back where we came from (relative to symlinks) to prevent breaking
# later parts of the script
cd "$start" || exit 1

# If the dir is root, don't output a double-slash
if [ "/" = "$dir" ]; then
    echo "/$file"
    return 0
fi

# Echo the full target path
echo "$dir/$file"
