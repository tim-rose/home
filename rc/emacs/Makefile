#
# Makefile --Build rules for "a2ps", customisations for the a2ps utility..
#
SRC_LANG = elisp
ELISP_SRC = markdown-mode.el php-mode-improved.el
HOME_ELISP_DIR = $(DESTDIR)/$(HOME)/.emacs.d/site-lisp

$(HOME_ELISP_DIR)/%.el:	%.el
	$(INSTALL_FILE)	$*.el $@

include devkit.mk

install:	$(ELISP_SRC:%.el=$(HOME_ELISP_DIR)/%.el)

