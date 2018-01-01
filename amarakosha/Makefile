SHELL = /bin/sh

default:
	cd DBM; make

install:
	mkdir -p HTDOCSDIR/amarakosha; mkdir -p CGIDIR/amarakosha; cp web_interface/*.html HTDOCSDIR/amarakosha; cp -r web_interface/FAQ HTDOCSDIR/amarakosha/; cp -r web_interface/*.cgi CGIDIR/amarakosha; cp web_interface/amarakosha_knowledge_structure.pdf HTDOCSDIR/amarakosha; cp web_interface/logouoh.png HTDOCSDIR/amarakosha; cp web_interface/about.html HTDOCSDIR/amarakosha; 
	mkdir -p TFPATH/AMARA_DOT; chown APACHE_USER_GROUP TFPATH/AMARA_DOT; cd HTDOCSDIR/amarakosha; ln -sfn TFPATH/AMARA_DOT DOT

debian_install:
	mkdir -p /tmp/scl/HTDOCSDIR/amarakosha; mkdir -p /tmp//sclCGIDIR/amarakosha; cp web_interface/*.html /tmp/scl/HTDOCSDIR/amarakosha; cp -r web_interface/js /tmp/scl/HTDOCSDIR/amarakosha;  cp -r web_interface/FAQ /tmp/scl/HTDOCSDIR/amarakosha/; cp -r web_interface/*.cgi /tmp/scl/CGIDIR/amarakosha; cp web_interface/amarakosha_knowledge_structure.pdf /tmp/scl/HTDOCSDIR/amarakosha; cp web_interface/logouoh.png /tmp/scl/HTDOCSDIR/amarakosha; cp web_interface/about.html /tmp/scl/HTDOCSDIR/amarakosha; cp web_interface/*.js /tmp/scl/HTDOCSDIR/amarakosha;
	mkdir -p TFPATH/AMARA_DOT; chown APACHE_USER_GROUP TFPATH/AMARA_DOT; cd HTDOCSDIR/amarakosha; ln -sf TFPATH/AMARA_DOT DOT
