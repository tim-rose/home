#!/bin/bash
#
# CHOOSE --Select from a list of names.
#
# Remarks:
# Doesn't handle files containing spaces.
#
help='Please type y(=yes) n(=no) a(=all remaining) q(=quit, none selected)'
newlist=""
confirm='y'
for file in "$@"
do
    if [ "$confirm" ]; then
	printf '\n%s? [ynaq]: ' "$file" >/dev/tty
	read -n1 c		# bashism
        printf '\n\n'
    fi
    case $c in
    y) newlist="$newlist $file";; # @revisit: handle space in filenames
    a) newlist="$newlist $file"; confirm=; c='y';;
    q) exit 1;;
    \?) printf '\n%s' "$help" >/dev/tty;;
    *) ;;
    esac
done
if [ "$newlist" ]; then
    echo $newlist
fi
exit 0
