#
# Makefile --Build rules for "vim", customisations for the vim editor.
#
prefix = $(HOME)
vimdir = $(prefix)/.vim/colors
SRC = custom.vim

include makeshift.mk

install:	$(SRC:%=$(vimdir)/%)

$(vimdir)/%:	%;		$(INSTALL_FILE)	$? $@
