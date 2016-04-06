#
# Makefile --Build rules for "etc", miscellaneous data.
#
prefix = $(HOME)
MK_SRC = tasks.mk

include devkit.mk

install:	$(MK_SRC:%.mk=$(sysconfdir)/%.mk)

$(sysconfdir)/%.mk:	%.mk;		$(INSTALL_FILE)	$? $@
