#!/bin/bash
#
# CHOOSE --select from a list of names
#
help='Please type y(=yes) n(=no) a(=all remaining) q(=quit, none selected)'
newlist=""
ask=1
allfiles=$*
nfiles=$(echo $allfiles|wc -w)
for file in $allfiles
do
    if [ $ask -eq 1 ]; then
	printf '\n%s? [ynaq]: ' "$file" >/dev/tty
	read -n1 c		# bashism
        printf '\n\n'
    fi
    case $c in
    y) newlist="$newlist $file";;
    a) newlist="$newlist $file"; ask=0; c="y";;
    q) exit 1;;
    \?) printf '\n%s' "$help" >/dev/tty;;
    *) ;;
    esac
done
if [ "$newlist" ]; then
    echo $newlist
fi
exit 0
