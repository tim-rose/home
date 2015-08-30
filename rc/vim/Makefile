#
# Makefile --Build rules for "a2ps", customisations for the a2ps utility..
#
prefix = $(HOME)
vimdir = $(prefix)/.vim/colors
SRC = custom.vim

include devkit.mk

install:	$(SRC:%=$(vimdir)/%)

$(vimdir)/%:	%;		$(INSTALL_FILE)	$? $@
