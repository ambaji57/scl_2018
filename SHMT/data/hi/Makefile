SHELL = /bin/sh

TARGETS = noun.dbm verb.dbm tam.dbm avy.dbm pronoun.dbm avy_avy.dbm fem_hnd_noun.dbm human.dbm animate.dbm inanimate.dbm excpt_ne.dbm noun_pronoun_pratipadika.dbm amUrwa.dbm kriyAmUla_marker.dbm

all: $(TARGETS)

noun.dbm: noun.txt
	rm -f noun.dbm
	./create_dbm_noun.pl noun.dbm < noun.txt
	chmod 644 noun.dbm

pronoun.dbm: pronoun.txt
	rm -f pronoun.dbm
	./create_dbm_pronoun.pl pronoun.dbm < pronoun.txt
	chmod 644 pronoun.dbm

noun_pronoun_pratipadika.dbm: noun.txt pronoun.txt
	rm -f noun_pronoun_pratipadika.dbm
	cat noun.txt pronoun.txt | cut -d, -f1,3 | sort -u |./create_dbm_pratipadikam.pl noun_pronoun_pratipadika.dbm
	chmod 644 noun_pronoun_pratipadika.dbm

verb.dbm: verb.txt
	rm -f verb.dbm
	./create_dbm_verb.pl verb.dbm < verb.txt
	chmod 644 verb.dbm

avy.dbm: avy.txt
	rm -f avy.dbm
	./create_dbm_avy.pl avy.dbm < avy.txt
	chmod 644 avy.dbm

avy_avy.dbm: avy_avy.txt
	rm -f avy_avy.dbm
	./create_dbm_avy_avy.pl avy_avy.dbm < avy_avy.txt
	chmod 644 avy_avy.dbm

tam.dbm: tam.txt
	rm -f tam.dbm
	./create_dbm_tam.pl tam.dbm < tam.txt
	chmod 644 tam.dbm

fem_hnd_noun.dbm: fem_hnd_noun.lst
	rm -f fem_hnd_noun.dbm
	./create_dbm.pl fem_hnd_noun.dbm < fem_hnd_noun.lst
	chmod 644 fem_hnd_noun.dbm

human.dbm: human.txt
	rm -f human.dbm
	./create_dbm.pl human.dbm < human.txt
	chmod 644 human.dbm

animate.dbm: animate.txt
	rm -f animate.dbm
	./create_dbm.pl animate.dbm < animate.txt
	chmod 644 animate.dbm

inanimate.dbm: inanimate.txt
	rm -f inanimate.dbm
	./create_dbm.pl inanimate.dbm < inanimate.txt
	chmod 644 inanimate.dbm

amUrwa.dbm: amUrwa.txt
	rm -f amUrwa.dbm
	./create_dbm.pl amUrwa.dbm < amUrwa.txt
	chmod 644 amUrwa.dbm

excpt_ne.dbm: ne_excptnl_verbs.txt
	rm -f excpt_ne.dbm
	./create_dbm.pl excpt_ne.dbm < ne_excptnl_verbs.txt
	chmod 644 excpt_ne.dbm

kriyAmUla_marker.dbm: kriyAmUla_marker.txt
	rm -f kriyAmUla_marker.dbm
	./create_dbm_kriyAmUla.pl kriyAmUla_marker.dbm < kriyAmUla_marker.txt
	chmod 644 kriyAmUla_marker.dbm

.PHONY: all

clean:
	rm -f $(TARGETS)

