SHELL = /bin/bash

install:
	source ../spec.txt
	cp -r *.html HTDOCSDIR; cp -p *.js HTDOCSDIR; cp -pr ../css_files HTDOCSDIR; cp -pr ../js_files HTDOCSDIR; cp -pr ../imgs HTDOCSDIR; cp *.cgi CGIDIR

debian_install:
	source ../spec_debian.txt
	mkdir -p /tmp/sclHTDOCSDIR
	cp -r *.html /tmp/sclHTDOCSDIR; cp -pr images /tmp/sclHTDOCSDIR; cp -p *.js /tmp/sclHTDOCSDIR; cp *.cgi /tmp/sclCGIDIR
