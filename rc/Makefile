#
# Makefile --Build rules for "rc", home-directory config files.
#
override prefix = $(HOME)
RC_SRC = _bashrc _emacs _gitconfig _gitignore _profile _vimrc

include makeshift.mk

install: $(RC_SRC:_%=$(rootdir)/.%)
install: $(rootdir)/.bashrc-$(HOSTNAME)

$(rootdir)/.%:	_%;		$(INSTALL_DATA)	$? $@

$(rootdir)/.bashrc-$(HOSTNAME):
	printf "# custom settings for %s\n" "$(HOSTNAME)" >$@

src:    src-rc
.PHONY: src-rc
src-rc:	;	mk-filelist -qn RC_SRC _*[a-z]

toc:    toc-rc
.PHONY:	toc-rc
toc-rc:	;	mk-toc -qt .sh  $(RC_SRC)
