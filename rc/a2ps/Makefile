#
# Makefile --Build rules for "a2ps", customisations for the a2ps utility..
#
prefix = $(HOME)
SRC = a2psrc

include devkit.mk

install:	$(SRC:%=$(rootdir)/.a2ps/%)

$(rootdir)/.a2ps/%:	%;		$(INSTALL_FILE)	$? $@
