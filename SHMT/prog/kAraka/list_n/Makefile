SHELL = /bin/sh

TARGETS = ../gdbm_n/kAraka_name.gdbm
 
all: $(TARGETS)

../gdbm_n/kAraka_name.gdbm: kAraka_names.txt
	rm -f ../gdbm_n/kAraka_name.gdbm ../gdbm_n/kAraka_num.gdbm
	./create_kAraka_name_dbm.pl ../gdbm_n/kAraka_name.gdbm  ../gdbm_n/kAraka_num.gdbm < kAraka_names.txt
	../../../../converters/ri_skt < kAraka_names.txt | ../../../../converters/iscii2utf8.py 1 > kAraka_names_dev.txt
	../../../../converters/wx2utf8roman.out < kAraka_names.txt > kAraka_names_roman.txt
	./create_kAraka_name_dev.pl ../gdbm_n/kAraka_name_dev.gdbm < kAraka_names_dev.txt
	./create_kAraka_name_dev.pl ../gdbm_n/kAraka_name_roman.gdbm < kAraka_names_roman.txt
	chmod 644 ../gdbm_n/kAraka_name.gdbm ../gdbm_n/kAraka_num.gdbm  ../gdbm_n/kAraka_name_dev.gdbm ../gdbm_n/kAraka_name_roman.gdbm

.PHONY: all

clean:
	rm -f $(TARGETS)
