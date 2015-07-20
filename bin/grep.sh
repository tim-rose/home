#!/bin/sh
#grep=$(not_this_grep)
grep=/opt/local/bin/grep
exec $grep --color=auto "$@"
