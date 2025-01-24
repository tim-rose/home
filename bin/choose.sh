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
    while true; do
        if [ "$confirm" ]; then
            printf '%s? [ynaq]: ' "$file" >/dev/tty
            read -n1 c		# bashism
            printf '\n'
        fi
        case $c in
        y) newlist="$newlist $file"; break;;
        n) break;;
        a) newlist="$newlist $file"; confirm=; c='y'; break;;
        q) exit 1;;
        *) printf '%s\n' "$help" >/dev/tty;;
        esac
    done
done
if [ "$newlist" ]; then
    echo $newlist
fi
exit 0
