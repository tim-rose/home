#
# Makefile --Build rules for "bin", personal commands etc.
#
# Remarks:
# "prefix" is set to (environment variable) HOME, so that the default
# rules can be applied to install the scripts.
#
prefix = $(HOME)
language	= sh

SH_SRC = auto-ssh.sh choose.sh cmpmv.sh colortest.sh db.sh \
    dbls.sh grep.sh lesspipe.sh mergedir.sh rpmpan.sh \
    set-font-smoothing.sh svn-viewdiff.sh trash.sh whichis.sh
SED_SRC = csv-to-html.sed

include devkit.mk

install:	install-shell

uninstall:	uninstall-this
uninstall-this:
	$(RM) $(SH_SRC:%.sh=$(bindir)/%) $(SED_SRC:%.sed=$(bindir)/%)
