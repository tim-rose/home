#
# Makefile --Build rules for installing emacs customisations.
#
# Remarks:
# I'm avoiding using makeshift's emacs lisp support because I want
# this stuff to work (i.e. harmlessly install the files) even
# if emacs isn't itself installed.
#
prefix = $(HOME)
emacsdir = $(rootdir)/.emacs.d/site-lisp
ELISP_SRC = markdown-mode.el php-mode-improved.el

include makeshift.mk

install:	$(ELISP_SRC:%.el=$(emacsdir)/%.el)

$(emacsdir)/%.el:	%.el
	$(INSTALL_FILE)	$*.el $@

#
# src-elisp: --Update the ELISP_SRC macro with a list of ".el" files.
#
src:	src-elisp
.PHONY:	src-elisp
src-elisp:
	$(ECHO_TARGET)
	@mk-filelist -qn ELISP_SRC *.el
