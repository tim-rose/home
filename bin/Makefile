#
# Makefile --Build rules for "bin", personal commands etc.
#
# Remarks:
# "prefix" is set to (environment variable) HOME, so that the default
# rules can be applied to install the scripts.
#
prefix = $(HOME)
language = sh
SH_LINT_EXCLUDE += SC1091 SC2059

SH_SRC = auto-ssh.sh choose.sh cmpmv.sh colortest.sh db.sh dbls.sh \
    lesspipe.sh mergedir.sh svn-viewdiff.sh trash.sh vcs.sh \
    whichis.sh
SED_SRC = csv-to-html.sed

include makeshift.mk

install:	install-all
uninstall:	uninstall-all
