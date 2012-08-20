#
# Makefile --Build rules for "dot-rc", home-directory config files.
#
LANG	= sh
DOT_SRC = dot-bashrc dot-emacs dot-envrc dot-funcrc dot-gitconfig \
    dot-profile dot-vimrc

default: install

include devkit.mk

install:	$(DOT_SRC:dot-%=$(DESTDIR)/$(HOME)/.%)

$(DESTDIR)/$(HOME)/.%:	dot-%;		$(INSTALL_DATA)	$? $@

src:	dot-rc-src
.PHONY:	dot-rc-src
dot-rc-src:	
	@$(ECHO) "++ make[$@]@$$PWD"
	@mk-filelist -qn DOT_SRC dot-*[a-z]

