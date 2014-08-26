#
# Makefile --Build rules for "rc", home-directory config files.
#
RC_SRC = _bashrc _emacs _envrc _funcrc _gitignore _profile _vimrc

default: install

include devkit.mk

install:	$(RC_SRC:_%=$(DESTDIR)/$(HOME)/.%)

$(DESTDIR)/$(HOME)/.%:	_%;		$(INSTALL_FILE)	$? $@

src:    rc-src
.PHONY: rc-src
rc-src:	;	mk-filelist -qn RC_SRC _*[a-z]

toc:    rc-toc
.PHONY:	rc-toc
rc-toc:	;	mk-toc -qt .sh  $(RC_SRC)
