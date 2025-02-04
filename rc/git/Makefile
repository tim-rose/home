#
# Makefile --Build rules for "rc", home-directory config files.
#
prefix = $(HOME)
sysconfdir = $(DESTDIR)/$(DESTDIR)/$(HOME)

language = sh

RC_SRC = _gitattributes _gitconfig _gitignore _gitmessage

include makeshift.mk

install:	$(RC_SRC:_%=$(sysconfdir)/.%)
