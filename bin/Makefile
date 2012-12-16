#
# Makefile --Build rules for "bin", personal commands etc.
#
# Remarks:
# "prefix" is set to (environment variable) HOME, so that the default
# rules can be applied to install the scripts.  Unfortunately that
# conflicts with libdir, which is also prefix-relative.  The upshot is
# that this configuration complains about a non-existent library
# directory (~/lib), and would need some special handling to find
# prefix-installed libraries.  Maybe I should build the C stuff in a
# subdir?
#
prefix = $(HOME)
SRC_LANG	= sh nroff c
CFLAGS	= -O0 -DBENCH_DOUBLE
LDLIBS	= -lm

SH_SRC = auto-ssh.sh choose.sh cmpmv.sh colortest.sh db.sh dbls.sh \
    lesspipe.sh mergedir.sh rpmpan.sh set-font-smoothing.sh \
    svn-viewdiff.sh trash.sh whichis.sh
SED_SRC = csv-to-html.sed
C_MAIN_SRC = benchmark.c
C_SRC = benchmark.c

include devkit.mk

installdirs:	$(man1dir) $(bindir) 
install:	$(MAN1_SRC:%.1=$(man1dir)/%.1)
install:	$(SH_SRC:%.sh=$(bindir)/%)
install:	$(SHL_SRC:%=$(libexecdir)/%)
install:	$(SED_SRC:%.sed=$(bindir)/%)
install:	$(C_MAIN_SRC:%.c=$(bindir)/%)
