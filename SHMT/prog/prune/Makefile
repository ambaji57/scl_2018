SHELL = /bin/sh

TARGETS = default_gen.dbm default_morph.dbm

all: $(TARGETS)

apte_pratipadik.dbm default_gen.dbm: create_dbm.pl default_gen.txt
	rm -f apte_pratipadik.dbm default_gen.dbm
	perl create_dbm.pl default_gen.dbm apte_pratipadik.dbm < default_gen.txt

default_morph.dbm: create_dbm_mo.pl default_morph.txt
	rm -f default_morph.dbm
	perl create_dbm_mo.pl default_morph.dbm < default_morph.txt

.PHONY: all

clean:
	rm -f $(TARGETS)
