SHELL = /bin/sh

TARGETS = asm-yuRm.gdbm Sru-xqS.gdbm

all: $(TARGETS)

asm-yuRm.gdbm: createdbm.pl asm-yuRm.txt
	rm -rf asm-yuRm.gdbm
	perl createdbm.pl asm-yuRm.gdbm < asm-yuRm.txt

Sru-xqS.gdbm: createdbm.pl Sru-xqS.txt
	rm -rf Sru-xqS.gdbm
	perl createdbm.pl Sru-xqS.gdbm < Sru-xqS.txt
