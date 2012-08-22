#
# Makefile --Build rules for "bin", personal commands etc.
#
LANG	= sh nroff c
prefix = $(HOME)
SH_SRC = auto-ssh.sh choose.sh cmpmv.sh colortest.sh db.sh dbls.sh \
    git-hist.sh git-sync.sh lesspipe.sh mergedir.sh rpmpan.sh \
    svn-viewdiff.sh trash.sh whichis.sh
C_MAIN_SRC = benchmark.c
C_SRC = benchmark.c
CFLAGS = -O0   # disable optimisations for benchmark 

include devkit.mk

installdirs:	$(man1dir) $(bindir) 
install:	$(MAN1_SRC:%.1=$(man1dir)/%.1)
install:	$(SH_SRC:%.sh=$(bindir)/%)
install:	$(SHL_SRC:%=$(libexecdir)/%)
install:	$(C_MAIN_SRC:%.c=$(bindir)/%)
