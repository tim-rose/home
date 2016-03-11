#
# Makefile --Build rules for "rc", home-directory config files.
#
prefix = $(HOME)
RC_SRC = _envrc _funcrc

include devkit.mk

install:	$(RC_SRC:_%=$(rootdir)/etc/sh/%)

$(rootdir)/etc/sh/%:	_%;		$(INSTALL_FILE)	$? $@

src:    src-rc
.PHONY: src-rc
src-rc:	;	mk-filelist -qn RC_SRC _*[a-z]

toc:    toc-rc
.PHONY:	toc-rc
toc-rc:	;	mk-toc -qt .sh  $(RC_SRC)
