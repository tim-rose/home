#!/bin/sh
#
# CMPMV --Compare and conditionally move a file to a new name.
#
force=0
verbose=0
opts="fv"
usage="Usage:\ncmpmv [-f] [-v]<src-file> <dst-file>\ncmpmv <src-files> <dst-dir>"

while getopts $opts c
do
    case $c in
    f)	force=1;;
    v)	verbose=1;;
    \?)	echo $usage >&2
	exit 2;;
    esac
done
shift `expr $OPTIND - 1`
src=$1; shift;
dst=???
if [ $# = 2 ]; then
    dst=$1; shift;
    if [ -d $dst ]; then
	dst=$dst/`basename $src`
    fi
    if cmp $src $dst; then
    else
       mv $src $dst
    fi
else
fi
