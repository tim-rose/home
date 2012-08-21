#
# Makefile --Build rules for "a2ps", customisations for the a2ps utility..
#
TRG_DIR = $(DESTDIR)/$(HOME)/.vim/colors
SRC = custom.vim

include devkit.mk

installdirs:	$(TRG_DIR)
install:	$(SRC:%=$(TRG_DIR)/%)

$(TRG_DIR):	;		$(INSTALL_DIRECTORY) $@
$(TRG_DIR)/%:	%;		$(INSTALL_DATA)	$? $@


