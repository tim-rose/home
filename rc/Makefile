#
# Makefile --Build rules for "rc", home-directory config files.
#
RC_SRC = _bashrc _emacs _envrc _funcrc _gitignore _profile _vimrc

default: install

include devkit.mk

install:	$(RC_SRC:_%=$(DESTDIR)/$(HOME)/.%)

$(DESTDIR)/$(HOME)/.%:	_%;		$(INSTALL_DATA)	$? $@

.PHONY:	rc-src
src:	rc-src
rc-src:	
	@$(ECHO) "++ make[$@]@$$PWD"
	@mk-filelist -qn RC_SRC _*[a-z]

.PHONY:	rc-toc
toc:	rc-toc
rc-toc:
	@$(ECHO) "++ make[$@]@$$PWD"
	@mk-toc -qt .sh  $(RC_SRC)

