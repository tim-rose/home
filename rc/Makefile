#
# Makefile --Build rules for "rc", home-directory config files.
#
prefix = $(HOME)
RC_SRC = _bashrc _emacs _envrc _funcrc _gitconfig _gitignore \
    _profile _vimrc

include devkit.mk

install:	$(RC_SRC:_%=$(rootdir)/.%)

$(rootdir)/.%:	_%;		$(INSTALL_FILE)	$? $@

src:    src-rc
.PHONY: src-rc
src-rc:	;	mk-filelist -qn RC_SRC _*[a-z]

toc:    toc-rc
.PHONY:	toc-rc
toc-rc:	;	mk-toc -qt .sh  $(RC_SRC)
