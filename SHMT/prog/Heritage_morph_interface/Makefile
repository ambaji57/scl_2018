SHELL = /bin/sh
LIBPATH = LPATH

all: Heritage_anusaaraka_morph.out Heritage_anusaaraka.gdbm

Heritage_anusaaraka_morph.out: Heritage_anusaaraka_morph.lex
	lex Heritage_anusaaraka_morph.lex
	gcc -g -L$(LIBPATH) -Wall -Wextra -o Heritage_anusaaraka_morph.out lex.yy.c -ll
	rm lex.yy.c

Heritage_anusaaraka.gdbm: mapping_Heritage_saMsAdhanii_WX.txt
	rm -f Heritage_anusaaraka.gdbm
	cut -f1,2,4,5,6 mapping_Heritage_saMsAdhanii_WX.txt | sort -u | ./create_dbm.pl Heritage_anusaaraka.gdbm 
	chmod 755 Heritage_anusaaraka.gdbm
