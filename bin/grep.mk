#
# GREP.MK --Rules for dynamically building/installing an alternate grep # command.
#
install:	install-grep install-all
uninstall:	uninstall-grep uninstall-all

install-grep: $(bindir)/grep
uninstall-grep:; $(RM) $(bindir)/grep

#
# grep: --Create an alternate grep command that enables color.
#
$(bindir)/grep:
	echo '#!/bin/sh' >$@
	which -a grep | grep -v $$HOME | head -1 | sed -e 's/$$/ --color=auto "$$@"/' >> $@
	chmod +x $@

