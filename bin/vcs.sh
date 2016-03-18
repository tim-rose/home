#!/bin/sh
#
# VCS --Detect the version control system, if any.
#
# Remarks:
# This just walks up the directory tree looking for 
# signs of a VCS (e.g. the cache/repo directory).
# REVISIT: consider printing the directory too?
#
main()
{
    local dir=$PWD
    while [ "$dir" ]; do
        if [ -e "$dir/.svn" ]; then
            echo "svn"
        elif [ -e "$dir/.git" ]; then
            echo "git"
        fi
        dir=${dir%/*}
    done
}
main "$@"
