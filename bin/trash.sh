#!/bin/sh
#
# TRASH --move stuff to the special "trash" folder
#
test -d $HOME/.Trash || mkdir $HOME/.Trash
mv $* $HOME/.Trash || exit 1
printf "were you sure? "
read $line
exit 0
