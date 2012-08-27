#
# Makefile --Build rules for "rc", home-directory config files.
#
LANG	= sh
SH_SRC = _bashrc _emacs _envrc _funcrc _gitignore _profile _vimrc

default: install

include devkit.mk

install:	$(SH_SRC:_%=$(DESTDIR)/$(HOME)/.%)

$(DESTDIR)/$(HOME)/.%:	_%;		$(INSTALL_DATA)	$? $@

.PHONY:	rc-src
src:	rc-src
rc-src:	
	@$(ECHO) "++ make[$@]@$$PWD"
	@mk-filelist -qn SH_SRC _*[a-z]

