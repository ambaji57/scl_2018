SHELL = /bin/sh

.PHONY: all clean

TARGETS = afga_viXi_rule.class change_aRt.class change_output1.class change_output.class check.class console_output.class get_input.class get_SabdarUpa_new.class input_DS.class paxa_DS.class prawyaya_viXi_rule.class regex_check.class rule.class Sandhi_rule.class wripAxI_rule.class

SRC = afga_viXi_rule.java change_aRt.java change_output1.java change_output.java check.java console_output.java get_input.java get_SabdarUpa_new.java input_DS.java paxa_DS.java prawyaya_viXi_rule.java regex_check.java rule.java Sandhi_rule.java wripAxI_rule.java 

JAVA = JAVAPATH

all: $(TARGETS)

afga_viXi_rule.class: afga_viXi_rule.java
	$(JAVA) afga_viXi_rule.java

change_aRt.class: change_aRt.java
	$(JAVA) change_aRt.java

change_output1.class: change_output1.java
	$(JAVA) change_output1.java

change_output.class: change_output.java
	$(JAVA) change_output.java

check.class: check.java
	$(JAVA) check.java

console_output.class: console_output.java
	$(JAVA) console_output.java

get_input.class: get_input.java
	$(JAVA) get_input.java

get_SabdarUpa_new.class: get_SabdarUpa_new.java
	$(JAVA) get_SabdarUpa_new.java

input_DS.class: input_DS.java
	$(JAVA) input_DS.java

paxa_DS.class: paxa_DS.java
	$(JAVA) paxa_DS.java

prawyaya_viXi_rule.class: prawyaya_viXi_rule.java
	$(JAVA) prawyaya_viXi_rule.java

regex_check.class: regex_check.java
	$(JAVA) regex_check.java

rule.class: rule.java
	$(JAVA) rule.java

Sandhi_rule.class: Sandhi_rule.java
	$(JAVA) Sandhi_rule.java

wripAxI_rule.class: wripAxI_rule.java
	$(JAVA) wripAxI_rule.java

clean: 
	rm -f $(TARGETS)

install:
	mkdir -p HTDOCSDIR/ashtadhyayi_simulator
	mkdir -p CGIDIR/ashtadhyayi_simulator
	cp ../web_interface/*.html HTDOCSDIR/ashtadhyayi_simulator
	cp ../web_interface/*.cgi CGIDIR/ashtadhyayi_simulator

debian_install:
	mkdir -p /tmp/scl/HTDOCSDIR/ashtadhyayi_simulator
	mkdir -p /tmp/scl/CGIDIR/ashtadhyayi_simulator
	cp ../web_interface/*.html /tmp/scl/HTDOCSDIR/ashtadhyayi_simulator
	cp ../web_interface/*.cgi /tmp/scl/CGIDIR/ashtadhyayi_simulator

web_install:
	mkdir -p var/www/htdocs/scl/ashtadhyayi_simulator
	mkdir -p usr/lib/cgi-bin/scl/ashtadhyayi_simulator
	cp ../web_interface/*.html var/www/htdocs/scl/ashtadhyayi_simulator
	cp ../web_interface/*.cgi usr/lib/cgi-bin/scl/ashtadhyayi_simulator
