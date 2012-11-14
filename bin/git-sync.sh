#!/bin/bash
#
# GIT-SYNC --Git update via git pull --rebase
#
set -e			       # fail immediately if there's a problem
PATH=$PATH:/usr/libexec:/usr/local/libexec
. core.shl
require getopt.shl log.shl

stash=
tmpfile=$(mktemp -t vcs-XXXXXX)
trap 'rm -f "$tmpfile"' EXIT

#
# usage() --echo this script's usage message.
#
usage()
{
    cat <<EOF
git-sync: Apply upstream changes from a remote repository
EOF
    getopt_usage "git-sync [options]" "$1"
}

opts="$LOG_GETOPTS"
eval $(getopt_long_args -d "$opts" "$@" || usage "$opts" >&2)
log_getopts

#
# main...
#
notice 'fetching upstream changes'
log_cmd git fetch

branch=$(git describe --contains --all HEAD)
if [ ! "$(git config branch.$branch.remote)" \
    -o ! "$(git config branch.$branch.merge)" ]; then
    log_quit '"%s" is not a tracking branch' $branch
fi

#
# if we're behind upstream, we need to update
# 
if git status | grep "# Your branch" > "$tmpfile"; then

    notice 'updating upstream changes'
    # extract tracking branch from status message
    upstream=$(cat "$tmpfile" | cut -d "'" -f 2)
    if [ ! "$upstream" ]; then
        log_quit 'Could not detect upstream branch'
    fi
    
    log_cmd git stash > "$tmpfile" || exit 1
    
    if ! grep -q "No local changes" "$tmpfile"; then
	info 'stashed local changes'
	stash=1				# remember we stashed something
    fi

    #
    # rebase our changes on top of upstream, but keep any merges
    # 
    log_cmd git rebase -p "$upstream"
    
    if [ "$stash" ]; then
	info 'restoring local changes'
	log_cmd git stash pop -q		# restore what we stashed earlier
    fi
fi
