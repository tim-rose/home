#!/bin/sh
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
