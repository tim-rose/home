#
# Makefile --Build rules for "bin", personal commands etc.
#
# Remarks:
# "prefix" is set to (environment variable) HOME, so that the default
# rules can be applied to install the scripts.
#
prefix = $(HOME)
language = sh c
#C_MAIN_SRC = benchmark.c
C_SRC = benchmark.c
SH_LINT_EXCLUDE += SC1091 SC2059

SH_SRC = auto-ssh.sh choose.sh cmpmv.sh colortest.sh db.sh dbls.sh \
    lesspipe.sh mergedir.sh svn-viewdiff.sh trash.sh vcs.sh
SED_SRC = csv-to-html.sed

include makeshift.mk

install:	install-all install-local
uninstall:	uninstall-all uninstall-local

install-local: $(bindir)/grep
uninstall-local:; $(RM) $(bindir)/grep

#
# grep: --Create an alternate grep command that enables color.
#
$(bindir)/grep:
	echo '#!/bin/sh' >$@
	which -a grep | grep -v $$HOME | head -1 | sed -e 's/$$/ --color=auto "$$@"/' >> $@
	chmod +x $@
