#
# MAKEFILE --sample makefile for using devkit
#
# Contents:
# put:         --Push some data to a remote host using rsync.
# get:         --Pull some data from a remote host using rsync.
# home-dir-ok: --Check that the current directory is [a sub-directory of] home.
#
include devkit.mk

get: var-defined[SYNC_HOST] get[$$SYNC_HOST]
put: var-defined[SYNC_HOST] put[$$SYNC_HOST]

#
# put: --Push some data to a remote host using rsync.
#
put[%]:	home-dir-ok
	@dir=$$(echo $$PWD | sed -e "s|^$$HOME/||"); \
	echo "put: $$PWD -> $*:$$dir..."; \
	ssh $* mkdir -p $$dir && \
	    rsync -Cauvz . $*:$$dir 2>&1 | sed -ne '/\/$$/d' -e '/\//p'


#
# get: --Pull some data from a remote host using rsync.
#
get[%]:	home-dir-ok
	@dir=$$(echo $$PWD | sed -e "s|^$$HOME/||"); \
	echo "get: $*:$$dir -> $$PWD"; \
	rsync -Cauvz $*:$$dir/ .

#
# home-dir-ok: --Check that the current directory is [a sub-directory of] home.
#
home-dir-ok:
	@echo $$PWD | grep "^$$HOME" >/dev/null || { echo 'Not in home directory!'; false; }
