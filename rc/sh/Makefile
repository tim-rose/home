#
# Makefile --Build rules for "rc", home-directory config files.
#
prefix = $(HOME)
RC_SRC = _aliasrc _envrc _funcrc

include makeshift.mk

install:	$(RC_SRC:%=$(rootdir)/etc/sh/%)

$(rootdir)/etc/sh/%:	%;		$(INSTALL_FILE)	$? $@

src:    src-rc
.PHONY: src-rc
src-rc:	;	mk-filelist -qn RC_SRC _*[a-z]

toc:    toc-rc
.PHONY:	toc-rc
toc-rc:	;	mk-toc -qt .sh  $(RC_SRC)
