#
# Makefile --Build rules for "a2ps", customisations for the a2ps utility..
#
prefix = $(HOME)
sysconfdir = $(DESTDIR)/$(HOME)/.a2ps

SRC = a2psrc bw.pro

include makeshift.mk

build: bw.pro
install:	$(SRC:%=$(sysconfdir)/%)

bw.pro: /usr/share/a2ps/ps/bw.pro
	sed -e 's/Times-Roman/Helvetica/' <$? >$@
