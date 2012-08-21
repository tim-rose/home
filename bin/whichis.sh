#!/bin/sh
# WHICHIS --tell the user what a command really is.
#
path=$PATH
usage="Usage: whichis [-p path] file..."
while getopts "p:" c
do
    case $c in
    p)  path="$OPTARG"
        ;;
    \?)	echo $USAGE >&2
	exit 2;;
    esac
done
shift $(($OPTIND - 1))

for file in $*; do
    IFS=":"
    for path in $PATH; do
	if [ -f $path/$file ]; then
	    file $path/$file
	fi
    done
done
