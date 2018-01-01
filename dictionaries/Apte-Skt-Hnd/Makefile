SHELL = /bin/bash

install:
	source ../../my_spec.txt
	mkdir -p HTDOCSDIR/dictionaries/Apte-Skt-Hnd; mkdir -p CGIDIR/dictionaries/Apte-Skt-Hnd; cp index.html dic.css HTDOCSDIR/dictionaries/Apte-Skt-Hnd; cp -r xmlfiles HTDOCSDIR/dictionaries/Apte-Skt-Hnd; cp xml_read.cgi CGIDIR/dictionaries/Apte-Skt-Hnd

debian_install:
	source ../../my_spec_debian.txt
	mkdir -p /tmp/scl/HTDOCSDIR/dictionaries/Apte-Skt-Hnd; mkdir -p /tmp/scl/CGIDIR/dictionaries/Apte-Skt-Hnd; cp index.html dic.css /tmp/scl/HTDOCSDIR/dictionaries/Apte-Skt-Hnd; cp -r xmlfiles /tmp/scl/HTDOCSDIR/dictionaries/Apte-Skt-Hnd; cp xml_read.cgi /tmp/scl/CGIDIR/dictionaries/Apte-Skt-Hnd
