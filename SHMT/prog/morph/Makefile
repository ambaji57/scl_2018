SHELL = /bin/sh

TARGETS = rUDa_kqw.gdbm

all: $(TARGETS)

rUDa_kqw.gdbm: create_dbm.pl rUDa_kqw.txt
	rm -f rUDa_kqw.gdbm
	perl create_dbm.pl rUDa_kqw.gdbm < rUDa_kqw.txt

install:
	mkdir -p HTDOCSDIR/morph;mkdir -p CGIDIR/morph; cp web_interface/*.html HTDOCSDIR/morph; cp web_interface/*.cgi CGIDIR/morph; cp web_interface/*.css HTDOCSDIR/morph; cp -pr web_interface/images HTDOCSDIR/morph/; cp web_interface/*.js HTDOCSDIR/morph;
	mkdir -p /tmp/DEMO; chown APACHE_USER_GROUP /tmp/DEMO;ln -sfn /tmp/DEMO DEMO
	mkdir -p /tmp/DEMO/dot;

debian_install:
	mkdir -p /tmp/scl/HTDOCSDIR/morph;mkdir -p /tmp/sclCGIDIR/morph; cp web_interface/*.html /tmp/scl/HTDOCSDIR/morph; cp web_interface/*.cgi /tmp/sclCGIDIR/morph; cp web_interface/*.css /tmp/scl/HTDOCSDIR/morph; cp -pr web_interface/images /tmp/scl/HTDOCSDIR/morph/;
	mkdir -p /tmp/DEMO; chown APACHE_USER_GROUP /tmp/DEMO;ln -sfn /tmp/DEMO DEMO
	mkdir -p /tmp/DEMO/dot;

.PHONY: all

clean:
	rm -f $(TARGETS)
