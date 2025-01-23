#!/bin/sh 
#
# CGREP --Force grep's --color option to auto.
#
# Remarks:
# It's likely you already have an alias to do that, but the alias
# won't be used in all cases. (e.g. find ... | grep ...).
#
exec grep --color=auto "$@"
