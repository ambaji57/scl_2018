;  Copyright (C) 2010-2016 Amba Kulkarni (ambapradeep@gmail.com)
;
;  This program is free software; you can redistribute it and/or
;  modify it under the terms of the GNU General Public License
;  as published by the Free Software Foundation; either
;  version 2 of the License, or (at your option) any later
;  version.
;
;  This program is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  along with this program; if not, write to the Free Software
;  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

(reset)
(facts)

;case1:viBakwi optionally found in Sanskrit but absent in Hindi.
;xivaH karma ca-1.4.43

;Get the number of xiv entries
(deffunction count-xiv (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "xiv_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;case2:Sanskrit has certain exceptional rules but Hindi does not need them.
;2.1:aXiSIfsWAsAM karma-1.4.46.

;Get the number of SIfAxi1 entries
(deffunction count-SIfAxi1 (?template)
(length (find-all-facts ((?fct ?template))
(or (eq (fact-slot-value ?fct rt) aXi_SI1) (eq (fact-slot-value ?fct rt) aXi_As1)))))

;Get the number of SIfAxi2 entries
(deffunction count-SIfAxi2 (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct rt) aXi_sWA1))))

;Created SIfAxi lists in list_n and its gdbm form.Gave examples in input file without the prefix 'aXi'.In deffunction as the verbal roots SI1 and As1 have the same viBakwiH 'para', it is written as (or (eq (fact-slot-value ?fct rt) aXi-SI1) (eq (fact-slot-value ?fct rt) aXi-As1)), same way in defrule RHS is written as (or (eq ?w:rt aXi-SI1) (eq ?w:rt aXi-As1)). Made modifications in the clips_wsd_files and executed the program. It was working.

;2.2:aBiniviSaSca-1.4.40

;Get the number of viS entries
(deffunction count-viS (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct rt) aBi_ni_viS1))))

;Since the verbal root viS1 is not in dictionary,morph analysis gives 'viSaw_meM' and hence the work has been pending.

;2.3:upAnvaXyAfvasaH-1.4.48.

;Get the number of vas entries
(deffunction count-vas (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct rt) upa_vas1))))

;verbal root 'vas' is working fine when checked adopting the same procedure as 'aXi-SI1'.

;2.4:xivaswaxarWasya-2.3.58.

;Get the number of xiv entries
(deffunction count_xiv (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "xiv_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;case3:Sanskrit and Hindi use different nominal cases.
;3.1:kruXaxruherRyAsUyArWAnAM yaM prawi kopaH-1.4.37.

;Get the number of kruXAxi1 entries
(deffunction count-kruXAxi1 (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "kruXAxi1_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;Get the number of kruXAxi2 entries
(deffunction count-kruXAxi2 (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "kruXAxi2_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;Get the number of kruXAxi3 entries
(deffunction count-kruXAxi3 (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "kruXAxi3_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;Took up those sentences where due to the kruXAxi verbal-roots the cawurWyAnwa in Sanskrit changes in Hindi (par,se,meM).Wrote example sentences in HTML-format and created kruXAxi(1,2,3)lists containing the verbal-roots in kAraka/list_n,and the viBakwi changes (par,se,meM) in dict/tam.txt by giving 'make' command.After preparing the lists they have to be entered in list_n/Makefile where they are converted to gdbm by giving 'make' command after saving.Then in prog/wsd> wsd.clp the deffunctions and defrules are given.The sup entries with cawurWI is retained as it is in upapaxa.Three defrules are created with the three kruXAxi_lists.The verbal-root 'asUya' is not working since it is a nAma-XAwu (work-in-progress).

;3.2:kruXaxruhorupsqRtayoH karma-1.4.38.

;Get the number of upapaxa_kruXAxi1 entries
(deffunction count-upa-kruXAxi1 (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct rt) aBi_kruX1))))

;Get the number of upapaxa_kruXAxi2 entries
(deffunction count-upa-kruXAxi2 (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct rt) aBi_xruh1))))

;Wrote the number of kruXAxi entries with (eq (fact-slot-value ?fct rt) aBi-kruX1).Also created defrule RHS as (eq ?w:rt aBi-kruX1)i.e., without the inverted commas.Since aBi+verbal-roots(work-in-progress) is not working,made changes in the input file by removing 'aBi' in 'aBikruXyawi' and in the test/tmp_anu_dir/clips_wsd_files,in rl2 manually wrote 'aBi-krux1' in rt as well as XatuH and ran those files there itself to see whether '2para' is coming.It is working fine till the morph-part is revised.

;3.3:SlAGahnufsWASapAM jFIpsyamAnaH-1.4.34.

;Get the number of SlAGAxi1 entries
(deffunction count-SlAGAxi1 (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "SlAGAxi1_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;Get the number of SlAGAxi2 entries
(deffunction count-SlAGAxi2 (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "SlAGAxi2_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;Get the number of SlAGAxi3 entries
(deffunction count-SlAGAxi3(?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "SlAGAxi3_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;SlAGAxi is working successfully.The procedure is the same as kruXAxi.


;case4:Divergences at the level of non-kAraka nominal suffixes.

;sapwamI upapaxa has been tested successfully.In the first example "gORu eva svAmI",the particle 'eva' comes between 'gORu' and 'svAmI',accordingly changes are made in the defrule giving additional [= (- ?a:id ?s:id) 2].


;case5:Deciding the kAraka/viBakwi taking the verbal roots into account.

;Get the number of ruh entries
(deffunction count-ruh (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct rt) A_ruh1))))

;the verbal root 'ruh' is not included in the dictionary.But the temp-testing works fine.


;case6:Corresponding to Sanskrit verb, Hindi uses complex predicate.

;Get the number of sq entries
(deffunction count-sq (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "sq_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

(deffunction count-sam_gam1 (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct rt) sam_gam1))))

;though 'anu-sq1' is entered in the dict.,it does not give the final output due to some errors pending.
;Get the number of wqwIyA-upapaxa entries
(deffunction count-wqwIyA-upapaxa (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "upapaxa_3_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;Get the number of sup entries with wqwIyA
(deffunction count-wqwIyAnwa (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct viBakwiH) 3))))

;Simple sentences have been chosen avoiding any samAsa,etc complications.First made a back-up copy of this file and filtered out unnecessary rules and functions and then tested all the upapaxa rules one-by-one by making corrections wherever required.With each upapaxa entry there has to be a sup entry of that particular viBakwi.The anu_interface executes the .html files and changes if any have to be carried out in wsd.clp file only. kAraka prblems are checked in assign_kaaraka.
;wqwIyA upapaxa has been tested successfully.eg:rAmeNa saha.In morph analyser,it marks 3 as upapaxa viBakwi and/or translates it as 3u.As of now we just take the latter part.The functions are 1)To check whether there are upapaxa words and 2)To check whether there are wqwIyAnwa before these upapaxa words.Then we give the rules, here defrule as:- IF 1) exists,2) exists THEN wqwIyAnwa i.e.,3 is marked as 3u when the next word is saha.Check whether each upapaxa words are included in their respective lists given in the kAraka folder.We have to check the accuracy of only those where the upapaxa is effected.Check whether the kAraka relations(G)are marking the upapaxa correctly.


;Get the number of xviwIyA-upapaxa entries
(deffunction count-xviwIyA-upapaxa (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "upapaxa_2_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;Get the number of sup entries with xviwIyA
(deffunction count-xviwIyAnwa (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct viBakwiH) 2))))

;xviwIyA upapaxa has been tested successfully.

;Get the number of paFcamI-upapaxa entries
(deffunction count-paFcamI-upapaxa (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "upapaxa_5_list.gdbm" (fact-slot-value ?fct rt)) "1"))))

;Get the number of sup entries with paFcamI
(deffunction count-paFcamyanwa (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct viBakwiH) 5))))

;paFcamI upapaxa has been tested successfully.

;Get the number of cawurWI-upapaxa entries
(deffunction count-cawurWI-upapaxa (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "upapaxa_4_list.gdbm" (fact-slot-value ?fct rt)) "1"))))


;Get the number of sup entries with cawurWI
(deffunction count-cawurWyAnwa (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct viBakwiH) 4))))

;cawurWI upapaxa has been tested succesfully.Two types of upapaxa are seen viz., one like svaswi,etc with defrule cawurWI_upapaxa_avy and the other related to benediction like AyuRya,Baxra,etc known as pseudo_avyayas with defrule cawurWI_upapaxa_sup.In the former ?a:rt(avyaya should be root) while in the latter ?a:word (avyaya should be word) and (?a sup)(?s sup).There is no proximity between noun and avy, cawurWyAnwa can occur anywhere in the sentence and hence (=<fact>1) is removed.

;Get the number of sup entries with RaRTI
(deffunction count-RaRTyanwa (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct viBakwiH) 6))))

;Get the number of sapwamI-upapaxa entries
(deffunction count-sapwamI-upapaxa (?template)
(length (find-all-facts ((?fct ?template))
(eq (gdbm_lookup "upapaxa_7_list.gdbm" (fact-slot-value ?fct rt)) "1"))))


;Get the number of sup entries with sapwamI
(deffunction count-sapwamyanwa (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct viBakwiH) 7))))

;sapwamI upapaxa has been tested successfully.In the first example "gORu eva svAmI",the particle 'eva' comes between 'gORu' and 'svAmI',accordingly changes are made in the defrule giving additional [= (- ?a:id ?s:id) 2].

(open "bar.txt" bar "a")

(defrule mark_wqwIyA_upapaxa_avy
(test (> (count-wqwIyAnwa sup) 0))
(or (test (> (count-wqwIyA-upapaxa avy) 0))
    (test (> (count-wqwIyA-upapaxa sup) 0)))
=>
(delayed-do-for-all-facts
((?a avy sup) (?s sup))
(and (= ?s:viBakwiH 3) (= (- ?a:id ?s:id) 1) (eq (gdbm_lookup "upapaxa_3_list.gdbm" ?a:rt) "1"))
(bind ?l (gdbm_lookup "upa_hinviB.gdbm" ?a:rt))
(modify ?s (viBakwiH ?l))
(printout bar "(" ?s:id " " ?s:mid " viB 3 ?l)" crlf)
)
)

(defrule mark_xviwIyA-upapaxa_right
(test (> (count-xviwIyAnwa sup) 0))
(test (> (count-xviwIyA-upapaxa avy) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy)  (?s sup))
(and (= ?s:viBakwiH 2) (= (- ?a:id ?s:id) 1) (eq (gdbm_lookup "upapaxa_2_list.gdbm" ?a:rt) "1"))
(bind ?l (gdbm_lookup "upa_hinviB.gdbm" ?a:rt))
(modify ?s (viBakwiH ?l))
(printout bar "(" ?s:id " " ?s:mid " viB 2 ?l)" crlf)
)
)

(defrule assign_paFcamI-upapaxa_avy
(test (> (count-paFcamyanwa sup) 0))
(or (test (> (count-paFcamI-upapaxa avy) 0))
    (test (> (count-paFcamI-upapaxa sup) 0)))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy sup) (?s sup)) 
(and (= ?s:viBakwiH 5) (= (- ?a:id ?s:id) 1)  (eq (gdbm_lookup "upapaxa_5_list.gdbm" ?a:rt) "1"))
(bind ?l (gdbm_lookup "upa_hinviB.gdbm" ?a:rt))
(modify ?s (viBakwiH ?l))
(printout bar "(" ?s:id " " ?s:mid " viB 5 ?l)" crlf)
)
)

(defrule assign_sapwamI-upapaxa_avy
(test (> (count-sapwamyanwa sup) 0))
(or (test (> (count-sapwamI-upapaxa avy) 0))
    (test (> (count-sapwamI-upapaxa sup) 0)))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy sup) (?s sup)) 
(and (= ?s:viBakwiH 7) (or (= (- ?a:id ?s:id) 1) (= (- ?a:id ?s:id) 2)) (eq (gdbm_lookup "upapaxa_7_list.gdbm" ?a:rt) "1"))
(bind ?l (gdbm_lookup "upa_hinviB.gdbm" ?a:rt))
(modify ?s (viBakwiH ?l))
(printout bar "(" ?s:id " " ?s:mid " viB 7 ?l)" crlf)
)
)

(defrule assign_cawurWI-upapaxa_avy
(test (> (count-cawurWyAnwa sup) 0))
(or (test (> (count-cawurWI-upapaxa avy) 0))
    (test (> (count-cawurWI-upapaxa sup) 0)))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy sup) (?s sup)) 
(and (= ?s:viBakwiH 4) (= (- ?a:id ?s:id) 1) (eq (gdbm_lookup "upapaxa_4_list.gdbm" ?a:rt) "1"))
(bind ?l (gdbm_lookup "upa_hinviB.gdbm" ?a:rt))
(modify ?s (viBakwiH ?l))
(printout bar "(" ?s:id " " ?s:mid " viB 4 ?l)" crlf )
)
)

(defrule assign_cawurWI-upapaxa_sup
(test (> (count-cawurWyAnwa sup) 0))
(test (> (count-cawurWI-upapaxa sup) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a sup) (?s sup))
(and (= ?s:viBakwiH 4)  (- ?a:id ?s:id) (eq (gdbm_lookup "upapaxa_4_list.gdbm" ?a:word) "1"))
(bind ?l (gdbm_lookup "upa_hinviB.gdbm" ?a:rt))
(modify ?s (viBakwiH ?l))
(printout bar "(" ?s:id " " ?s:mid " viB 4 ?l)" crlf )
)
)

;Get the number of sup entries with cawurWI
(deffunction count-cawurWyAnwa (?template)
(length (find-all-facts ((?fct ?template))
(eq (fact-slot-value ?fct viBakwiH) 4))))

;Took up those sentences where due to the kruXAxi verbal-roots the cawurWyAnwa in Sanskrit changes in Hindi (par,se,meM).Wrote example sentences in HTML-format and created kruXAxi(1,2,3)lists containing the verbal-roots in kAraka/list_n,and the viBakwi changes (par,se,meM) in dict/tam.txt by giving 'make' command.After preparing the lists they have to be entered in list_n/Makefile where they are converted to gdbm by giving 'make' command after saving.Then in prog/wsd> wsd.clp the deffunctions and defrules are given.The sup entries with cawurWI is retained as it is in upapaxa.Three defrules are created with the three kruXAxi_lists.The verbal-root 'asUya' is not working since it is a nAma-XAwu (work-in-progress).


;case1

(defrule disambiguate_xviwIyA_with_xiv
(test (> (count-xviwIyAnwa sup) 0))
(test (> (count-xiv wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 2) (<> ?s:id ?w:id) (eq (gdbm_lookup "xiv_list.gdbm" ?w:rt) "1"))
(modify ?s (viBakwiH 2se))
(printout bar "(" ?s:id " " ?s:mid " viB 2 2se)" crlf)
)
)

;2.1

(defrule disambiguate_xviwIyA_with_SIfAxi1
(test (> (count-xviwIyAnwa sup) 0))
(test (> (count-SIfAxi1 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 2) (<> ?s:id ?w:id) (or (eq ?w:rt aXi_SI1) (eq ?w:rt aXi_As1)))
(modify ?s (viBakwiH 2para))
(printout bar "(" ?s:id " " ?s:mid " viB 2 2para)" crlf)
)
)

(defrule disambiguate_xviwIyA_with_SIfAxi2
(test (> (count-xviwIyAnwa sup) 0))
(test (> (count-SIfAxi2 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 2) (<> ?s:id ?w:id) (eq ?w:rt aXi_sWA1))
(modify ?s (viBakwiH 2meM))
(printout bar "(" ?s:id " " ?s:mid " viB 2 2meM)" crlf)
)
)

;2.2

(defrule disambiguate_xviwIyA_with_viS
(test (> (count-xviwIyAnwa sup) 0))
(test (> (count-viS wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 2) (<> ?s:id ?w:id) (eq ?w:rt aBi_ni_viS1))
(modify ?s (viBakwiH 2meM))
(printout bar "(" ?s:id " " ?s:mid " viB 2 2meM)" crlf)
)
)

;2.3

(defrule disambiguate_xviwIyA_with_vas
(test (> (count-xviwIyAnwa sup) 0))
(test (> (count-vas wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 2) (<> ?s:id ?w:id) (eq ?w:rt upa_vas1))
(modify ?s (viBakwiH 2meM))
(printout bar "(" ?s:id " " ?s:mid " viB 2 2meM)" crlf)
)
)

;2.4
(defrule disambiguate_RaRTI_with_xiv
(test (> (count-RaRTyanwa sup) 0))
(test (> (count_xiv wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 6) (<> ?s:id ?w:id) (eq (gdbm_lookup "xiv_list.gdbm" ?w:rt) "1"))
;(and (= ?s:viBakwiH 6) (<> ?s:id ?w:id) (eq ?w:rt "xiv1"))
(modify ?s (viBakwiH 20))
(printout bar "(" ?s:id " " ?s:mid " viB 6 20)" crlf)
)
)


;3.1

(defrule disambiguate_cawurWI_with_kruXAxi1
(test (> (count-cawurWyAnwa sup) 0))
(test (> (count-kruXAxi1 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 4) (<> ?s:id ?w:id) (eq (gdbm_lookup "kruXAxi1_list.gdbm" ?w:rt) "1"))
(modify ?s (viBakwiH 4para))
(printout bar "(" ?s:id " " ?s:mid " viB 4 4para)" crlf)
)
)

(defrule disambiguate_cawurWI_with_kruXAxi2
(test (> (count-cawurWyAnwa sup) 0))
(test (> (count-kruXAxi2 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 4) (<> ?s:id ?w:id) (eq (gdbm_lookup "kruXAxi2_list.gdbm" ?w:rt) "1"))
(modify ?s (viBakwiH 4se))
(printout bar "(" ?s:id " " ?s:mid " viB 4 4se)" crlf)
)
)

(defrule disambiguate_cawurWI_with_kruXAxi3
(test (> (count-cawurWyAnwa sup) 0))
(test (> (count-kruXAxi3 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 4) (<> ?s:id ?w:id) (eq (gdbm_lookup "kruXAxi3_list.gdbm" ?w:rt) "1"))
(modify ?s (viBakwiH 4meM))
(printout bar "(" ?s:id " " ?s:mid " viB 4 4meM)" crlf)
)
)

;3.2

(defrule disambiguate_xviwIyA_with_kruXAxi1
(test (> (count-xviwIyAnwa sup) 0))
;(test (> (count-kruXAxi1 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 2) (<> ?s:id ?w:id) (eq ?w:rt aBi_kruX1))
(modify ?s (viBakwiH 2para))
(printout bar "(" ?s:id " " ?s:mid " viB 2 2para)" crlf)
)
)

(defrule disambiguate_xviwIyA_with_kruXAxi2
(test (> (count-xviwIyAnwa sup) 0))
;(test (> (count-kruXAxi2 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 2) (<> ?s:id ?w:id) (eq ?w:rt aBi_xruh1))
(modify ?s (viBakwiH 2se))
(printout bar "(" ?s:id " " ?s:mid " viB 2 2se)" crlf)
)
)

;3.3

(defrule disambiguate_cawurWI_with_SlAGAxi1
(test (> (count-cawurWyAnwa sup) 0))
(test (> (count-SlAGAxi1 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 4) (<> ?s:id ?w:id) (eq (gdbm_lookup "SlAGAxi1_list.gdbm" ?w:rt) "1"))
(modify ?s (viBakwiH 4kI))
(printout bar "(" ?s:id " " ?s:mid " viB 4 4kI)" crlf)
)
)

(defrule disambiguate_cawurWI_with_SlAGAxi2
(test (> (count-cawurWyAnwa sup) 0))
(test (> (count-SlAGAxi2 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 4) (<> ?s:id ?w:id) (eq (gdbm_lookup "SlAGAxi2_list.gdbm" ?w:rt) "1"))
(modify ?s (viBakwiH 4ko))
(printout bar "(" ?s:id " " ?s:mid " viB 4 4ko)" crlf)
)
)

(defrule disambiguate_cawurWI_with_SlAGAxi3
(test (> (count-cawurWyAnwa sup) 0))
(test (> (count-SlAGAxi3 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 4) (<> ?s:id ?w:id) (eq (gdbm_lookup "SlAGAxi3_list.gdbm" ?w:rt) "1"))
(modify ?s (viBakwiH 4ke_liye))
(printout bar "(" ?s:id " " ?s:mid " viB 4 4ke_liye)" crlf)
)
)


;case4

(defrule mark_xviwIyA-upapaxa_right
(test (> (count-xviwIyAnwa sup) 0))
(test (> (count-xviwIyA-upapaxa avy) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy)  (?s sup))
(and (= ?s:viBakwiH 2) (= (- ?a:id ?s:id) 1) (eq (gdbm_lookup "xviwIyA_upapaxa_list.gdbm" ?a:rt) "1"))
(modify ?s (viBakwiH 2u6))
(printout bar "(" ?s:id " " ?s:mid " viB 2 2u6)" crlf)
)
)

;case5

(defrule disambiguate_xviwIyA_with_ruh
(test (> (count-xviwIyAnwa sup) 0))
(test (> (count-ruh wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 2) (<> ?s:id ?w:id) (eq ?w:rt A_ruh1))
(modify ?s (viBakwiH 2para))
(printout bar "(" ?s:id " " ?s:mid " viB 2 2para)" crlf)
)
)


;case6

(defrule disambiguate_xviwIyA_with_sq
(test (> (count-xviwIyAnwa sup) 0))
(test (> (count-sq wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (= ?s:viBakwiH 2) (<> ?s:id ?w:id) (eq (gdbm_lookup "sq_list.gdbm" ?w:rt) "1"))
(modify ?s (viBakwiH 2kA))
(printout bar "(" ?s:id " " ?s:mid " viB 2 2kA)" crlf)
)
)

(defrule disambiguate_api
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy))
(and (eq ?a:rt api) (= ?a:id 1))
(modify ?a (rt api1))
(printout bar "(" ?a:id " " ?a:mid " rt api api1)" crlf)
)
)

(defrule disambiguate_param
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy))
(and (eq ?a:rt param) (= ?a:id 1))
(modify ?a (rt param1))
(printout bar "(" ?a:id " " ?a:mid " rt param param1)" crlf)
)
)

(defrule disambiguate_purA
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy))
(and (eq ?a:rt purA) (= ?a:id 1))
(modify ?a (rt purA1))
(printout bar "(" ?a:id " " ?a:mid " rt purA purA1)" crlf)
)
)


(defrule disambiguate_wawra
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a1 avy) (?a2 avy))
(and (eq ?a2:rt wawra) (eq ?a1:rt yawra) (= (- ?a2:id ?a1:id) 1))
(modify ?a2 (rt wawra1))
(printout bar "(" ?a2:id " " ?a2:mid " rt wawra wawra1)" crlf)
)
)

(defrule disambiguate_aBiXAna
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy) (?s sup))
(and (eq ?a:word iwi) (eq ?s:rt aBiXAna) (= (- ?s:id ?a:id) 1))
(modify ?s (rt aBiXAna1))
(printout bar "(" ?s:id " " ?s:mid " rt aBiXAna aBiXAna1)" crlf)
)
)


(defrule disambiguate_iwi
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy) (?s sup))
(and (eq ?a:word iwi) (eq ?s:word aBiXAnena) (= (- ?s:id ?a:id) 1))
(modify ?a (rt iwi1))
(printout bar "(" ?a:id " " ?a:mid " rt iwi iwi1)" crlf)
)
)

(defrule handle_viSeRaNa
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa))
(and (eq ?s1:viBakwiH ?s2:viBakwiH) (eq ?s1:vacanam ?s2:vacanam) ( (- ?s2:id ?s1:id) 1)(eq ?s1:lifgam ?s2:lifgam))
(modify ?s1 (viBakwiH 0))
(printout bar "(" ?s1:id " " ?s1:mid " viBakwiH " ?s2:viBakwiH " 0)" crlf)
)
)

(defrule handle_kriyAviSeRaNa
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s1 sup kqw waxXiwa))
(and (eq ?s1:viBakwiH 2) (eq ?s1:rel_nm kriyA_viSeRaNam))
(modify ?s1 (viBakwiH 0))
(printout bar "(" ?s1:id " " ?s1:mid " viBakwiH " ?s1:viBakwiH " 0)" crlf)
)
)

(defrule disambiguate_nAma_pre_word
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?a avy) (?s sup))
(and (eq ?a:rt nAma) (eq ?s:viBakwiH 1) (eq ?s:vacanam eka) (= (- ?a:id ?s:id) 1))
(printout bar "(" ?s:id " " ?s:mid " rt " ?s:rt " " ?s:rt"1)" crlf)
)
)

(defrule disambiguate_rAjA_post_word
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s1 sup) (?s2 sup))
(and (eq ?s1:rt rAjan) (= (- ?s2:id ?s1:id) 1)
     (= ?s1:viBakwiH ?s2:viBakwiH) (eq ?s1:lifgam ?s2:lifgam) (eq ?s1:vacanam ?s2:vacanam))
(printout bar "(" ?s2:id " " ?s2:mid " rt " ?s2:rt " " ?s2:rt "1)" crlf)
)
)

(defrule disambiguate_wqwIyA_with_sam_gam
(test (> (count-wqwIyAnwa sup) 0))
(test (> (count-sam_gam1 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (eq ?s:viBakwiH 3) (<> ?s:id ?w:id) (eq ?w:rt sam_gam1))
(modify ?s (viBakwiH 3u))
(printout bar "(" ?s:id " " ?s:mid " viB 3 3u)" crlf)
)
)

(defrule disambiguate_wqwIyA_with_sam_jFA
(test (> (count-wqwIyAnwa sup) 0))
(test (> (count-sam_jFA2 wif) 0))
;(declare (salience 100))
=>
(delayed-do-for-all-facts
((?s sup) (?w wif))
(and (eq ?s:viBakwiH 3) (<> ?s:id ?w:id) (eq ?w:rt sam_jFA2))
(modify ?s (viBakwiH 2ko))
(printout bar "(" ?s:id " " ?s:mid " viB 3 2)" crlf)
)
)

(agenda)
(run)
(facts)
(close bar)
(exit)
