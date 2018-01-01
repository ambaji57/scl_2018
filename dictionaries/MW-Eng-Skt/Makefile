SHELL = /bin/bash

install:
	source ../../my_spec.txt
	mkdir -p HTDOCSDIR/dictionaries/MW-Eng-Skt; mkdir -p CGIDIR/dictionaries/MW-Eng-Skt; cp index.html dic.css HTDOCSDIR/dictionaries/MW-Eng-Skt; cp -r xmlfiles HTDOCSDIR/dictionaries/MW-Eng-Skt; cp xml_read.cgi CGIDIR/dictionaries/MW-Eng-Skt

debian_install:
	source ../../my_spec_debian.txt
	mkdir -p /tmp/scl/HTDOCSDIR/dictionaries/MW-Eng-Skt; mkdir -p /tmp/scl/CGIDIR/dictionaries/MW-Eng-Skt; cp index.html dic.css /tmp/scl/HTDOCSDIR/dictionaries/MW-Eng-Skt; cp -r xmlfiles /tmp/scl/HTDOCSDIR/dictionaries/MW-Eng-Skt; cp xml_read.cgi /tmp/scl/CGIDIR/dictionaries/MW-Eng-Skt
