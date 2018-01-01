;(reset)

; Get the number of sup entries with samboXana
(deffunction count-supkqw-samboXana (?template)
  (length (find-all-facts ((?fct ?template))
   (= (fact-slot-value ?fct viBakwiH) 8))))

; Check for the presence of sawi sapwami
(deffunction count-sawi-sapwami (?template)
  (length (find-all-facts ((?fct ?template))
   (and (eq (fact-slot-value ?fct viBakwiH) 7)(eq (fact-slot-value ?fct kqw_prawyayaH) Sawq)))))

; Check the presence of samboXana sUcaka avyayas
(deffunction count-samboXana-avy (?template)
  (length (find-all-facts ((?fct ?template))
     (eq (gdbm_lookup "samboXana_avy_wrds_list.gdbm" (fact-slot-value ?fct word)) "1" ))))


; yasya ca BAvena BAvalakRaNam
(open "foo.txt" foo "a")

(defrule sawi-sapwami
(test (>= (count-sawi-sapwami kqw) 1))
=>
; repeat for all
(do-for-all-facts

; kqxanwas
((?w kqw))

; having Sawq+7 form
(and
(eq ?w:kqw_prawyayaH Sawq)
(= ?w:viBakwiH 7)

; and no other word with 7 viBakwi in the sentence
(not (any-factp ((?s sup)) (= ?s:viBakwiH 7)))

; and the word under consideration has at least one non-Sawq+7 analysis
(any-factp ((?w1 sup wif)) (= ?w1:id ?w:id))
)

; then retract such analysis and also save this info in a file
(retract ?w)
(printout foo "(" ?w:id " " ?w:mid ") yasya ca BAvena BAvalakRaNam" crlf )
)
)
;============================================================================
; The rules for samboXana are fragile, and hence are commented.
; It is not a good idea to remove other morph analysis.

;; rAma awra AgacCa
;(defrule samboXana-1
;(or (test (>= (count-supkqw-samboXana sup) 1))
;(test (>= (count-supkqw-samboXana kqw) 1)))
;=>
;; For each of the wif sup pair
;(do-for-all-facts
;((?w wif)(?s sup kqw))
;
;; If the wif is in lot or viXilif lakAra
;; If the vacanam of the wif matches with the sup
;; If the sup is in samboXana
;; if the wif is not in uwwama puruRa
;; If only one samboXana with these properties exists,
;
;(and (<> ?w:id ?s:id) (or (eq ?w:lakAraH lot) (eq ?w:lakAraH viXilif)) (= ?s:viBakwiH 8) (eq ?w:vacanam ?s:vacanam) (neq ?w:puruRaH u) (or (= (count-supkqw-samboXana  sup) 1) (= (count-supkqw-samboXana kqw) 1)))
;
;; Remove all non samboXana analysis of such a word in samboXana.
;(do-for-all-facts
; ((?s1 sup wif kqw avy))
; (and (<> ?s:mid ?s1:mid) (= ?s:id ?s1:id))
;(retract ?s1)
;(printout foo "(" ?s1:id " " ?s1:mid ") another analysis is removed  " crlf )
;)
;)
;)
;;============================================================================
;(defrule samboXana-2
;(test (>= (count-samboXana-avy avy) 1))
;(or (test (>= (count-supkqw-samboXana  sup) 1)) (test (>= (count-supkqw-samboXana kqw) 1)))
;
;=>
;; For each of the avy sup pair
;(do-for-all-facts
;((?a avy)(?s sup kqw))
;
;; If the sup is in samboXana
;; If the avy is from samboXana-avy
;
;(and (<> ?a:id ?s:id) (gdbm_lookup "samboXana_avy_wrds_list.gdbm" ?a:word) (= (count-supkqw-samboXana  sup) 1) (= (count-supkqw-samboXana  kqw) 1))
;
;; Remove all non samboXana analysis of such a word in samboXana.
;(do-for-all-facts
; ((?s1 sup wif kqw avy))
; (and (<> ?s:mid ?s1:mid) (= ?s:id ?s1:id))
;(retract ?s1)
;(printout foo "(" ?s1:id " " ?s1:mid ") After the samboXana word samboXana avyaya is there  " crlf)
;)
;)
;)
;
(agenda)
(run)
(facts)
(save-facts for_kAraka.txt)
(close foo)
(close bar)
(exit)
