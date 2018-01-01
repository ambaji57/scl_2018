SHELL = /bin/sh

TARGETS = mo_ana.dbm kqw_mo_ana.dbm

all: $(TARGETS)

mo_ana.dbm: create_dbm.pl mo_ana.txt
	rm -f mo_ana.dbm
	perl create_dbm.pl mo_ana.dbm < mo_ana.txt

kqw_mo_ana.dbm: create_dbm.pl kqw_mo_ana.txt
	rm -f kqw_mo_ana.dbm
	perl create_dbm.pl kqw_mo_ana.dbm < kqw_mo_ana.txt

.PHONY: all

clean:
	rm -f $(TARGETS)
