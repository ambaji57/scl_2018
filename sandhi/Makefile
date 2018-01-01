SHELL = /bin/bash

install:
	source ../spec.txt
	mkdir -p HTDOCSDIR/sandhi;mkdir -p CGIDIR/sandhi;cp web_interface/*.html HTDOCSDIR/sandhi; cp web_interface/*.cgi CGIDIR/sandhi; cp web_interface/*.js HTDOCSDIR/sandhi; cp web_interface/info.html HTDOCSDIR/sandhi
debian_install:
	source ../spec_debian.txt
	mkdir -p /tmp/sclHTDOCSDIR/sandhi;mkdir -p /tmp/sclCGIDIR/sandhi;cp web_interface/*.html /tmp/sclHTDOCSDIR/sandhi; cp web_interface/*.cgi /tmp/sclCGIDIR/sandhi; cp -p web_interface/*.js /tmp/sclCGIDIR/sandhi
