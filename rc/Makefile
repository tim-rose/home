#
# Makefile --Build rules for "dot-rc", home-directory config files.
#
LANG	= sh
RC_SRC = _bashrc _emacs _envrc _funcrc _gitconfig _profile _vimrc

default: install

include devkit.mk

install:	$(RC_SRC:_%=$(DESTDIR)/$(HOME)/.%)

$(DESTDIR)/$(HOME)/.%:	_%;		$(INSTALL_DATA)	$? $@

.PHONY:	rc-src
src:	rc-src
rc-src:	
	@$(ECHO) "++ make[$@]@$$PWD"
	@mk-filelist -qn RC_SRC _*[a-z]

