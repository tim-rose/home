#!/bin/sh
#
# GIT-HIST --Customised version of git log that shows a colourful graph.
#
PATH=$PATH:/usr/libexec:/usr/local/libexec
. getopt.shl
. log.shl

#
# usage() --echo this script's usage message.
#
usage()
{
    cat <<EOF
git-hist: show the recent history of changes in this repository
EOF
    getopt_usage "git-hist [options] <git-log arguments>" "$1"
}

opts="r.relative_date;$LOG_GETOPTS"
eval $(getopt_long_args -d "$opts" "$@" || usage "$opts" >&2)
log_getopts

if [ "$relative_date" ]; then
    date_fmt='%ar'
else
    date_fmt='%aD'
fi

log_format="%C(bold)%h%C(cyan)%d%Creset $date_fmt %Cgreen%an%Creset %s"
git log --graph --pretty="format:$log_format" "$@"
