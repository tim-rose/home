#
# Makefile --Build rules for various configuraton RC files.
#
prefix = $(HOME)
sysconfdir = $(DESTDIR)/$(HOME)

language = sh

RC_SRC = _emacs _vimrc

include makeshift.mk

install: $(RC_SRC:_%=$(sysconfdir)/.%)
install: $(rootdir)/.bashrc-$(HOSTNAME)

$(rootdir)/.bashrc-$(HOSTNAME):
	printf "# custom settings for %s\n" "$(HOSTNAME)" >$@
