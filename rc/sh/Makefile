#
# Makefile --Build rules for "sh", home-directory shell config files.
#
prefix ?= $(HOME)
sysconfdir ?= $(HOME)

language = sh

RC_SRC = _aliasrc _bashrc _envrc _funcrc _profile

include makeshift.mk

install:	$(RC_SRC:_%=$(sysconfdir)/.%)
