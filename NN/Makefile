SHELL = /bin/sh

SUBDIRS = CG parser Type_identifier segmenter

.PHONY: $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

install:
	mkdir -p HTDOCSDIR/NN/CG; mkdir -p CGIDIR/NN/CG; mkdir -p TFPATH/NN/CG; chown APACHE_USER_GROUP TFPATH/NN; chown APACHE_USER_GROUP TFPATH/NN/CG; cp CG/web_interface/*.html HTDOCSDIR/NN/CG; cp CG/web_interface/*.cgi CGIDIR/NN/CG; 
	mkdir -p CGIDIR/NN/parser; mkdir -p HTDOCSDIR/NN/parser; mkdir -p TFPATH/NN/parser; chown APACHE_USER_GROUP TFPATH/NN/parser; cp parser/web_interface/*.html HTDOCSDIR/NN/parser; cp parser/web_interface/*.cgi CGIDIR/NN/parser;
	mkdir -p CGIDIR/NN/segmenter; mkdir -p HTDOCSDIR/NN/segmenter; mkdir -p TFPATH/NN/segmenter;  chown APACHE_USER_GROUP TFPATH/NN/segmenter; cp segmenter/web_interface/*.html HTDOCSDIR/NN/segmenter; cp segmenter/web_interface/*.cgi CGIDIR/NN/segmenter;
	mkdir -p CGIDIR/NN/Type_identifier; mkdir -p HTDOCSDIR/NN/Type_identifier; mkdir -p TFPATH/NN/Type_identifier;  chown APACHE_USER_GROUP TFPATH/NN/Type_identifier; cp Type_identifier/web_interface/*.html HTDOCSDIR/NN/Type_identifier; cp Type_identifier/web_interface/*.cgi CGIDIR/NN/Type_identifier;
	cd HTDOCSDIR/NN/CG; ln -sf TFPATH/NN/CG DOT
	cd HTDOCSDIR/NN/parser; ln -sf TFPATH/NN/parser DOT
	cd HTDOCSDIR/NN/Type_identifier; ln -sf TFPATH/NN/Type_identifier DOT
	cp -r css_files HTDOCSDIR/NN
	cp -r js_files HTDOCSDIR/NN
