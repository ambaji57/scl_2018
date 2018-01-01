SHELL = /bin/bash

install:
	source ../spec.txt
	mkdir -p HTDOCSDIR/skt_gen/noun;mkdir -p CGIDIR/skt_gen/noun;cp noun/web_interface/*.html HTDOCSDIR/skt_gen/noun; cp noun/web_interface/*.cgi CGIDIR/skt_gen/noun; 
	mkdir -p HTDOCSDIR/skt_gen/verb; mkdir -p CGIDIR/skt_gen/verb; cp verb/web_interface/*.html HTDOCSDIR/skt_gen/verb; cp verb/web_interface/*.cgi CGIDIR/skt_gen/verb; 
	mkdir -p HTDOCSDIR/skt_gen/kqw; mkdir -p CGIDIR/skt_gen/kqw; cp kqw/web_interface/*.html HTDOCSDIR/skt_gen/kqw; cp kqw/web_interface/*.cgi CGIDIR/skt_gen/kqw; 
	mkdir -p HTDOCSDIR/skt_gen/waxXiwa; mkdir -p CGIDIR/skt_gen/waxXiwa; cp waxXiwa/web_interface/*.html HTDOCSDIR/skt_gen/waxXiwa; cp waxXiwa/web_interface/*.cgi CGIDIR/skt_gen/waxXiwa; 
	mkdir -p HTDOCSDIR/skt_gen/compounds/; mkdir -p CGIDIR/skt_gen/compounds; cp compounds/web_interface/*.html HTDOCSDIR/skt_gen/compounds; cp -r compounds/web_interface/js HTDOCSDIR/skt_gen/compounds; cp -r compounds/web_interface/css HTDOCSDIR/skt_gen/compounds; cp compounds/web_interface/*.cgi CGIDIR/skt_gen/compounds; cp compounds/web_interface/Samasa_Flowchart.jpg HTDOCSDIR/skt_gen/compounds/

debian_install:
	source ../spec_debian.txt
	mkdir -p /tmp/scl/HTDOCSDIR/skt_gen/noun;mkdir -p /tmp/scl/CGIDIR/skt_gen/noun;cp noun/web_interface/*.html /tmp/scl/HTDOCSDIR/skt_gen/noun; cp noun/web_interface/*.cgi /tmp/scl/CGIDIR/skt_gen/noun; cp noun/web_interface/*.js /tmp/scl/HTDOCSDIR/skt_gen/noun
	mkdir -p /tmp/scl/HTDOCSDIR/skt_gen/verb; mkdir -p /tmp/scl/CGIDIR/skt_gen/verb; cp verb/web_interface/*.html /tmp/scl/HTDOCSDIR/skt_gen/verb; cp verb/web_interface/*.cgi /tmp/scl/CGIDIR/skt_gen/verb; cp verb/web_interface/*.js /tmp/scl/HTDOCSDIR/skt_gen/verb
	mkdir -p /tmp/scl/HTDOCSDIR/skt_gen/kqw; mkdir -p /tmp/scl/CGIDIR/skt_gen/kqw; cp kqw/web_interface/*.html /tmp/scl/HTDOCSDIR/skt_gen/kqw; cp kqw/web_interface/*.cgi /tmp/scl/CGIDIR/skt_gen/kqw; cp kqw/web_interface/*.js /tmp/scl/HTDOCSDIR/skt_gen/kqw
	mkdir -p /tmp/scl/HTDOCSDIR/skt_gen/waxXiwa; mkdir -p /tmp/scl/CGIDIR/skt_gen/waxXiwa; cp waxXiwa/web_interface/*.html /tmp/scl/HTDOCSDIR/skt_gen/waxXiwa; cp waxXiwa/web_interface/*.cgi /tmp/scl/CGIDIR/skt_gen/waxXiwa; cp waxXiwa/web_interface/*.js /tmp/scl/HTDOCSDIR/skt_gen/waxXiwa
	cp htdocs/generators*.html /tmp/scl/HTDOCSDIR/skt_gen/
	cp htdocs/*.css /tmp/scl/HTDOCSDIR/skt_gen/
	cp htdocs/*.js /tmp/scl/HTDOCSDIR/skt_gen/
	cp htdocs/gen.html /tmp/scl/HTDOCSDIR/skt_gen/
	cp htdocs/table.html /tmp/scl/HTDOCSDIR/skt_gen/
