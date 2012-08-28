#
# Makefile --Build rules for "a2ps", customisations for the a2ps utility..
#
LISP_SRC = php-mode-improved.el
TRG_DIR = $(DESTDIR)/$(HOME)/.emacs.d/site-lisp
SRC_LANG = lisp

include devkit.mk

installdirs:	$(TRG_DIR)
install:	$(LISP_SRC:%=$(TRG_DIR)/%)

$(TRG_DIR):	;		$(INSTALL_DIRECTORY) $@
$(TRG_DIR)/%:	%;		$(INSTALL_FILE)	$? $@


