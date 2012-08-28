#
# Makefile --Build rules for "a2ps", customisations for the a2ps utility..
#
SRC = a2psrc
TRG_DIR = $(DESTDIR)/$(HOME)/.a2ps
default: install

include devkit.mk

installdirs:	$(TRG_DIR)
install:	$(SRC:%=$(TRG_DIR)/%)

$(TRG_DIR):	;		$(INSTALL_DIRECTORY) $? $@
$(TRG_DIR)/%:	%;		$(INSTALL_FILE)	$? $@


