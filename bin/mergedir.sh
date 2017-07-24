#!/bin/sh
#
# mergedir --merge two directories of files, with collision handling.
#
# Remarks:
# Collisions are handled by renaming the src file to ".orig", or an
# extension specified by "-e".
#
ext="orig"
verbose=0
opts="e:v"
usage="Usage:\nmergedir [-e ext] [-v] <src-dir> <dst-dir>"

while getopts $opts c
do
    case $c in
    e)	ext=$OPTARG;;
    v)	verbose=1;;
    \?)	echo $usage >&2
	exit 2;;
    esac
done
shift $(expr $OPTIND - 1)
if [ $# != 2 ]; then
    printf '%s\n' "$usage" >&2
    exit 2
fi
src=$1; shift;
dst=$1; shift;

find $src -type f | (
    while read path; do
	relpath=$(echo $path | sed -e"s@$src@@")
	if [ -f "$dst/$relpath" ]; then
	    if cmp -s "$path" "$dst/$relpath"; then
		test ! -z "$verbose" && echo "# $dst/$relpath is OK"
	    else
		test ! -z "$verbose" && echo "\"$path\" => \"$dst/$relpath.$ext\""
		mv "$path" "$dst/$relpath.$ext"
	    fi
	else
	    dstpath=$(dirname "$dst/$relpath")
	    if [ ! -d "$dstpath" ]; then
		test ! -z "$verbose" && echo "mkdir \"$dstpath\""
		mkdir -p "$dstpath"
	    fi
	    test ! -z "$verbose" && echo "\"$path\" => \"$dst/$relpath\""
	    mv "$path" "$dst/$relpath"
	fi
    done
)
exit 0;
