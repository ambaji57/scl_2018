;HELP ?w:id - ?a:id = 1 is written as follows in CLIPS
;(= (- ?w:id ?a:id) 1)
(reset)

; Get the number of sup entries with a given viBakwi
(deffunction count-viBakwi (?template ?viB)
(length (find-all-facts ((?fct ?template))
(= (fact-slot-value ?fct viBakwiH) ?viB))))


;check kwvA/wumun/lyap/...
(deffunction count-list (?template ?lst ?slotname)
 (length (find-all-facts ((?fct ?template))
    (eq (gdbm_lookup ?lst (fact-slot-value ?fct ?slotname)) "1"))))

;check slot
(deffunction slot-val-match (?template ?slot ?val)
(any-factp ((?fct ?template))
(eq (fact-slot-value ?fct ?slot) ?val)))

;count facts
(deffunction count-facts (?template)
  (length (find-all-facts ((?fct ?template)) TRUE)))
(open "bar.txt" bar "a")

;===========================================================================
; Assign karwA
;rAmaH vexam paTawi
;rAmaH is karwA of paTawi
;rl1
(defrule assign_karwA_karwqvAcya
(not (and (test (= (count-viBakwi sup 1) 0))(test (= (count-viBakwi waxXiwa 1) 0))))
;removed "test - kqw" for : pAcakaH rAmaH puswakam paTawi.
;(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi kqw 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w wif))
(and 
  (= ?s1:viBakwiH 1);sarveRu subAxiRu waxeva "?s1" yaw praWamA-viBakwO varwawe. 
  (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.ayam AsIw Gora-grIRma-samayaH.
; <> changed to <; because in complex sentences such as rAmaH pATam paTawi Palam ca Kaxawi, Palam is taken as a karwA of PaTawi.
  (eq ?w:prayogaH karwari);wifanwaM karwari syAw.
  (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - uBayoH vacane samAne syAwAm.
  (or 
    (and (eq ?w:puruRaH pra) (neq ?s1:rt asmax) (neq ?s1:rt yuRmaw)) ;wifanwaM praWama-puruRe syAw.
    (and (eq ?w:puruRaH ma) (eq ?s1:rt yuRmax)) ;yaxi wifanwaM maXyama-puruRe warhi  "?s1"-paxasya prAwipaxikaM "yuRmax" syAw.
    (and (eq ?w:puruRaH u) (eq ?s1:rt asmax));yaxi wifanwaM uwwama-puruRe warhi  "?s1"-paxasya prAwipaxikaM "asmax" syAw.
  )
  (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1"-paxaM "?w"-kriyAyAH karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl1 " ?k ?l crlf )

))
;===========================================================================
; Assign karwA_kwavawu
;rAmaH gqham gawavAn
;rlkvw
(defrule assign_karwA_kwavawu_karwqvAcya
(not (and (test (= (count-viBakwi sup 1) 0))(test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match kqw kqw_prawyayaH kwavawu) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w kqw))
(and 
  (= ?s1:viBakwiH 1);sarveRu subAxiRu waxeva "?s1" yaw praWamA-viBakwO varwawe. 
  (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.ayam AsIw Gora-grIRma-samayaH.
  (eq ?w:kqw_prawyayaH kwavawu);wifanwaM karwari syAw.
  (= ?w:viBakwiH 1);wifanwaM karwari syAw.
  (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - uBayoH vacane samAne syAwAm.
  (or (eq ?w:lifgam ?s1:lifgam);"?s1" "?w" - uBayoH vacane samAne syAwAm.
      (eq ?s1:rt yuRmax)
      (eq ?s1:rt asmax))
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1"-paxaM "?w"-kriyAyAH karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlkvw " ?k ?l crlf )

))
;==========================================================================
;Added by sheetal
;rAmaH grAmam gawaH.
;rlkw
(defrule assign_karwA_kwa_karwqvAcya1
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (> (count-list kqw karwq_karma_BAva_kwa.gdbm kqw_vb_rt) 0))
(not (and (test (= (count-viBakwi sup 1) 0))(test (= (count-viBakwi waxXiwa 1) 0))))
;(not (test (> (count-list kqw sakarmaka_XAwu_list.gdbm kqw_vb_rt) 0)))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w kqw))
(and 
  (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.ayam AsIw Gora-grIRma-samayaH.
  (eq ?w:kqw_prawyayaH kwa);wifanwaM karwari syAw.
  (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - uBayoH vacane samAne syAwAm.
 (or (eq ?w:lifgam ?s1:lifgam);"?s1" "?w" - uBayoH vacane samAne syAwAm.
      (eq ?s1:rt yuRmax)
      (eq ?s1:rt asmax))
  (eq (gdbm_lookup "karwq_karma_BAva_kwa.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
  ;(neq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
)

(if (= ?s1:viBakwiH 1) then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlkw " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlkw " ?k ?l crlf ))

))
;==========================================================================
;Added by Amba
;aham kIxqSIM xaSAm prApwaH asmi.
;rlkw1
(defrule assign_karwA_kwa_karwqvAcya2
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (> (count-list kqw karwq_karma_BAva_kwa.gdbm kqw_vb_rt) 0))
(not (and (test (= (count-facts sup) 0))(test (= (count-facts waxXiwa) 0))))
;(not (test (> (count-list kqw sakarmaka_XAwu_list.gdbm kqw_vb_rt) 0))))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w kqw))
(and 
  (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.ayam AsIw Gora-grIRma-samayaH.
  (eq ?w:kqw_prawyayaH kwa);wifanwaM karwari syAw.
  (eq (gdbm_lookup "karwq_karma_BAva_kwa.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
  ;(neq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1"))
)

(if (= ?s1:viBakwiH 3) then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlkw1 " ?k ?l crlf ))

(if (= ?s1:viBakwiH 2) then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlkw1 " ?k ?l crlf ))

))
;==========================================================================
;Added by sheetal
;rAmaH hasiwaH.
;rAmaH SayiwaH.
;rlkwa
(defrule assign_karwA_kwa_akarmaka_karwqvAcya
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(not (and (test (= (count-viBakwi sup 1) 0))(test (= (count-viBakwi waxXiwa 1) 0))))
(not (and 
         (test (< (count-list kqw akarmakaH_XAwu_list.gdbm kqw_vb_rt) 0))
         (test (< (count-list kqw karwq_karma_BAva_kwa.gdbm kqw_vb_rt) 0))
))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w kqw))
(and
  (= ?s1:viBakwiH 1)
  (= ?w:viBakwiH 1)
  (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.ayam AsIw Gora-grIRma-samayaH.
  (eq ?w:kqw_prawyayaH kwa);wifanwaM karwari syAw.
  (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - uBayoH vacane samAne syAwAm.
  (or (eq ?w:lifgam ?s1:lifgam);"?s1" "?w" - uBayoH vacane samAne syAwAm.
      (eq ?s1:rt yuRmax)
      (eq ?s1:rt asmax)
  )
  (not (and
           (neq (gdbm_lookup "akarmakaH_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
           (neq (gdbm_lookup "karwq_karma_BAva_kwa.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
       )
  )
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlkwa " ?k ?l crlf )

))
;==========================================================================
;Added by sheetal
;rAmeNa hasiwam.
;rAmeNa Sayiwam.
;rlkwb
(defrule assign_karwA_kwa_BAve
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(not (and (test (= (count-viBakwi sup 3) 0))(test (= (count-viBakwi waxXiwa 3) 0))))
(not (test (> (count-list kqw sakarmaka_XAwu_list.gdbm kqw_vb_rt) 0)))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w kqw))
(and
  (= ?s1:viBakwiH 3) 
  (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.ayam AsIw Gora-grIRma-samayaH.
  (eq ?w:kqw_prawyayaH kwa);wifanwaM karwari syAw.
  (= ?w:viBakwiH 1)
  ;(eq ?w:vacanam eka);"?s1" "?w" - uBayoH vacane samAne syAwAm.
;The above condition is wrong. vacanam may be different.
; e.g. rAmEH hasiwam/kqwam/gawam.
  (eq ?w:lifgam napuM);"?s1" "?w" - uBayoH vacane samAne syAwAm.
  (neq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlkwb " ?k ?l crlf )

))
;==========================================================================
;Added by sheetal
;pAcakaH pATam paTawi.
;vAxakaH jalam pibawi.
;rl2
(defrule assign_kqw_karwA_karwqvAcya
(test (> (count-viBakwi kqw 1) 0))
(test (eq (slot-val-match wif prayogaH karwari) TRUE))
=>
(do-for-all-facts
((?s1 kqw) (?w wif))
(and
(= ?s1:viBakwiH 1)
(< ?s1:id ?w:id)
(eq ?w:prayogaH karwari)
(eq ?w:vacanam ?s1:vacanam)
(neq ?w:sanAxiH Nic)
(or 
   (eq ?w:puruRaH pra);wifanwaM praWama-puruRe syAw.
   (and (eq ?w:puruRaH ma) (eq ?s1:rt yuRmax)) ;yaxi wifanwaM maXyama-puruRe warhi  "?s1xasya prAwipaxikaM "yuRmax" syAw.
   (and (eq ?w:puruRaH u) (eq ?s1:rt asmax));yaxi wifanwaM uwwama-puruRe warhi  "?s1"-pa prAwipaxikaM "asmax" syAw.
))
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl2 " ?k ?l crlf )
))
;===========================================================================
; Assign karma
;pAcakena waNdulaH pacyawe
; waNdulaH is karma of pacyawe
;rl3
(defrule assign_karma_karmavAcya
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi kqw 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
;(or (test (> (count-viBakwi sup 1) 0)) (test (> (count-viBakwi kqw 1) 0)) (test (> (count-viBakwi waxXiwa 1) 0)));praxawwa-vAkye nyUnAwinyUnamekaM paxaM supkqwwaxXiwAnwaM praWamAyAmaswIwi nirIkRyawe.
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));wifanwaM karmaNi vAcye aswIwi nirIkRyawe.
=>
(do-for-all-facts
;((?s1 sup kqw waxXiwa) (?w wif avykqw kqw))
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
; for avykqw and kqw, we have to think about the condition.
; The condition of karmaNi/BAve will not work
(and 
  (= ?s1:viBakwiH 1) ;sarveRu subAxiRu waxeva "?s1" yaw praWamA-viBakwO varwawe.
  (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
; The following condition will not work with avykqw or kqw
  (eq ?w:prayogaH karmaNi);wifanwaM karmaNi syAw. 
  (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - uBayoH vacane samAne syAwAm.
  (or 
    (eq ?w:puruRaH pra);wifanwaM praWama-puruRe syAw.
    (and (eq ?w:puruRaH ma) (eq ?s1:rt yuRmax));yaxi wifanwaM maXyama-puruRe warhi  "?s1"-paxasya prAwipaxikaM "yuRmax" syAw.
    (and (eq ?w:puruRaH u) (eq ?s1:rt asmax));yaxi wifanwaM uwwama-puruRe warhi  "?s1"-paxasya prAwipaxikaM "asmax" syAw.
  )
  (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
  (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1"-paxaM "?w"-kriyAyAH karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl3 " ?k ?l crlf )

))
;============================================================================
;Added by sheetal
;rAmeNa pATaH paTiwaH.
;rl4
(defrule assign_karwA_of_kwAnwa_kriyA
;(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(not (and (test (= (count-viBakwi sup 3) 0)) (test (= (count-viBakwi waxXiwa 3) 0))))
(or (test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH yaw) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH Nyaw) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH kyap) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH wavyaw) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH wavya) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH anIyar) TRUE))
)
(not (or  (test (> (count-list kqw karma_kqw_list.gdbm kqw_prawyayaH) 0))
          (test (> (count-list kqw BAva_kqw_list.gdbm kqw_prawyayaH) 0))
))
=>
(do-for-all-facts
((?s1 sup waxXiwa)(?w kqw))
(and 
  ;(= ?s1:viBakwiH 1) ;sarveRu subAxiRu waxeva "?s1" yaw praWamA-viBakwO varwawe.
  (= ?s1:viBakwiH 3)
  (< ?s1:id ?w:id)
  (or (eq ?w:kqw_prawyayaH kwa)
      (eq ?w:kqw_prawyayaH yaw)
      (eq ?w:kqw_prawyayaH Nyaw)
      (eq ?w:kqw_prawyayaH kyap)
      (eq ?w:kqw_prawyayaH wavyaw)
      (eq ?w:kqw_prawyayaH wavya)
      (eq ?w:kqw_prawyayaH anIyar)
   )                       ;wifanwaM karmaNi syAw. 
  ;(eq ?w:vacanam ?s1:vacanam)
  ;(eq ?w:viBakwiH ?s1:viBakwiH)
  ;(eq ?w:lifgam ?s1:lifgam)
  (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
  (neq (gdbm_lookup "karwq_karma_BAva_kwa.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1"))

;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1"-paxaM "?w"-kriyAyAH karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl4 " ?k ?l crlf )

))
;============================================================================
;Added by sheetal
;rAmeNa pATaH paTiwaH.
;rl4a
(defrule assign_karma_of_kwAnwa_kriyA
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(or (test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH yaw) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH Nyaw) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH kyap) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH wavyaw) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH wavya) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH anIyar) TRUE))
)
(test (> (count-list kqw sakarmaka_XAwu_list.gdbm kqw_vb_rt) 0))
=>
(do-for-all-facts
((?s1 sup waxXiwa)(?w kqw))
(and 
  (= ?s1:viBakwiH 1) ;sarveRu subAxiRu waxeva "?s1" yaw praWamA-viBakwO varwawe.
  (< ?s1:id ?w:id)
(or (eq ?w:kqw_prawyayaH kwa)
      (eq ?w:kqw_prawyayaH yaw)
      (eq ?w:kqw_prawyayaH Nyaw)
      (eq ?w:kqw_prawyayaH kyap)
      (eq ?w:kqw_prawyayaH wavyaw)
      (eq ?w:kqw_prawyayaH wavya)
      (eq ?w:kqw_prawyayaH anIyar)
   )   ;wifanwaM karmaNi syAw. 
  (eq ?w:vacanam ?s1:vacanam)
  (eq ?w:viBakwiH ?s1:viBakwiH)
  (eq ?w:lifgam ?s1:lifgam)
  (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
  (neq (gdbm_lookup "karwq_karma_BAva_kwa.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1"-paxaM "?w"-kriyAyAH karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl4 " ?k ?l crlf )

))
;============================================================================
; Assign karwA in karmaNi/BAve prayoga
; rAmeNa gamyawe
; rAmeNa is karwA of gamyawe

;pAcakena waNdulaH pacyawe
; pAcakena is karwA of pacyawe
;rl5
(defrule assign_karwA_karmavAcya
(not (and (test (= (count-viBakwi sup 3) 0)) (test (= (count-viBakwi kqw 3) 0)) (test (= (count-viBakwi waxXiwa 3) 0))))
(or 
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));wifanwaM karmaNi vAcye aswIwi nirIkRyawe.
(test (eq (slot-val-match wif prayogaH BAve) TRUE));wifanwaM BAva-vAcye aswIwi nirIkRyawe.
)
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
  (= ?s1:viBakwiH 3);sarveRu subAxiRu waxeva "?s1" yaw wqwIyA-viBakwO varwawe. 
  (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
  (or 
    (eq ?w:prayogaH karmaNi);wifanwaM karmaNi syAw. 
    (eq ?w:prayogaH BAve);wifanwaM BAve syAw. 
  )
  (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl5 " ?k ?l crlf )

))

;===========================================================================
; Assign karma
;rAmaH vexam paTawi
; vexam is the karma of paTawi
;rl6
(defrule assign_karma_karwqvAcya
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (> (count-list wif sakarmaka_XAwu_list.gdbm rt) 0));XAwuH sakarmakoswIwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
  (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe. 
  (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
  (eq ?w:prayogaH karwari);wifanwaM karwari syAw. 
  (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
  (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1") 
  (neq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" (fact-slot-value ?w rt)) "1");xvikarmaka-XAwurna syAw.
  (neq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" (fact-slot-value ?w rt)) "1");xvikarmaka-XAwurna syAw.
  (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w rt)) "1");XAwuH sakarmakaH syAw.
  (neq ?w:rt iR2)
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl6 " ?k ?l crlf )

))
;===========================================================================
;Added by sheetal
;mohanaH grAmam ganwum rAmam icCawi.
;rl7
(defrule assign_karma_for_iR2_with_wumun_karwqvAcya
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE))
(test (eq (slot-val-match wif rt iR2) TRUE))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
  (= ?s1:viBakwiH 2)
  (= (- ?w:id ?s1:id) 1)
  (eq ?w:prayogaH karwari)
  (eq ?w:rt iR2)
  )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl7 " ?k ?l crlf )

))
;============================================================================
;Added by sheetal.
; Assign karma
;rAmaH paTanam karowi.
;rl8
(defrule assign_kqw_karma_karwqvAcya
(not (test (= (count-viBakwi kqw 2) 0)))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (> (count-list wif sakarmaka_XAwu_list.gdbm rt) 0));XAwuH sakarmakoswIwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 kqw) (?w wif));sarveByaH kqxanweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and
  (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe.
  (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
  ;(neq ?s1:kqw_prawyayaH kwa);kqw-prawyayaH "kwa" na Bavew : saH api pUrNaM moxakaM grahIwum icCawi sma.Removed by AMBA, tested this sentence and it works. 17/1/2011.
  (eq ?w:prayogaH karwari);wifanwaM karwari syAw.
  (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
  (neq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" (fact-slot-value ?w rt)) "1");xvikarmaka-XAwurna syAw.
  (neq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" (fact-slot-value ?w rt)) "1");xvikarmaka-XAwurna syAw.
  (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w rt)) "1");XAwuH sakarmakaH syAw.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl8 " ?k ?l crlf )

))
;===========================================================================
;Assign karma to iR2 only if a verb with tumun is absent.
; In the presence of wunum, iR2 will not have a karma.
;rAmaH vexam paTiwum icCawi.
;Here vexam is not a karma of icCawi.
;rAmaH maXuram Palam KAxiwum icCawi.
;'rAmaH KAxiwum Palam icCawi' will also have the same meaning as 'rAmaH Palam KAxiwum icCawi'.
; Rama wants to eat fruit.
; 'rAmaH KAxanArWam Palam icCawi' will have another sense.
; Rama wants a fruit to eat.
;To avoid maXuram = karma (iR) and Palam = karma (KAx)
;===================================================================================
;Modified by sheetal
;saH api pUrNam modakam grahIwum icCawi.
;rl7
;(defrule assign_karma_to_wumun_with_iR2
;(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
;(test (eq (slot-val-match wif rt iR2) TRUE))
;(test (neq (slot-val-match kqw kqw_prawyayaH wumun) TRUE));kqw-prawyayaH "wumun" nAswIwi nirIkRyawe.
;=>
;(do-for-all-facts
;((?s1 sup ) (?wu avykqw)(?w wif kqw) );sarveByaH subanweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
;(and
;  (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe.
;  (< ?s1:id ?wu:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
;  (< ?wu:id ?w:id)
;  (eq ?w:rt iR2)
;  (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?wu rt)) "1")
;  (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
;)
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
;(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?wu:id " " ?wu:mid " ) " );"?w" paxasya "?s1" paxaM karma saMBavawi.
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rl7 " ?k ?l crlf )
;))
;===================================================================================
;Added by sheetal
;grAmawaH ganwum icCanwam rAmam mohanaH kaWAm kaWayawi.
;rl8a
(defrule assign_wumunanwa_karma_to_iR2_kqxanwa
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
(test (eq (slot-val-match kqw kqw_vb_rt iR2) TRUE))
=>
(do-for-all-facts
((?s1 avykqw ) (?w kqw) )
(and
;(< ?s1:id ?w:id)
(= (- ?w:id ?s1:id) 1)
(eq ?w:kqw_vb_rt iR2)
(eq ?s1:kqw_prawyayaH wumun))
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl8a " ?k ?l crlf )
))
;====================================================================================
;Added by sheetal
;anyasya aniRtam karwum icCukaH janaH kasya upekRAm karowi.
;rl9
(defrule assign_karma_for_icCukaH
(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0));kqw-prawyayosvyayakqwsUcyAM aswIwi nirIkRyawe.
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
(test (eq (slot-val-match sup rt icCuka) TRUE))
=>
(do-for-all-facts
((?s sup) (?a avykqw));sarveByaH wifanwakqxanweByaH "?w" iwi nAma xIyawe avyayakqxanweByaSca "?w" evaM "?a" iwi.

(and (eq ?a:kqw_prawyayaH wumun);kqw-prawyayaH wumun syAw. 
     (eq (- ?s:id ?a:id) 1)
     (eq ?s:rt icCuka)
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s:id " " ?s:mid " ) " );"?a" paxaM "?w" paxena saha prayojanawvena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl9 " ?k ?l crlf )

)
)
;==========================================================================================
;Added by sheetal
;rAmaH maXuram Palam KAxiwum icCawi.
;rl10
(defrule assign_wumunanwa_karma_to_iR2
(test (eq (slot-val-match wif rt iR2) TRUE))
; Do we need the following condition? Does it mean the rule does not apply if the verb is in Bhave?
; Since the purpose of this condition is not clear, and hence commented by Amba, Similarly the correponding line in the action part is also commented.
;(or (test (eq (slot-val-match wif prayogaH karwari) TRUE))(test (eq (slot-val-match wif prayogaH karmaNi) TRUE)))

(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
=>
(do-for-all-facts
((?s1 avykqw ) (?w wif) )
(and
(< ?s1:id ?w:id)
(eq ?w:rt iR2)
(eq ?s1:kqw_prawyayaH wumun)
;(or (eq ?w:prayogaH karwari)(eq ?w:prayogaH karmaNi))
(neq ?w:sanAxiH Nic))
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl10 " ?k ?l crlf )
))
;=========================================================================================
; Assign karma in karwari Nic
; aXyApakaH CAwram pATayawi
; CAwram is the karma of PATayawi

;rl11
(defrule assign_karma_karwariNic
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 2) ;sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe.
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karwari);wifanwaM karwari syAw. 
    (eq ?w:sanAxiH Nic);wifanwaM Nici syAw.
    (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1")
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl11 " ?k ?l crlf )

))
;===========================================================================
; Following 5 functions deal with the prayojaka and prayojya karwAs.
; prayoga       prayojaka    		prayojya    	   gatibuddhi
; karwari_Nic   1(case 1 below)    2(case 3 below)        Yes
; karwari_Nic   1(case 1 below)    3(case 4 below)        No
; karmaNi_Nic   3(case 5 below)    2(case 2 below)        either or
;===========================================================================
; Assign prayojaka karwA (Case 1)
; xevaxawwaH yajFaxawwena oxanam pAcayawi.
; xevaxawwaH is karwA of pAcayawi.

; xevaxawwaH yajFaxawwam pATam pATayawi.
; xevaxawwaH is karwA of pATayawi.
;rl12
(defrule assign_prayojaka_karwA_karwqvAcya
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi kqw 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));wifanwaM Nici varwawa iwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 1);sarveRu subAxiRu waxeva "?s1" yaw praWamA-viBakwO varwawe. 
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karwari);wifanwaM karwari syAw. 
    (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - uBayoH vacane samAne syAwAm. 
    (or 
      (eq ?w:puruRaH pra);wifanwaM praWama-puruRe syAw. 
      (and (eq ?w:puruRaH ma) (eq ?s1:rt yuRmax));yaxi wifanwaM maXyama-puruRe warhi "?s1"-paxasya prAwipaxikaM "yuRmax" syAw. 
      (and (eq ?w:puruRaH u) (eq ?s1:rt asmax));yaxi wifanwaM uwwama-puruRe warhi "?s1"-paxasya prAwipaxikaM "asmax" syAw.
    )
    (eq ?w:sanAxiH Nic);wifanwaM Nici syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojakakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH prayojaka-karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl12 " ?k ?l crlf )

))
;===========================================================================
; Assign prayojya karwA (case 2)

; aXyApakena CAwram pATaH pATyawe.
; CAwraH is prayojya karwA of pATyawe

; aXyApakena CAwram waNdulaH pAcyawe.
; CAwram is prayojya karwA of pAcyawe


;rl13
(defrule assign_prayojya_karwA_karmavAcya
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi kqw 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));wifanwaM karmaNi vAcye aswIwi nirIkRyawe.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));wifanwaM Nici varwawa iwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 1);sarveRu subAxiRu waxeva "?s1" yaw praWamA-viBakwO varwawe. 
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karmaNi);wifanwaM karmaNi syAw. 
    (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - uBayoH vacane samAne syAwAm. 
    (or 
      (eq ?w:puruRaH pra);wifanwaM praWama-puruRe syAw. 
      (and (eq ?w:puruRaH ma) (eq ?s1:rt yuRmax));yaxi wifanwaM maXyama-puruRe warhi "?s1"-paxasya prAwipaxikaM "yuRmax" syAw. 
      (and (eq ?w:puruRaH u) (eq ?s1:rt asmax));yaxi wifanwaM uwwama-puruRe warhi "?s1"-paxasya prAwipaxikaM "asmax" syAw.
    )
    (eq ?w:sanAxiH Nic);wifanwaM Nici syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojyakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH prayojya-karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl13 " ?k ?l crlf )

))
;===========================================================================
; Assign prayojya karwA (Case 3)
;aXyApakaH CAwram grAmam gamayawi.
; CAwraH is the prayojya karwA of gamayawi.
;
;rl14
(defrule assign_prayojya_karwA_karwqvAcya_gawibuxXi
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));wifanwaM Nici varwawa iwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe. 
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karwari);wifanwaM karwari syAw. 
    (eq ?w:sanAxiH Nic);wifanwaM Nici syAw.
    (eq (gdbm_lookup "gawibuxXi_XAwu_list.gdbm" ?w:rt) "1");XAwurgawyAxiRu(0/3/41) varwewa.
    (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1")
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojyakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH prayojya-karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl14 " ?k ?l crlf )

))
;===========================================================================
;Added by sheetal
;xampawyoH kalahaH mAm niwarAm upahAsayawi sma.
;rl15
(defrule assign_prayojya_karwA_karwqvAcya_akarmaka
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));wifanwaM Nici varwawa iwi nirIkRyawe.
(test (= (count-list wif sakarmaka_XAwu_list.gdbm rt) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe. 
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karwari);wifanwaM karwari syAw. 
    (eq ?w:sanAxiH Nic);wifanwaM Nici syAw.
    (neq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" ?w:rt) "1")
    (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1")
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojyakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH prayojya-karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl15 " ?k ?l crlf )

))
;===========================================================================
; Assign prayojya karwA (case d)

; xevaxawwaH yajFaxawwena oxanam pAcayawi.
; yajFaxawwena is prayojya karwA of pAcayawi.

;rl16
(defrule assign_prayojya_karwA_karwqvAcya_no_gawibuxXi
(not (and (test (= (count-viBakwi sup 3) 0)) (test (= (count-viBakwi kqw 3) 0)) (test (= (count-viBakwi waxXiwa 3) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));wifanwaM Nici varwawa iwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 3);sarveRu subAxiRu waxeva "?s1" yaw wqwIyA-viBakwO varwawe. 
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karwari);wifanwaM karwari syAw. 
    (eq ?w:sanAxiH Nic);wifanwaM Nici syAw.
    (neq (gdbm_lookup "gawibuxXi_XAwu_list.gdbm" ?w:rt) "1");XAwurgawyAxiRu(0/3/41) na Bavew.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojyakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH prayojya-karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl16 " ?k ?l crlf )

))
;===========================================================================
; Assign prayojaka karwA (case 5)
;yajFaxawwena puwram pATaH pATyawe
;yajFaxawwa is the prayojaka karwA of pATyawe.

;yajFaxawwena puwram waNdulaH pAcyawe
;yajFaxawwa is the prayojaka karwA of pAcyawe.

;rl17
(defrule assign_prayojaka_karwA_karmavAcya
(not (and (test (= (count-viBakwi sup 3) 0)) (test (= (count-viBakwi kqw 3) 0)) (test (= (count-viBakwi waxXiwa 3) 0))))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));wifanwaM karmaNi vAcye aswIwi nirIkRyawe.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));wifanwaM Nici varwawa iwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 3);sarveRu subAxiRu waxeva "?s1" yaw wqwIyA-viBakwO varwawe. 
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karmaNi);wifanwaM karmaNi syAw. 
    (eq ?w:sanAxiH Nic);wifanwaM Nici syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojakakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );;"?s1" paxaM "?w" kriyAyAH prayojaka-karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl17 " ?k ?l crlf )

))
;===========================================================================
; Assign gOna-muKyakarma
;rAmaH vexam paTawi
;rl18
(defrule assign_gONamuKyakarma_1karwqvAcya
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (> (count-list wif xvikarmaka_XAwu_list1.gdbm rt) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe. 
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karwari);wifanwaM karwari syAw. 
    (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" ?w:rt) "1");xvikarmaka-XAwuH syAw.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH gONa-karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl18 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "muKyakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH muKya-karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl18 " ?k ?l crlf )

))
;===========================================================================
; Assign muKya-gONakarma
;rAmaH vexam paTawi
;rl19
(defrule assign_gONamuKyakarma_2karwqvAcya
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));wifanwaM karwari vAcye aswIwi nirIkRyawe.
(test (> (count-list wif xvikarmaka_XAwu_list2.gdbm rt) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe. 
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karwari);wifanwaM karwari syAw. 
    (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" ?w:rt) "1");xvikarmaka-XAwuH syAw.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH gONa-karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl19 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "muKyakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH muKya-karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl19 " ?k ?l crlf )

))
;===========================================================================
; Assign muKyakarma
;rAmeNa ajA grAmam nIyawe
;rl20
(defrule assign_muKyakarma_2karmavAcya
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi kqw 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));wifanwaM karmaNi vAcye aswIwi nirIkRyawe.
(test (> (count-list wif xvikarmaka_XAwu_list2.gdbm rt) 0));xvikarmaka-XAwuH syAw.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 1);sarveRu subAxiRu waxeva "?s1" yaw praWamA-viBakwO varwawe. 
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karmaNi);wifanwaM karmaNi syAw. 
    (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" ?w:rt) "1");xvikarmaka-XAwuH syAw.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH muKya-karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl20 " ?k ?l crlf )

)
)
;===========================================================================
; Assign gONakarma
;rAmeNa ajA grAmam nIyawe
;rl21
(defrule assign_gONakarma_2karmavAcya
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));wifanwaM karmaNi vAcye aswIwi nirIkRyawe.
(test (> (count-list wif xvikarmaka_XAwu_list2.gdbm rt) 0));xvikarmaka-XAwuH syAw.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and
    (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe.
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
    (eq ?w:prayogaH karmaNi);wifanwaM karmaNi syAw.
    (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" ?w:rt) "1");xvikarmaka-XAwuH syAw.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH gONa-karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl21 " ?k ?l crlf )

)
)

;====================================================================================================================
; Assign muKyakarma
;rAmeNa nqpaH BikRAm yAcyawe
;rl22
(defrule assign_muKyakarma_1karmavAcya
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));wifanwaM karmaNi vAcye aswIwi nirIkRyawe.
(test (> (count-list wif xvikarmaka_XAwu_list1.gdbm rt) 0));xvikarmaka-XAwuH syAw.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and
    (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe.
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
    (eq ?w:prayogaH karmaNi);wifanwaM karmaNi syAw.
    (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" ?w:rt) "1");xvikarmaka-XAwuH syAw.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH muKya-karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl22 " ?k ?l crlf )

)
)
;====================================================================================================================
; Assign gONakarma
;rAmeNa nqpaH BikRAm yAcyawe
;rl23
(defrule assign_gONakarma_1karmavAcya
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi kqw 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));wifanwaM karmaNi vAcye aswIwi nirIkRyawe.
(test (> (count-list wif xvikarmaka_XAwu_list1.gdbm rt) 0));xvikarmaka-XAwuH syAw.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAya ca "?w" iwi.
(and 
    (= ?s1:viBakwiH 1);sarveRu subAxiRu waxeva "?s1" yaw praWamA-viBakwO varwawe. 
    (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
    (eq ?w:prayogaH karmaNi);wifanwaM karmaNi syAw. 
    (neq ?w:sanAxiH Nic);wifanwaM Nici na syAw.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" ?w:rt) "1");xvikarmaka-XAwuH syAw.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" kriyAyAH gONa-karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl23 " ?k ?l crlf )

))
;===========================================================================
;Assign muKya-gONakarma-avukqw
;gudAkeSaH govinxam ukwvA baBUva.
;rlkqw_muKya
(defrule assign_gONamuKyakarma_2karwqvAcya_avykqw
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(not (and (test (> (count-list avykqw xvikarmaka_XAwu_list2.gdbm rt) 0))
          (test (> (count-list avykqw xvikarmaka_XAwu_list1.gdbm rt) 0))
     )
)
(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w avykqw))
(and 
    (= ?s1:viBakwiH 2)
    (< ?s1:id ?w:id)
    (or (eq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" ?w:rt) "1")
        (eq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" ?w:rt) "1")
    )
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlkqw_muKya " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "muKyakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlkqw_muKya " ?k ?l crlf )
))
;===========================================================================
;rAmaH xAwreNa pAxapam lunAwi
;rl24
(defrule assign_karaNa
(not (and (test (= (count-viBakwi sup 3) 0)) (test (= (count-viBakwi kqw 3) 0)) (test (= (count-viBakwi waxXiwa 3) 0))))
(test (> (count-list wif karaNa_XAwu_list.gdbm rt) 0));XAwuH sakaraNako varwawa iwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif avykqw));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwAvyayakqxanweByaSca "?w" iwi.
(and (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
     (= ?s1:viBakwiH 3);sarveRu subAxiRu waxeva "?s1" yaw wqwIyA-viBakwO varwawe.
     (eq (gdbm_lookup "karaNa_XAwu_list.gdbm" ?w:rt) "1");XAwuH sakaraNakaH syAw.
     (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyAH karaNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl24 " ?k ?l crlf )

)
)
;===========================================================================
;rAmaH SyAmena xAwreNa lunam pAxapam paSyawi
;rl25
(defrule assign_karaNa_kqw
(not (and (test (= (count-viBakwi sup 3) 0)) (test (= (count-viBakwi kqw 3) 0)) (test (= (count-viBakwi waxXiwa 3) 0))))
(test (> (count-list kqw karaNa_XAwu_list.gdbm kqw_vb_rt) 0));XAwuH sakaraNakaH aswIwi nirIkRyawe.
(not (or  (test (> (count-list kqw karma_kqw_list.gdbm kqw_prawyayaH) 0))
          (test (> (count-list kqw BAva_kqw_list.gdbm kqw_prawyayaH) 0))
))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaSca "?s1" evaM "?w" iwi.
(and (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
     (= ?s1:viBakwiH 3);sarveRu subAxiRu waxeva "?s1" yaw wqwIyA-viBakwO varwawe.
     (eq (gdbm_lookup "karaNa_XAwu_list.gdbm" ?w:kqw_vb_rt) "1"));XAwuH sakaraNakaH syAw.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyAH karaNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl25 " ?k ?l crlf )

)
)

;===========================================================================
;rAmaH aXyayanena grAme vasawi
;rl26
(defrule assign_hewu
(not (and (test (= (count-viBakwi sup 3) 0)) (test (= (count-viBakwi kqw 3) 0)) (test (= (count-viBakwi waxXiwa 3) 0))))
;(test (= (count-list wif karaNa_XAwu_list.gdbm rt) 0))
; It is not necessary that the verb does not have any karana AkfkRA. Karana and hewu both can occur in a sentence.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif avykqw kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaH "?s1" evaM "?w" wifanwAvyayakqxanweByaSca "?w" iwi.
(and (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
     (= ?s1:viBakwiH 3);sarveRu subAxiRu waxeva "?s1" yaw wqwIyA-viBakwO varwawe.
(neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "hewuH"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyAH hewuH saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl26 " ?k ?l crlf )

)
)
;========================================================================
;Added by sheetal
;aSvaH vegena XAvawi.
;rl27
(defrule assign_kriyA_viSeRaNa
(or (test (> (count-list sup kriyAviSeRaNa.gdbm word) 0))  (test (> (count-list avy kriyAviSeRaNa.gdbm word) 0)) (test (> (count-list kqw kriyAviSeRaNa.gdbm word) 0)) (test (> (count-list waxXiwa kriyAviSeRaNa.gdbm word) 0)))
(not (and (test (= (count-facts wif) 0))(test (= (count-facts avykqw) 0))(test (= (count-facts kqw) 0))))
=>
(do-for-all-facts
((?s1 avy sup kqw waxXiwa) (?w wif avykqw kqw));sarveByosvyayeByaH "?s1" iwi nAma xIyawe kqxanwAvyayakqxanwawifanweByaSca "?w" iwi.
(and 
;(= (- ?w:id ?s1:id) 1)
(< ?s1:id ?w:id)
(eq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1");"?s1" paxaM kriyAviSeRaNasUcyAM syAw
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "kriyAviSeRaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " "  ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyAH kriyAviSeRaNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl27 " ?k ?l crlf )

))
;=======================================================================
;Added by sheetal
;yaH gAyawrI-manwram niwyam na japawi.
;rl28
(defrule assign_kriyA_viSeRaNa_with_na
(not (and (test (= (count-list sup kriyAviSeRaNa.gdbm word) 0)) (test (= (count-list waxXiwa kriyAviSeRaNa.gdbm word) 0))))
(test (eq (slot-val-match avy word na) TRUE))
(not (and (test (= (count-facts wif) 0))(test (= (count-facts avykqw) 0))(test (= (count-facts kqw) 0))))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w wif avykqw kqw)(?s2 avy));sarveByosvyayeByaH "?s1" iwi nAma xIyawe kqxanwAvyayakqxanwawifanweByaSca "?w" iwi.
(and 
(= (- ?w:id ?s1:id) 2) 
(= (- ?w:id ?s2:id) 1)
(eq ?s2:rt na)
(eq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1"));"?s1" paxaM kriyAviSeRaNasUcyAM syAw.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "kriyAviSeRaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyAH kriyAviSeRaNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl28 " ?k ?l crlf )

))
;=================================================================================
;piwA rAmAya puswakam xaxAwi
;piwA rAmAya xAwum puswakam krINAwi
;piwA rAmAya xAwum puswakam krINAwi;piwA rAmAya xawwam Palam KAxawi 
;rl29
(defrule assign_sampraxAna
(not (and (test (= (count-viBakwi sup 4) 0)) (test (= (count-viBakwi kqw 4) 0)) (test (= (count-viBakwi waxXiwa 4) 0))))
(or (test (> (count-list wif sampraxAna_XAwu_list.gdbm rt) 0));XAwuH sasampraxAnakosswIwi nirIkRyawe. 
    (test (> (count-list avykqw sampraxAna_XAwu_list.gdbm rt) 0)));XAwuH sasampraxAnakosswIwi nirIkRyawe. 
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif avykqw kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaH "?s1" evaM "?w" wifanwAvyayakqxanweByaSca "?w" iwi.
	
(and (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
     (= ?s1:viBakwiH 4);sarveRu subAxiRu waxeva "?s1" yaw cawurWyAM varwawe. 
     (eq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:rt) "1");XAwuH sasampraxAnako Bavew..
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sampraxAnam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyAH sampraxAnaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl29 " ?k ?l crlf )

)
)
;========================================================================
;piwA rAmAya xawwam Palam KAxawi
;rl30
(defrule assign_sampraxAna_kqw
(not (and (test (= (count-viBakwi sup 4) 0)) (test (= (count-viBakwi kqw 4) 0)) (test (= (count-viBakwi waxXiwa 4) 0))))
(test (> (count-list kqw sampraxAna_XAwu_list.gdbm kqw_vb_rt) 0));XAwuH sasampraxAnakosswIwi nirIkRyawe. 
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaSca "?s1" evaM "?w" iwi.

(and (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
     (= ?s1:viBakwiH 4);sarveRu subAxiRu waxeva "?s1" yaw cawurWyAM varwawe.
     (eq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:kqw_vb_rt) "1"));XAwuH sasampraxAnako Bavew.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sampraxAnam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyAH sampraxAnaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl30 " ?k ?l crlf )
)
)                                      
;======================================================================== 
;rl31
; Written by Sheetal, modified by Pavan; checked by Amba
(defrule assign_wAxarWya
(not (and (test (= (count-viBakwi sup 4) 0)) (test (= (count-viBakwi kqw 4) 0)) (test (= (count-viBakwi waxXiwa 4) 0))))
(not (and (test (= (count-facts wif) 0)) (test (= (count-facts kqw) 0))))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa) (?w wif kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaH "?s1" evaM "?w" wifanwAvyayakqxanweByaSca "?w" iwi.
	
(and (= (- ?s2:id ?s1:id) 1) ;vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
	(<> ?s1:id ?w:id)
     	(<> ?s2:id ?w:id)
     	(= ?s1:viBakwiH 4);sarveRu subAxiRu waxeva "?s1" yaw cawurWyAM varwawe.
        (neq ?s2:rt kiFciw)
        (neq ?s2:rt asmax)
        (neq ?s2:rt yuRmax)
        (neq ?s2:rt sarva); 
     	(neq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:rt) "1")
     	(neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s2:word) "1") ; this is added to avoid the relation between yuxXAya and vegena/wvarayA in yuxXAya vegena gacCawi
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "wAxarWyam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid ") " );"?s1" paxasya "?w" kriyayA saha wAxarWya-saMbanXaH saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl31 " ?k ?l crlf )
)
)
;==========================================================================
;rl32
(defrule assign_apAxAna
(not (and (test (= (count-viBakwi sup 5) 0)) (test (= (count-viBakwi kqw 5) 0)) (test (= (count-viBakwi waxXiwa 5) 0))))
(not (and (test (= (count-list wif apAxAna_XAwu_list.gdbm rt) 0))(test (= (count-list avykqw apAxAna_XAwu_list.gdbm rt) 0))))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif avykqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaH "?s1" evaM "?w" wifanwAvyayakqxanweByaSca "?w" iwi.
(and (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
     (= ?s1:viBakwiH 5);sarveRu subAxiRu waxeva "?s1" yaw paFcamyAM varwawe.
     (eq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:rt) "1");XAwuH sApAxAnakaH syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "apAxAnam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyA apAxAnaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl32 " ?k ?l crlf )
)
)
;==========================================================================
;grAmAw gawam rAmam SyAmaH paSyawi
;rl33
(defrule assign_apAxAna_kqw
(not (and (test (= (count-viBakwi sup 5) 0)) (test (= (count-viBakwi kqw 5) 0)) (test (= (count-viBakwi waxXiwa 5) 0))))
(test (> (count-list kqw apAxAna_XAwu_list.gdbm kqw_vb_rt) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w kqw))
(and (< ?s1:id ?w:id) (= ?s1:viBakwiH 5)
(eq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:kqw_vb_rt) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "apAxAnam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl33 " ?k ?l crlf )

)
)
;==========================================================================
;grAmawaH ganwum icaCanwam rAmam SyAmaH kaWAm kaWayawi
;rl34
(defrule assign_apAxAna_wasil
(test (eq (slot-val-match avywaxXiwa waxXiwa_prawyayaH wasil) TRUE))
(not (and (test (= (count-list wif apAxAna_XAwu_list.gdbm rt) 0))(test (= (count-list avykqw apAxAna_XAwu_list.gdbm rt) 0))(test (= (count-list kqw apAxAna_XAwu_list.gdbm kqw_vb_rt) 0))))
=>
(do-for-all-facts
((?s1 avywaxXiwa) (?w wif kqw avykqw));sarveByosvyayawaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwakqxanwAvyayakqxanweByaSca "?w" iwi.
(and 
(= (- ?w:id ?s1:id) 1)
(eq ?s1:waxXiwa_prawyayaH wasil)
(or (eq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:rt) "1");XAwuH sApAxAnakaH syAw.
    (eq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:kqw_vb_rt) "1"));XAwuH sApAxAnakaH syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "apAxAnam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyA apAxAnaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl34 " ?k ?l crlf )
)
)
;========================================================================
;Added by sheetal
;jIviwasya hewoH api Xarmam na wyajew.
;rl35
(defrule assign_hewu_paFcamI
(not (and (test (= (count-viBakwi sup 5) 0)) (test (= (count-viBakwi waxXiwa 5) 0))))
;(not (and (test (= (count-list wif apAxAna_XAwu_list.gdbm rt) 0))(test (= (count-list avykqw apAxAna_XAwu_list.gdbm rt) 0))))
; This is commented, since it is possible that a verb which may take apAxAna, also takes a hewu, and in a given context it is only hewu which is expressed, and not apAxAna. e.g. mohAw ... gqhIwvA ...
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w wif avykqw kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaH "?s1" evaM "?w" wifanwAvyayakqxanweByaSca "?w" iwi.
; kqw is deleted from s1 by Amba. See the modified rule below.
(and (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
     (= ?s1:viBakwiH 5);sarveRu subAxiRu waxeva "?s1" yaw paFcamyAM varwawe.
;     (neq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:rt) "1")
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "hewuH"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl35 " ?k ?l crlf )
)
)
;========================================================================
;Added by Amba
;rl35a
(defrule assign_hewu_kqw_paFcamI
(test (> (count-viBakwi kqw 5) 0))
;(not (and (test (= (count-list wif apAxAna_XAwu_list.gdbm rt) 0))(test (= (count-list avykqw apAxAna_XAwu_list.gdbm rt) 0))))
=>
(do-for-all-facts
((?s1 kqw) (?w wif avykqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaH "?s1" evaM "?w" wifanwAvyayakqxanweByaSca "?w" iwi.
(and (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.  
        (eq ?s1:kqw_prawyayaH lyut)

;This is added to stop assigning hewu to a Sawq+5
;mAwaH mama piwA kva Aswe
; Here mAwaH: mA+Sawq+5 is assigned hewu of Aswe.
; To stop it, lyut is added.
; If any other kqws are also possible, they are to be listed here.
     (= ?s1:viBakwiH 5);sarveRu subAxiRu waxeva "?s1" yaw paFcamyAM varwawe.
     (neq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:rt) "1")
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "hewuH"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl35 " ?k ?l crlf )
)
)
;========================================================================
;vqkRe sWiwam rAmam SyAmaH kaWAm kaWayawi
;rAmaH vqkRe vasawi
;grAme vasiwum rAmaH icCawi
;rl36
(defrule assign_aXikaraNa
;(or (test (> (count-viBakwi sup 7) 0)) (test (> (count-viBakwi kqw 7) 0)) (test (> (count-viBakwi waxXiwa 7) 0)));praxawwa-vAkye nyUnAwinyUnamekaM paxaM supkqwwaxXiwAnwaM sapwamyAmaswIwi nirIkRyawe.
; Removed kqw 7 to avoid unnecessary answers with sawi sapwamii in case of gacCawi
;But then yuxXe samAgawAH sanwi -: yuxXa is not marked as adhikarana.
; Therefore again kqw is included.
(not (and (test (= (count-viBakwi sup 7) 0))(test (= (count-viBakwi waxXiwa 7) 0))(test (= (count-viBakwi kqw 7) 0))))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif kqw avykqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe wifanwakqxanwAvyayakqxanweByaSca "?w" iwi.
(and (= ?s1:viBakwiH 7);sarveRu subAxiRu waxeva "?s1" yaw sapwamyAM varwawe. 
   (< ?s1:id ?w:id));vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "aXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyA aXikaraNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl36 " ?k ?l crlf )

)
)
;========================================================================
;Added by sheetal
;rl37
(defrule assign_kAlAXikaraNa
(not (and (test (= (count-viBakwi sup 7) 0))(test (= (count-viBakwi waxXiwa 7) 0))))
(not (and (test (= (count-facts wif) 0)) (test (= (count-facts kqw) 0)) (test (= (count-facts avykqw) 0))))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w wif kqw avykqw))
(and 
(or (= ?s1:viBakwiH 7)(= ?s1:viBakwiH 1))
; To ask Sheetal: How can s1 has 1 viBakwiH?
; Also this condition is not put in the defrule section above, so the rule may not get triggered with 1 viBhakwiH words.
(< ?s1:id ?w:id)
(or (eq (gdbm_lookup "kAlAXikaraNa.gdbm" ?s1:word) "1")
    (eq (gdbm_lookup "kAlAXikaraNa.gdbm" ?s1:rt) "1")
)
)
;(or (eq ?s1:rt prAramBa)(eq ?s1:rt rAwri)(eq ?s1:rt pUrva)))
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "kAlAXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl37 " ?k ?l crlf )
))

;========================================================================
;rAmaH SyAmasya gqham gacCawi
;rl38
(defrule assign_RaRTI_sambanXa
(not (and (test (= (count-viBakwi sup 6) 0)) (test (= (count-viBakwi kqw 6) 0)) (test (= (count-viBakwi waxXiwa 6) 0))))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa));sarveByaH supwaxXiwAnweByaH "?s1" evaM "?s2" iwi nAmnI xIyewe kqxanweByaSca "?s1" iwi.Added 'kqw' for "prakqwInAM hiwEH yukwam"
(and (= ?s1:viBakwiH 6);sarveRu subAxiRu waxeva "?s1" yaw RaRTyAM varwawe. 
     (= (- ?s2:id ?s1:id) 1) ;"?s1" paxaM "?s2" paxawaH ekena pUrvaM syAw.
; sarvanAmas can not have RaRTI sambanXa
;	(neq ?s2:rt asmax); xyUwa-Asakwasya me ... from Panchatantra
;	(neq ?s2:rt yuRmax)
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "RaRTIsambanXaH"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid ") " );"?s1" paxaM "?s2" paxena saha RaTyA saMbaXyawe.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl38 " ?k ?l crlf )

)
)
;========================================================================
;rAmeNa prajAyAH SAsanam kriyawe
;rl39
(defrule assign_kAraka_RaRTI
(not (and (test (= (count-viBakwi sup 6) 0)) (test (= (count-viBakwi kqw 6) 0)) (test (= (count-viBakwi waxXiwa 6) 0))))
(test (> (count-list kqw RaRTI_kqw_list.gdbm kqw_prawyayaH) 0));kqw-prawyayaH karwwqkarmaNyoH RaRTIM Xriyawa iwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?s2 kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaSca "?s1" evaM "?s2" iwi.
(and (= ?s1:viBakwiH 6);sarveRu subAxiRu waxeva "?s1" yaw RaRTyAM varwawe. 
     (< ?s1:id ?s2:id));vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
     (eq (gdbm_lookup "RaRTI_kqw_list.gdbm" ?s2:kqw_vb_rt) "1")

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid ") " );"?s1" paxaM "?s2" paxasya karwwA karma vA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl39 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid ") " );"?s1" paxaM "?s2" paxasya karwwA karma vA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl39 " ?k ?l crlf )
)
)
;===========================================================================
;grAmasya samIpe paSavaH caranwi.
;rl40
(defrule assign_upapaxa_verb_rel
(test (> (count-list avy upapaxa_verb_list.gdbm word) 0));avyaya-paxaM "upapaxa-sUcyAM" aswIwi nirakRyawe.
=>

(do-for-all-facts
((?a avy) (?s sup kqw waxXiwa) (?w wif kqw avykqw));sarveByosvyayeByaH "?a" iwi nAma xIyawe supkqwwaxXiwAnweByaH "?s" iwi wifanweByaSca "?w" iwi. 
(and
(= (- ?a:id ?s:id) 1);"?s" paxaM "?a" paxAx ekena pUrvaM syAw.
(<> ?s:id ?w:id);vAkye "?s" "?w"- uBayoH sWAne pqWak BavewAm. 
(< ?a:id ?w:id);vAkye "?a" "?w"- uBayoH sWAne pqWak BavewAm. 
(eq (gdbm_lookup "upapaxa_verb_list.gdbm" ?a:word) "1");"?a" paxaM "upapaxa-sUcyAM" syAw.
; In case of avyayas we take rt and not word, since normalisation takes place in rt
 (or
   (and (eq (gdbm_lookup "upapaxa_2_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 2));yaxi "?a" paxaM "upapaxa_1_sUcyAm" aswi cew "?s" paxasya viBakwirxviwIyA syAw.
   (and (eq (gdbm_lookup "upapaxa_3_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 3));yaxi "?a" paxaM "upapaxa_2_sUcyAm" aswi cew "?s" paxasya viBakwiH wqwIyA syAw.
   (and (eq (gdbm_lookup "upapaxa_4_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 4));yaxi "?a" paxaM "upapaxa_3_sUcyAm" aswi cew "?s" paxasya viBakwiScawurWI syAw.
   (and (eq (gdbm_lookup "upapaxa_5_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 5));yaxi "?a" paxaM "upapaxa_4_sUcyAm" aswi cew "?s" paxasya viBakwiH paFcamI syAw.
   (and (eq (gdbm_lookup "upapaxa_6_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 6));yaxi "?a" paxaM "upapaxa_5_sUcyAm" aswi cew "?s" paxasya viBakwiRRaRTI syAw.
   (and (eq (gdbm_lookup "upapaxa_7_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 7));yaxi "?a" paxaM "upapaxa_6_sUcyAm" aswi cew "?s" paxasya viBakwiH sapwamI syAw.
))
(bind ?k (gdbm_lookup "upapaxa_avy_verb_left_relation.gdbm" ?a:word));upapaxa-sambanXAyociwA safKyA "?k" iwyawasmin sWApyawe.

(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?a:id " " ?a:mid ") " );"?a" paxena saha "?s" paxasya "upapaxa-avyaya" saMbanXena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl40 " ?k ?l crlf )

(bind ?k (gdbm_lookup "upapaxa_avy_verb_right_relation.gdbm" ?a:word));upapaxa-sambanXAyociwA safKyA "?k" iwyawasmin sWApyawe.
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid ") " );"?w" kriyApaxena saha "?a" paxaM "upapaxa_avy_verb" saMbanXena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl40 " ?k ?l crlf )

)
)
;===========================================================================
;grAmam aBiwaH vqkRAH sanwi.
;rl41
(defrule assign_noun_upapaxa_verb_rel
(test (> (count-list sup upapaxa_verb_list.gdbm word) 0));subanwa-paxaM "upapaxa-sUcyAM" aswIwi nirakRyawe.
=>

(do-for-all-facts
((?us sup) (?s sup kqw waxXiwa) (?w wif));sarveByaH subanweByaH "?us" evaM "?s" iwi nAmnI xIyewe kqwwaxXiwAnweByaH "?s" iwi wifanweByaSca "?w" iwi. 
(and
(= (- ?us:id ?s:id) 1);"?s" paxaM "?us" paxAx ekena pUrvaM syAw.
(<> ?s:id ?w:id);vAkye "?s" "?w"- uBayoH sWAne pqWak BavewAm. 
(<> ?us:id ?w:id);vAkye "?us" "?w"- uBayoH sWAne pqWak BavewAm. 
(eq (gdbm_lookup "upapaxa_verb_list.gdbm" ?us:word) "1");"?us" paxaM "upapaxa-sUcyAM" syAw.
 (or
   (and (eq (gdbm_lookup "upapaxa_2_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 2));yaxi "?us" paxaM "upapaxa_1_sUcyAm" aswi cew "?s" paxasya viBakwirxviwIyA syAw.
   (and (eq (gdbm_lookup "upapaxa_3_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 3));yaxi "?us" paxaM "upapaxa_2_sUcyAm" aswi cew "?s" paxasya viBakwiH wqwIyA syAw.
   (and (eq (gdbm_lookup "upapaxa_4_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 4));yaxi "?us" paxaM "upapaxa_3_sUcyAm" aswi cew "?s" paxasya viBakwiScawurWI syAw.
   (and (eq (gdbm_lookup "upapaxa_5_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 5));yaxi "?us" paxaM "upapaxa_4_sUcyAm" aswi cew "?s" paxasya viBakwiH paFcamI syAw.
   (and (eq (gdbm_lookup "upapaxa_6_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 6));yaxi "?us" paxaM "upapaxa_5_sUcyAm" aswi cew "?s" paxasya viBakwiRRaRTI syAw.
   (and (eq (gdbm_lookup "upapaxa_7_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 7));yaxi "?us" paxaM "upapaxa_6_sUcyAm" aswi cew "?s" paxasya viBakwiH sapwamI syAw.
))
(bind ?k (gdbm_lookup "upapaxa_noun_verb_left_relation.gdbm" ?us:word));upapaxa-sambanXAyociwA safKyA "?k" iwyawasmin sWApyawe.
(if (eq ?k TRUE) then
(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?us:id " " ?us:mid ") " );"?us" paxena saha "?s" paxaM "upapaxa-avyaya" saMbanXena saMbaxXumarhawi. 
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl41 " ?k ?l crlf )

(bind ?k (gdbm_lookup "upapaxa_noun_verb_right_relation.gdbm" ?us:word));upapaxa-sambanXAyociwA safKyA "?k" iwyawasmin sWApyawe.
(printout bar "(" ?us:id " " ?us:mid " " ?k " " ?w:id " " ?w:mid ") " );"?w" paxena saha "?us" paxaM "noun_upapaxa_avy_verb" saMbanXena saMbaxXumarhawi. 
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl41 " ?k ?l crlf )
)
)
)
;===========================================================================
;rAmeNa saha sIwA vanam gacCawi.
;rl42
(defrule assign_upapaxa_noun_rel
(test (> (count-list avy upapaxa_noun_list.gdbm word) 0));avyaya-paxaM "upapaxa-sUcyAM" aswIwi nirakRyawe.
=>
(do-for-all-facts
((?a avy) (?s sup kqw waxXiwa) (?s1 sup kqw waxXiwa));sarveByosvyayeByaH "?a" iwi nAma xIyawe supkqwwaxXiwAnweByaH "?s" evaM "?s1" iwi. 
(and 
(= (- ?a:id ?s:id) 1);"?s" paxaM "?a" paxAx ekena pUrvaM syAw.
(<> ?s:id ?s1:id);vAkye "?s" "?s1"- uBayoH sWAne pqWak BavewAm. 
(<> ?s1:id ?a:id);vAkye "?s1" "?a"- uBayoH sWAne pqWak BavewAm.
(<> ?s1:viBakwiH 8);vAkye "?s1" "?a"- uBayoH sWAne pqWak BavewAm.
(eq (gdbm_lookup "upapaxa_noun_list.gdbm" ?a:rt) "1");"?a" paxaM "upapaxa-sUcyAM" syAw.
;(= (- ?s1:id ?a:id) 1) 
(or
   (and (eq (gdbm_lookup "upapaxa_2_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 2));yaxi "?a" paxaM "upapaxa_1_sUcyAm" aswi cew "?s" paxasya viBakwirxviwIyA syAw.
   (and (eq (gdbm_lookup "upapaxa_3_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 3));yaxi "?a" paxaM "upapaxa_2_sUcyAm" aswi cew "?s" paxasya viBakwiH wqwIyA syAw.
   (and (eq (gdbm_lookup "upapaxa_4_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 4));yaxi "?a" paxaM "upapaxa_3_sUcyAm" aswi cew "?s" paxasya viBakwiScawurWI syAw.
   (and (eq (gdbm_lookup "upapaxa_5_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 5));yaxi "?a" paxaM "upapaxa_4_sUcyAm" aswi cew "?s" paxasya viBakwiH paFcamI syAw.
   (and (eq (gdbm_lookup "upapaxa_6_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 6));yaxi "?a" paxaM "upapaxa_5_sUcyAm" aswi cew "?s" paxasya viBakwiRRaRTI syAw.
   (and (eq (gdbm_lookup "upapaxa_7_list.gdbm" ?a:word) "1") (= ?s:viBakwiH 7));yaxi "?a" paxaM "upapaxa_6_sUcyAm" aswi cew "?s" paxasya viBakwiH sapwamI syAw.
)
)
(bind ?k (gdbm_lookup "upapaxa_avy_noun_left_relation.gdbm" ?a:word));upapaxa-sambanXAyociwA safKyA "?k" iwyawasmin sWApyawe.
(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?a:id " " ?a:mid ") " );"?a" paxena saha "?s" paxaM "upapaxa_avy" saMbanXena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl42 " ?k ?l crlf )

(bind ?k (gdbm_lookup "upapaxa_avy_noun_right_relation.gdbm" ?a:rt));upapaxa-sambanXAyociwA safKyA "?k" iwyawasmin sWApyawe.
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s1:id " " ?s1:mid ") " );"?s1" paxena saha "?a" paxaM "upapaxa_avy_noun" saMbanXena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl42 " ?k ?l crlf )

)
)
;===========================================================================
;rAmeNa samAnaH lakRmaNaH xqSyawe.
;wyAge Xanaxena samam rAmam xaSaraWaH smarawi.
;lakRmaNaH rAmeNa saxqSaH xqSyawe.
;rl43
(defrule assign_noun_upapaxa_noun_rel
(not (and (test (= (count-list sup upapaxa_noun_list.gdbm word) 0));subanwa-paxaM "upapaxa-sUcyAM" aswIwi nirakRyawe.
   (test (= (count-list kqw upapaxa_noun_list.gdbm word) 0));kqxanwa-paxaM "upapaxa-sUcyAM" aswIwi nirakRyawe.
))
=>

(do-for-all-facts
((?us sup kqw) (?s sup kqw waxXiwa) (?s1 sup kqw waxXiwa));sarveByaH supkqxanweByaH "?us" "?s" evaM "?s1" iwi nAmAni xIyanwe waxXiweByaSca "?s" evaM "?s1" iwi. 
; us: noun_upapaxa, e.g. saxqSaH
; lagnaH is a kqw, hence kqw is added in us
(and 
(= (- ?us:id ?s:id) 1);"?s" paxaM "?us" paxAx ekena pUrvaM syAw.
(<> ?us:id ?s1:id);vAkye "?us" "?s1"- uBayoH sWAne pqWak BavewAm. 
(<> ?s1:id ?s:id);vAkye "?s1" "?s"- uBayoH sWAne pqWak BavewAm.
(= ?s1:viBakwiH ?us:viBakwiH); vAkye "?us" "?s1"- uBayorviBakwI samAne syAwAm.
(eq ?s1:vacanam ?us:vacanam);"?s1" "?us" - uBayoH vacane samAne syAwAm. 
(or
(eq ?s1:lifgam ?us:lifgam);"?s1" "?us" - uBayoH lifge samAne syAwAm. 
(eq ?s1:rt yuRmax);"?s1" paxasya prAwipaxikaM "yuRmax" syAw.
(eq ?s1:rt asmax);"?s1" paxasya prAwipaxikaM "asmax" syAw.
(eq ?us:rt yuRmax);"?us" paxasya prAwipaxikaM "yuRmax" syAw.
(eq ?us:rt asmax);"?us" paxasya prAwipaxikaM "asmax" syAw.
)
(or
   (and (eq (gdbm_lookup "upapaxa_2_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 2));yaxi "?us" paxaM "upapaxa_1_sUcyAm" aswi cew "?s" paxasya viBakwirxviwIyA syAw.
   (and (eq (gdbm_lookup "upapaxa_3_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 3));yaxi "?us" paxaM "upapaxa_1_sUcyAm" aswi cew "?s" paxasya viBakwiH wqwIyA syAw.
   (and (eq (gdbm_lookup "upapaxa_4_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 4));yaxi "?us" paxaM "upapaxa_1_sUcyAm" aswi cew "?s" paxasya viBakwiScawurWI syAw.
   (and (eq (gdbm_lookup "upapaxa_5_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 5));yaxi "?us" paxaM "upapaxa_1_sUcyAm" aswi cew "?s" paxasya viBakwiH paFcamI syAw.
   (and (eq (gdbm_lookup "upapaxa_6_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 6));yaxi "?us" paxaM "upapaxa_1_sUcyAm" aswi cew "?s" paxasya viBakwiRRaRTI syAw.
   (and (eq (gdbm_lookup "upapaxa_7_list.gdbm" ?us:word) "1") (= ?s:viBakwiH 7));yaxi "?us" paxaM "upapaxa_1_sUcyAm" aswi cew "?s" paxasya viBakwiH sapwamI syAw.
)
(eq (gdbm_lookup "upapaxa_noun_list.gdbm" ?us:word) "1")
)
(bind ?k (gdbm_lookup "upapaxa_noun_noun_left_relation.gdbm" ?us:word));upapaxa-sambanXAyociwA safKyA "?k" iwyawasmin sWApyawe.
(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?us:id " " ?us:mid ") " );"us" paxena saha "?s" paxaM "upapaxa_noun" saMbanXena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl43 " ?k ?l crlf )
(bind ?k (gdbm_lookup "upapaxa_noun_noun_right_relation.gdbm" ?us:rt));upapaxa-sambanXAyociwA safKyA "?k" iwyawasmin sWApyawe.
(printout bar "(" ?us:id " " ?us:mid " " ?k " " ?s1:id " " ?s1:mid ") " );"?s1" paxena saha "?us" paxaM "upapaxa_noun_noun" saMbanXena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl43 " ?k ?l crlf )
)
)

;===========================================================================
;grAmam gacCanwam rAmam SyAmaH paSyawi.
;rAmeNa pawrasya paTanam sunxaram kaWyawe.
;rl44
(defrule assign_kqw_viSeRaNa
(test (> (count-facts kqw) 0))
;(not (test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0)))
;(test (not (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0)))
=>
(do-for-all-facts
((?s1 kqw) (?s2 sup kqw waxXiwa));sarveByaH supwaxXiwAnweByaH "?s2" iwi nAma xIyawe kqxanweByaSca "?s1" evaM "?s2" iwi. 
(and 
(< ?s1:id ?s2:id);"?s1" paxaM "?s2" paxawaH pUrvaM syAw.
;(= (- ?s2:id ?s1:id) 1); Counter example: wava XImawA SiRyeNa xrupaxa-puwreNa vyUDAm  ewAm mahawIm camUm paSya see *pANdu-puwrANAm* in between the viSeRanas. 
(= ?s1:viBakwiH ?s2:viBakwiH);uBayorviBakwI samAne syAwAm. 
(neq ?s1:word ?s2:word)
(eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - uBayoH vacane samAne syAwAm. 
(or (eq ?s1:lifgam ?s2:lifgam);"?s1" "?s2" - uBayoH lifge samAne syAwAm.
    (eq ?s2:rt asmax)
    (eq ?s2:rt yuRmax)
)
; This should be generalise further to handle any sarvanAma.
; pronouns can not have viSeRaNas.

      (neq ?s2:rt kim)
; pronouns can have viSeRaNas. 'kim' can't have a viSeRaNa.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "viSeRaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid " ) " );"?s1" paxaM "?s2" paxasya viSeRaNaM Baviwumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl44 " ?k ?l crlf )

)
)
;===========================================================================
;Added by sheetal modified by Pavan
; Pavan has added SAnac as well. It is OK. iwi Amba
;rl45
;rAmaH grAmam gacCan wqNam spqSawi.
(defrule assign_samAnakAlikawvam
(test (> (count-viBakwi kqw 1) 0))
(or (test (eq (slot-val-match kqw kqw_prawyayaH Sawq) TRUE))
    (test (eq (slot-val-match kqw kqw_prawyayaH SAnac) TRUE))
)
=>
(do-for-all-facts
((?s2 kqw)(?w wif kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaH "?s1" evaM "?s2" iwi wifanweByaSca "?w" iwi. 
(and 
	(or (eq ?s2:kqw_prawyayaH Sawq);kqw-prawyayaH "Sawq" syAw.
	    (eq ?s2:kqw_prawyayaH SAnac)
        )
	(< ?s2:id ?w:id);vAkye "?s2" "?w"- uBayoH sWAne pqWak BavewAm
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samAnakAlaH"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?w" paxena saha" ?s2" paxaM samAnakAlInawvena yokwumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl45 " ?k ?l crlf )

)
)
;=============================================================================
; 
;rl46
(defrule assign_noun_viSeRaNa
(not (and (test (= (count-facts sup) 0)) (test (= (count-facts kqw) 0))(test (= (count-facts waxXiwa) 0))))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?s2 sup waxXiwa kqw));sarveByaH supwaxXiwAnweByaH "?s1" "?s2" iwi nAmnI xIyewe. 
; kqw is added to account for (by AMBA)
;wam hasanwam vilokya sarve swabXAH jAwAH.
(and 
(< ?s1:id ?s2:id);"?s1" paxaM "?s2" paxawaH pUrvaM syAw.
;(or 
 ;(= (- ?s2:id ?s1:id) 2)
 ;(= (- ?s2:id ?s1:id) 1)
;); it can be 1 or 2, in case there is a shashti rel in between. In fact there can be any no of words in between when a kqw is used as a wif. 'saH gqham gawvA snAnam kqwvA pATaSAlAm AgawaH.'
(= ?s1:viBakwiH ?s2:viBakwiH);uBayoHviBakwI samAne syAwAm. 
(eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - uBayoH vacane samAne syAwAm.
(neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1")
(neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s2:word) "1");yaH gAyawrI-manwram niwyam na japawi.
(or 
(eq ?s1:lifgam ?s2:lifgam);"?s1" "?s2" - uBayoH lifge samAne syAwAm.
;     (eq ?s1:rt yuRmax); How can s1 be a sarvanAma? -- Amba 
;     (eq ?s1:rt asmax)
     (eq ?s2:rt yuRmax); -- sunxaraH aham ... is possible, So s2 can be a viSeRaNam
     (eq ?s2:rt asmax)
)
;(and (neq ?s2:rt yuRmax); yuRmax or asmax can not take any viSeRaNas
; This should be generalised further to take any sarvanAma.
;    (neq ?s2:rt asmax); asmax can take viSeRaNas
; e.g. kArpaNya-xoRa-upahawa-svaBAvaH Xarma-sammUDa-cewAH aham (from BhG 2.7)
(and  (neq ?s2:rt yaw)
    (neq ?s2:rt waw)
)
(neq ?s1:word ?s2:word)
)


(bind ?k (gdbm_lookup "kAraka_num.gdbm" "viSeRaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid " ) " );"?s1" paxaM "?s2" paxasya viSeRaNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl46 " ?k ?l crlf )

))
;======================================================================
;Added by sheetal
;
;rl46a
(defrule assign_avy_viSeRaNa
(or (test (eq (slot-val-match avy rt awIva) TRUE))
    (test (eq (slot-val-match avy rt kimapi) TRUE))
)
=>
(do-for-all-facts
((?s sup kqw waxXiwa) (?a avy))
(and 
(= (- ?s:id ?a:id) 1)
(or (eq ?a:rt awIva)
    (eq ?a:rt kimapi))
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "viSeRaNam"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s:id " " ?s:mid " ) " );"?s1" paxaM "?s2" paxasya viSeRaNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl46a " ?k ?l crlf )

))
;======================================================================
;rl47
; Test sentences:
;saH(S2) SvewaH(S1) aswi(W).
;vexAH pramANam sanwi.
;vAsaH a-niyawam Bavawi
;neharO asya prawikriyA kA AsIw.
(defrule assign_noun_samAnAXikaraNa
(not (and (test (= (count-viBakwi sup 1) 0))(test (= (count-viBakwi kqw 1) 0))(test (= (count-viBakwi waxXiwa 1) 0))))
(test (> (count-list wif BU_as_vixyawe_list.gdbm rt) 0))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?s2 sup kqw waxXiwa)(?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" evaM "?s2" iwi nAmnI xIyewe wifanweByaSca "?w" iwi. 
; kqw is deleted by Amba from s1. This is to treat 'aSmaBiH aSvasya gawiH kuNTiwA Bavawi' different from 'vaswram SuBram Bavawi'.
; In the 1st case, if gawiH and kuNTiwA are treated as karwq/karwqsamAnAXikaraNam, the relation of aSmaBiH with kuNTiwA will cross the relation between gawiH and Bavawi. In general any kqw in S1 position can have its arguments which may be to the left of S2. So we mark this as gawiH is the karwA of kuNTiwA and kuNTiwA as the karwA of Bavawi.
(and 
(> ?s1:id ?s2:id);"?s1" paxaM "?s2" paxawaH paScAw syAw.
(< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
(< (- ?w:id ?s1:id) 3); This is to allow the kriyAviSeRaNas
(= ?s1:viBakwiH 1) (= ?s2:viBakwiH 1);uBe paxe praWamAyAM syAwAm. 
(or (eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - uBayoH vacane samAne syAwAm.  
;We have to list/handle the exceptional cases such as: vexAH pramANam sanwi, separately.
    (and (eq ?s2:word vexAH)
         (eq ?s1:word pramANam)
    )
)
(eq ?w:vacanam ?s2:vacanam);"?s1" "?w" - uBayoH vacane samAne syAwAm.

(or 
    (and 
         (eq ?w:puruRaH pra);wifanwaM praWama-puruRe syAw. 
         (eq ?s1:lifgam ?s2:lifgam);
    )
    (and (eq ?w:puruRaH ma) (eq ?s2:rt yuRmax));yaxi wifanwaM maXyama-puruRe warhi "?s2"-paxasya prAwipaxikaM "yuRmax" syAw. 
    (and (eq ?w:puruRaH u) (eq ?s2:rt asmax));yaxi wifanwaM uwwama-puruRe warhi "?s2"-paxasya prAwipaxikaM "asmax" syAw.
    (and (eq ?w:puruRaH pra) (eq ?s2:word vexAH))
    (and (eq ?w:puruRaH pra) (eq ?s2:word vAsaH))
 )
(eq (gdbm_lookup "BU_as_vixyawe_list.gdbm" ?w:rt) "1");XAwurBvAxi-sUcyAM vixyewa.
(eq (gdbm_lookup "viXeya_viSeRaNa_list.gdbm" ?s1:rt) "1")
);

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karwwA-samAnAXikaraNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl47 " ?k ?l crlf )

))
;======================================================================
;rl47a
; Test sentences:
;saH SvewaH jAwaH.
(defrule assign_noun_samAnAXikaraNa1
(test (> (count-viBakwi sup 1) 0))
(test (> (count-list kqw BU_as_vixyawe_list.gdbm kqw_vb_rt) 0))
(not (and (test (= (count-viBakwi sup 1) 0))(test (= (count-viBakwi kqw 1) 0))(test (= (count-viBakwi waxXiwa 1) 0))))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa)(?w kqw));sarveByaH supkqwwaxXiwAnweByaH "?s1" evaM "?s2" iwi nAmnI xIyewe wifanweByaSca "?w" iwi. 
(and 
(> ?s1:id ?s2:id);"?s1" paxaM "?s2" paxawaH paScAw syAw.
(< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
(< (- ?w:id ?s1:id) 3) ;vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
(= ?s1:viBakwiH 1) (= ?s2:viBakwiH 1);uBe paxe praWamAyAM syAwAm. 
(eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - uBayoH vacane samAne syAwAm.  
;We have to list/handle the exceptional cases such as: vexAH pramANam sanwi, separately.
(eq ?w:vacanam ?s2:vacanam);"?s1" "?w" - uBayoH vacane samAne syAwAm.

(neq ?s2:rt kim) ;Added for : neharO asya kA prawikriyA AsIw.
(eq (gdbm_lookup "BU_as_vixyawe_list.gdbm" ?w:kqw_vb_rt) "1")) ;XAwurBvAxi-sUcyAM vixyewa.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karwwA-samAnAXikaraNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl47a " ?k ?l crlf )

))
;=========================================================================
;=========================================================================
;Added by sheetal
;saH api paramAwmA iva pUrNaH Baviwum icCawi.
;rl47b
(defrule assign_noun_samAnAXikaraNa_with_iR2_karwari
(test (> (count-list avykqw BU_as_vixyawe_list.gdbm rt) 0))
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
(test (eq (slot-val-match wif rt iR2) TRUE))
(test (eq (slot-val-match wif prayogaH karwari) TRUE))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?s2 sup kqw waxXiwa)(?a avykqw)(?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" evaM "?s2" iwi nAmnI xIyewe wifanweByaSca "?w" iwi. 
(and
(> ?s2:id ?s1:id)
(= (- ?a:id ?s2:id) 1)
(= (- ?w:id ?a:id) 1)
(eq ?s1:viBakwiH ?s2:viBakwiH)
(eq ?s1:vacanam ?s2:vacanam) 
(eq ?a:kqw_prawyayaH wumun)
(eq ?w:rt iR2)
(eq ?w:prayogaH karwari)
(eq (gdbm_lookup "BU_as_vixyawe_list.gdbm" ?a:rt) "1"));XAwurBvAxi-sUcyAM vixyewa.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " );"?s1" paxaM "?w" paxasya karwwA-samAnAXikaraNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl47b " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karwwA-samAnAXikaraNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl47b " ?k ?l crlf )

))
;==========================================================================
;Added by sheetal
;wena api paramAwmA iva pUrNaH Baviwum iRyawe.
;rl47c
(defrule assign_noun_samAnAXikaraNa_with_iR2_karmaNi
(test (> (count-list avykqw BU_as_vixyawe_list.gdbm rt) 0))
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
(test (eq (slot-val-match wif rt iR2) TRUE))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?s2 sup kqw waxXiwa)(?a avykqw)(?w wif));sarveByaH supkqwwaxXiwAnweByaH "?s1" evaM "?s2" iwi nAmnI xIyewe wifanweByaSca "?w" iwi. 
(and
(> ?s2:id ?s1:id)
(= (- ?a:id ?s2:id) 1)
(= (- ?w:id ?a:id) 1)
(= ?s1:viBakwiH 3) 
(= ?s2:viBakwiH 1)
(eq ?a:kqw_prawyayaH wumun)
(eq ?w:rt iR2)
(eq ?w:prayogaH karmaNi)
(eq (gdbm_lookup "BU_as_vixyawe_list.gdbm" ?a:rt) "1"))
 
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " );"?s1" paxaM "?w" paxasya karwwA-samAnAXikaraNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl47c " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karwwA-samAnAXikaraNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl47c " ?k ?l crlf )
))
;==========================================================================
;Added by sheetal
;kAryam samyak eva aswi.
;rAmasya kaWanam kim AsIw.
;rl47a
(defrule assign_avy_karwq_samAnAXikaraNa
(test (> (count-list wif BU_as_vixyawe_list.gdbm rt) 0))
(test (> (count-facts avy) 0))
(not (and (test (= (count-facts sup) 0))(test (= (count-facts kqw) 0))(test (= (count-facts waxXiwa) 0))))

=>
(do-for-all-facts
((?s1 avy) (?s2 sup kqw waxXiwa)(?w wif))
(and 
(> ?s1:id ?s2:id);"?s1" paxaM "?s2" paxawaH paScAw syAw.
(< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
(< ?s2:id ?w:id)
;(or (eq ?s1:word samyak)(eq ?s1:word kim)) ; kim is removed by Amba, since kim is a noun
(eq ?s1:word samyak)
(eq (gdbm_lookup "BU_as_vixyawe_list.gdbm" ?w:rt) "1"))
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karwwA-samAnAXikaraNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl47a " ?k ?l crlf )
))
;======================================================================
;Added by sheetal.
;rl48
; 
;karma_samAnAXikaraNa -> vikArya_karma
(defrule assign_karma_samAnAXikaraNa_karwari

(or (test (> (count-list wif kq_gaNa_Axi_list.gdbm rt) 0))(test (> (count-list avykqw kq_gaNa_Axi_list.gdbm rt) 0)))
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa)(?w wif avykqw));sarveByaH supkqwwaxXiwAnweByaH "?s1" evaM "?s2" iwi nAmnI xIyewe wifanweByaSca "?w" iwi. 
(and
(> ?s1:id ?s2:id);"?s1" paxaM "?s2" paxawaH paScAw syAw.
(< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
;(< ?s2:id ?w:id);vAkye "?s2" "?w"- uBayoH sWAne pqWak BavewAm. 
(= ?s1:viBakwiH 2)(= ?s2:viBakwiH 2)
(neq ?s2:rt kim); Added for : vqkRAH kam vArwAlApam kurvanwi sma.
(eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - uBayoH vacane samAne syAwAm.
(eq ?s1:lifgam ?s2:lifgam);"?s1" "?s2" - uBayoH lifge samAne syAwAm.
(eq (gdbm_lookup "kq_gaNa_Axi_list.gdbm" ?w:rt) "1"))


(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karma-samAnAXikaraNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl48 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "vikAryakarma"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karma-samAnAXikaraNaM saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl48 " ?k ?l crlf )


))
;==========================================================================
;Added by sheetal.
;rl49
;xuRtEH mOnam xEnyam manyawe.
; priyavAxinAm priyavAxiwvam xEnyam gaNyawe SaTEH.
(defrule assign_karma_samAnAXikaraNa_karmaNi
(test (> (count-list wif kq_gaNa_Axi_list.gdbm rt) 0))
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi kqw 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa)(?w wif))
(and
(> ?s1:id ?s2:id) 
(= (- ?w:id ?s1:id) 1) 
(< ?s2:id ?w:id)
(eq ?s1:vacanam ?s2:vacanam)
(= ?s1:viBakwiH 1) (= ?s2:viBakwiH 1)
(eq ?s1:lifgam ?s2:lifgam) 
(eq ?w:prayogaH karmaNi)

(eq (gdbm_lookup "kq_gaNa_Axi_list.gdbm" ?w:rt) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karmasamAnAXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl49 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl49 " ?k ?l crlf )


))

;========================================================================

;rAmaH puswakam paTiwum gqham gacCawi
;rAmaH xugXam pIwvA vanam gacCawi

;rl50
(defrule assign_karma_avykqxanwa
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
;(or (test (> (count-viBakwi sup 2) 0)) (test (> (count-viBakwi kqw 2) 0)) (test (> (count-viBakwi waxXiwa 2) 0)));praxawwa-vAkye nyUnAwinyUnamekaM paxaM supkqwwaxXiwAnwaM xviwIyAyAmaswIwi nirIkRyawe.
(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0));kqw-prawyayosvyayakqwsUcyAM syAw.
(test (> (count-list avykqw sakarmaka_XAwu_list.gdbm rt) 0));XAwuH sakarmakaH syAw.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w avykqw));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe avyayakqxanweByaSca "?w" iwi. 
(and (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe.
   (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
   (neq ?w:kqw_prawyayaH wumun) 
(eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" ?w:rt) "1");XAwuH sakarmakaH syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl50 " ?k ?l crlf )
;(printout bar "(-1 -1 0 " ?w:id " " ?w:mid " ) " );praxawwa-vAkye "?w" paxasya kospi karwwA na saMBavawi.
;(printout bar "#rl50 " ?k 0 crlf )

))
;==========================================================================

;saH prasannaH BUwvA mAwaram avaxaw.

;rl50a
(defrule assign_kawq_samAnAXikaraNa_BUwvA
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi kqw 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match avykqw word BUwvA) TRUE))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w avykqw));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe avyayakqxanweByaSca "?w" iwi. 
(and (= ?s1:viBakwiH 1);
(or 
(= (- ?w:id ?s1:id) 1) 
(= (- ?w:id ?s1:id) 2) 
)
;   (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
(eq ?w:word BUwvA);
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl50a " ?k ?l crlf )
;(printout bar "(-1 -1 0 " ?w:id " " ?w:mid " ) " );praxawwa-vAkye "?w" paxasya kospi karwwA na saMBavawi.
;(printout bar "#rl50a " ?k 0 crlf )

))
;===================================================================================================================
;Added by sheetal
;rl51
(defrule assign_karma_of_wumuna_no_iR2
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0));kqw-prawyayosvyayakqwsUcyAM syAw.
(test (> (count-list avykqw sakarmaka_XAwu_list.gdbm rt) 0));XAwuH sakarmakaH syAw.
;(and (test (neq (slot-val-match wif rt iR2) TRUE))
;   (test (neq (slot-val-match sup rt icCuka) TRUE))
;   (test (neq (slot-val-match kqw kqw_vb_rt iR2) TRUE)))
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w avykqw));sarveByaH supkqwwaxXiwAnweByaH "?s1" iwi nAma xIyawe avyayakqxanweByaSca "?w" iwi. 
(and (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe.
     (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
     (eq ?w:kqw_prawyayaH wumun)
(eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" ?w:rt) "1");XAwuH sakarmakaH syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl51 " ?k ?l crlf )
;(printout bar "(-1 -1 0 " ?w:id " " ?w:mid " ) " );praxawwa-vAkye "?w" paxasya kospi karwwA na saMBavawi.
;(printout bar "#rl51 " ?k 0 crlf )

))
;==========================================================================
;Added by sheetal
;anyasya aniRtam karwum icCukaH janaH kasya upekRAm karowi.
;rl53
(defrule assign_karma_to_icCuka_follows_wumunanwa
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
(test (eq (slot-val-match sup rt icCuka) TRUE))
(not (and (test (= (count-viBakwi sup 2) 0))(test (= (count-viBakwi waxXiwa 2) 0))))
=>
(do-for-all-facts
((?s2 sup)(?s1 avykqw )(?w sup))
(and
(< ?s2:id ?s1:id)
(= (- ?w:id ?s1:id) 1)
(= ?s2:viBakwiH 2)
(eq ?w:rt icCuka)
(eq ?s1:kqw_prawyayaH wumun))
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl53 " ?k ?l crlf )
))
;==============================================================================================
;rAmaH xugXam pIwvA vanam gacCawi
;rl54
(defrule assign_avykqw_pUrvakAlInawva
(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0));kqw-prawyayosvyayakqwsUcyAM aswIwi nirIkRyawe.
(not (and (test (neq (slot-val-match avykqw kqw_prawyayaH kwvA) TRUE ))
     (test (neq (slot-val-match avykqw kqw_prawyayaH lyap) TRUE )))
)
=>
(do-for-all-facts
((?w avykqw) (?a avykqw));sarveByaH wifanweByaH "?w" iwi nAma xIyawe avyayakqxanweByaSca "?w" evaM "?a" iwi. 
(and 
    (or 
      (eq ?a:kqw_prawyayaH kwvA);kqw kwvA syAw. 
      (eq ?a:kqw_prawyayaH lyap);kqw lyap syAw.
    )
    (> ?w:id ?a:id);vAkye "?w" paxaM "?a" paxawaH paScAw Bavew.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "pUrvakAlaH"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" paxaM "?w" paxena saha pUrvakAlInawvena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl54 " ?k ?l crlf )
)
)
;==============================================================================================
;rAmaH xugXam pIwvA vanam gacCawi
;rl54
(defrule assign_wif_pUrvakAlInawva
;(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0));kqw-prawyayosvyayakqwsUcyAM aswIwi nirIkRyawe.
(not (and (test (neq (slot-val-match avykqw kqw_prawyayaH kwvA) TRUE ))
     (test (neq (slot-val-match avykqw kqw_prawyayaH lyap) TRUE )))
)
=>
(do-for-all-facts
((?w wif) (?a avykqw));sarveByaH wifanweByaH "?w" iwi nAma xIyawe avyayakqxanweByaSca "?w" evaM "?a" iwi. 
(and 
    (or 
      (eq ?a:kqw_prawyayaH kwvA);kqw kwvA syAw. 
      (eq ?a:kqw_prawyayaH lyap);kqw lyap syAw.
    )
    (> ?w:id ?a:id);vAkye "?w" paxaM "?a" paxawaH paScAw Bavew.
;    (or 
;       (neq ?w:rt as2); kwvA can not relate to as2, e.g. gawvA aswi is not possible 
;       (and (eq ?w:rt as2) (eq ?w:lakAraH viXilif))
;    )
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "pUrvakAlaH"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" paxaM "?w" paxena saha pUrvakAlInawvena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl54 " ?k ?l crlf )
)
)
;==============================================================================================
;rAmaH xugXam pIwvA vanam gacCawi
;rl54
(defrule assign_kqw_pUrvakAlInawva
(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0));kqw-prawyayosvyayakqwsUcyAM aswIwi nirIkRyawe.
(not (and (test (neq (slot-val-match avykqw kqw_prawyayaH kwvA) TRUE ))
     (test (neq (slot-val-match avykqw kqw_prawyayaH lyap) TRUE )))
)
=>
(do-for-all-facts
((?w kqw) (?a avykqw));sarveByaH wifanweByaH "?w" iwi nAma xIyawe avyayakqxanweByaSca "?w" evaM "?a" iwi. 
; w can not be kqw. It should only by avykqw
(and 
    (or 
      (eq ?a:kqw_prawyayaH kwvA);kqw kwvA syAw. 
      (eq ?a:kqw_prawyayaH lyap);kqw lyap syAw.
    )
    (> ?w:id ?a:id);vAkye "?w" paxaM "?a" paxawaH paScAw Bavew.
    (neq ?w:kqw_prawyayaH lyut)
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "pUrvakAlaH"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" paxaM "?w" paxena saha pUrvakAlInawvena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl54 " ?k ?l crlf )
)
)
;===============================================================================
;rAmaH puswakam paTiwum gqham gacCawi
;rl55
(defrule assign_prayojana
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
(test (neq (slot-val-match wif rt iR2) TRUE))
=>
(do-for-all-facts
((?w wif) (?a avykqw));sarveByaH wifanwakqxanweByaH "?w" iwi nAma xIyawe avyayakqxanweByaSca "?w" evaM "?a" iwi.

(and (eq ?a:kqw_prawyayaH wumun);kqw-prawyayaH wumun syAw. 
     (> ?w:id ?a:id);vAkye "?w" paxaM "?a" paxawaH paScAw Bavew.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" paxaM "?w" paxena saha prayojanawvena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl55 " ?k ?l crlf )

)
)
;==============================================================================================
;rAmaH puswakam paTiwum gacCanwam bAlakam paSyawi.
;rl55a
(defrule assign_prayojana_kqw
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
(test (neq (slot-val-match kqw kqw_vb_rt iR2) TRUE))
=>
(do-for-all-facts
((?w kqw) (?a avykqw));sarveByaH wifanwakqxanweByaH "?w" iwi nAma xIyawe avyayakqxanweByaSca "?w" evaM "?a" iwi.

(and (eq ?a:kqw_prawyayaH wumun);kqw-prawyayaH wumun syAw. 
     (> ?w:id ?a:id);vAkye "?w" paxaM "?a" paxawaH paScAw Bavew.
     (neq ?w:kqw_vb_rt iR2)
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" paxaM "?w" paxena saha prayojanawvena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl55a " ?k ?l crlf )

)
)
;===============================================================================
;rAmaH puswakam paTiwum ...wum bAakam paSyawi.
;rl55a
(defrule assign_prayojana_avykqw
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
=>
(do-for-all-facts
((?w avykqw) (?a avykqw));sarveByaH wifanwakqxanweByaH "?w" iwi nAma xIyawe avyayakqxanweByaSca "?w" evaM "?a" iwi.

(and (eq ?a:kqw_prawyayaH wumun);kqw-prawyayaH wumun syAw. 
     (> ?w:id ?a:id);vAkye "?w" paxaM "?a" paxawaH paScAw Bavew.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" paxaM "?w" paxena saha prayojanawvena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl55a " ?k ?l crlf )

)
)
;===============================================================================
;rAmaH puswakam paTiwum Saknowi.
;rl55a
(defrule assign_auxiliary
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
(test (> (count-list wif SakAxi_list.gdbm rt) 0)); SakXqS...
=>
(do-for-all-facts
((?w wif) (?a avykqw));sarveByaH wifanwakqxanweByaH "?w" iwi nAma xIyawe avyayakqxanweByaSca "?w" evaM "?a" iwi.

(and (eq ?a:kqw_prawyayaH wumun);kqw-prawyayaH wumun syAw. 
     (= (- ?w:id ?a:id) 1);vAkye "?w" paxaM "?a" paxawaH paScAw Bavew.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sahAyakakriyA"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" paxaM "?w" paxena saha prayojanawvena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl55a " ?k ?l crlf )

)
)
;==========================================================================
;rAmaH grAmam gacCan wqNam spqSawi.
;rl56
(defrule assign_karma_karwqkqxanwa
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (> (count-list kqw karwq_kqw_list.gdbm kqw_prawyayaH) 0));XAwuH karwwq-kqw-sUcyAmaswIwi nirIkRyawe.
(or (test (> (count-list kqw sakarmaka_XAwu_list.gdbm rt) 0));XAwuH sakarmakosswIwi nirIkRyawe.
    (test (> (count-list kqw sakarmaka_XAwu_list.gdbm kqw_vb_rt) 0)));XAwuH sakarmakosswIwi nirIkRyawe.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaSca "?s1" evaM "?w" iwi. 
(and (= ?s1:viBakwiH 2);sarveRu subAxiRu waxeva "?s1" yaw xviwIyA-viBakwO varwawe. 
     (< ?s1:id ?w:id);vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
(eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" ?w:kqw_vb_rt) "1");XAwuH sakarmakaH syAw.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karma saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl56 " ?k ?l crlf )
;(printout bar "(-1 -1 0 " ?w:id " " ?w:mid " ) ");praxawwa-vAkye "?w" paxasya kospi karwwA na saMBavawi.
;(printout bar "#rl56 " ?k 0 crlf )
))
;==========================================================================
;rAmeNa KAxiwam Palam maXuram AsIw
;haswena KAxiwam Palam maXuram AsIw
;rl57
(defrule assign_karwA_sakarmaka_karma_BAvakqxanwa
(not (and (test (< (count-list kqw karma_kqw_list.gdbm kqw_prawyayaH) 0))
          (test (< (count-list kqw BAva_kqw_list.gdbm kqw_prawyayaH) 0))
))
=>
(do-for-all-facts
((?s1 sup kqw) (?w kqw ));sarveByaH subanweByaH "?s1" iwi nAma xIyawe kqxanweByaSca "?s1" evaM "?w" iwi. 
(and (= ?s1:viBakwiH 3);sarveRu subAxiRu waxeva "?s1" yaw wqwIyA-viBakwO varwawe. 
     (< ?s1:id ?w:id); vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm.
(or
   (and  
        (eq (gdbm_lookup "karma_kqw_list.gdbm" ?w:kqw_prawyayaH) "1")
        (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" ?w:kqw_vb_rt) "1")
   )
   (eq (gdbm_lookup "BAva_kqw_list.gdbm" ?w:kqw_prawyayaH) "1")
)
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) ");"?s1" paxaM "?w" paxasya karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl57 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" paxaM "?w" paxasya karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl57 " ?k ?l crlf )
; For karma, there is just a samAnAXikaraNa relation, and the kAraka relation is not marked.
; TO BE ADDED: No gawyarWaka XAwus, if kwa and sakarmaka
))
;==========================================================================
;Added by sheetal
;xaSaraWaH prakqwInAM hiwEH yukwam/yokwuM rAmam EcCaw.
;rl
(defrule assign_sahArWa_for_yukwam_iwyAxi
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0))))
(or (test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE)))
=>
(do-for-all-facts
((?s1 sup kqw) (?w kqw avykqw ));sarveByaH subanweByaH "?s1" iwi nAma xIyawe kqxanweByaSca "?s1" evaM "?w" iwi. 
(and (= ?s1:viBakwiH 3);sarveRu subAxiRu waxeva "?s1" yaw wqwIyA-viBakwO varwawe. 
     (= (- ?w:id ?s1:id) 1)
     (or (eq ?w:word yokwuM)(and(eq ?w:rt yukwa)(eq ?w:kqw_prawyayaH kwa)))
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) ");"?s1" paxaM "?w" paxasya karwwA saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl57a " ?k ?l crlf )
))
;=====================================================================================
;mohanaH awra AgacCawi.
;rl58
(defrule assign_avy_verb
(test (> (count-list avy avy_verb_list.gdbm rt) 0));avyaya-paxam "avyaya-sUcyAM" aswIwi nirIkRyawe.
=>
(do-for-all-facts
((?a avy) (?w wif avykqw kqw));sarveByosvyayeByaH "?a" iwi nAma xIyawe wifanweByaSca "?w" iwi. 
(and
(< ?a:id ?w:id);vAkye "?a" "?w"- uBayoH sWAne pqWak BavewAm.
(neq ?a:rt api)(neq ?a:rt eva)(neq ?a:rt yaxA)(neq ?a:rt yaxi)(neq ?a:rt warhi)(neq ?a:rt yAvaw)(neq ?a:rt iwi)
(eq (gdbm_lookup "avy_verb_list.gdbm" ?a:rt) "1"));"?a" paxam "avyaya-sUcyAM" syAw.
(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt));avyaya-sambanXAyociwA safKyA "?k" iwyewasmin sWApyawe.
(printout bar "(" ?a:id " " ?a:mid " "  ?k " " ?w:id " " ?w:mid ") " );"?w" paxena saha "?a" paxaM "avyaya_relation_verb" saMbanXena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl58 " ?k ?l crlf )

)
)
;===============================================================================
;Added by sheetal
;puwraH janma-grahaNam akarow eva.
;rl
(defrule assign_verb_avy_rel
(or (test (eq (slot-val-match avy rt na) TRUE))(test (eq (slot-val-match avy rt eva) TRUE))(test (eq (slot-val-match avy rt api) TRUE))(test (eq (slot-val-match avy rt sma) TRUE)))
=>
(do-for-all-facts
((?a avy) (?w wif kqw avykqw));sarveByosvyayeByaH "?a" iwi nAma xIyawe wifanweByaSca "?w" iwi. 
(and
(= (- ?a:id ?w:id) 1) ;vAkye "?a" "?w"- uBayoH sWAne pqWak BavewAm. 
(or (eq ?a:rt na)(eq ?a:rt eva)(eq ?a:rt api)(eq ?a:rt sma))
(eq (gdbm_lookup "avy_verb_list.gdbm" ?a:rt) "1"));"?a" paxam "avyaya-sUcyAM" syAw.
(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt));avyaya-sambanXAyociwA safKyA "?k" iwyewasmin sWApyawe.
(printout bar "(" ?a:id " " ?a:mid " "  ?k " " ?w:id " " ?w:mid ") " );"?w" paxena saha "?a" paxaM "avyaya_relation_verb" saMbanXena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl58a " ?k ?l crlf )
)
)
;===========================================================================
;rAmaH eva vanam gacCawi.
;rl59
(defrule assign_avy_noun
(test (> (count-list avy avy_noun_list.gdbm word) 0));avyaya-paxam "avyaya-sUcyAM" aswIwi nirIkRyawe.
=>
(do-for-all-facts
((?a avy) (?s sup kqw waxXiwa));sarveByosvyayeByaH "?a" iwi nAma xIyawe supkqwwaxXiwAnweByaH "?s" iwi. 
(and
    (= (- ?a:id ?s:id) 1);"?s" paxaM "?a" paxAx ekena pUrvaM syAw.
    (neq ?a:word iva)
    (neq ?a:word ca)
    (neq ?a:word iwi)
(eq (gdbm_lookup "avy_noun_list.gdbm" ?a:rt) "1"));"?a" paxam "avyaya-sUcyAM" syAw.
(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt));avyaya-sambanXAyociwA safKyA "?k" iwyewasmin sWApyawe.

(printout bar "(" ?a:id " " ?a:mid " "  ?k " " ?s:id " " ?s:mid ") " );"?s" paxena saha "?a" paxaM "avyaya_relation_noun" saMbanXena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl59 " ?k ?l crlf )

)
)
;===========================================================================
;Added by sheetal modified by Pavan
;Pavan says: s1 and s2 need not have the same vibhkati. 
; Canxra iva muKam paSya. Here Canxra and muKam do not have the same viBakwi
;paramAwmA iva pUrNaH Baviwum icCawi. ???
;rAmasya iva kqRNasya gAvaH sanwi.
;rl63
(defrule assign_upamAnam_iva
(test (eq (slot-val-match avy word iva) TRUE))
=>
(do-for-all-facts
((?a avy) (?s1 sup kqw) (?s2 sup kqw));sarveByosvyayeByaH "?a" iwi nAma xIyawe supkqwwaxXiwAnweByaH "?s" iwi. 
(and
(= (- ?a:id ?s1:id) 1);"?s" paxaM "?a" paxAx ekena pUrvaM syAw.
(<> ?a:id ?s1:id)
(eq ?a:word iva)
(<> ?s1:id ?s2:id)
;(= ?s1:viBakwiH ?s2:viBakwiH)
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl63b " ?k ?l crlf )

(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt))
(printout bar "(" ?a:id " " ?a:mid " "  ?k " "  ?s2:id " " ?s2:mid ") " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl63b " ?k ?l crlf )
))
;===============================================================================
;kAryam samyak eva aswi.
;rl60
(defrule assign_avy_avy
(test (> (count-list avy avy_avy_list.gdbm word) 0));avyaya-paxam "avyaya-sUcyAM" aswIwi nirIkRyawe.
=>
(do-for-all-facts
((?a avy) (?b avy avykqw));sarveByosvyayeByaH "?a" evaM "?b" iwi nAmnI xIyewe. 
(and
(= (- ?a:id ?b:id) 1);"?b" paxaM "?a" paxAx ekena pUrvaM syAw. 
(eq (gdbm_lookup "avy_avy_list.gdbm" ?a:rt) "1"));"?a" paxam "avyaya-sUcyAM" syAw.
(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt));avyaya-sambanXAyociwA safKyA "?k" iwyewasmin sWApyawe.

(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?b:id " " ?b:mid ") " );"?b" paxena saha "?a" paxaM "avyaya_relation_avy" saMbanXena saMbaxXumarhawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl60a " ?k ?l crlf )

)
)
;===========================================================================
;Added by sheetal(15_09_10)
;rl61
;(defrule assign_sma
;(test (> (count-facts wif) 0))
;(test (eq (slot-val-match avy word sma) TRUE))
;=>
;(do-for-all-facts
;((?a avy) (?w wif))
;(and
;(= (- ?a:id ?w:id) 1)
;(eq ?a:word sma)
;)
;(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt))
;(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid ") " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rl61 " ?k ?l crlf )
;)
;)
;=============================================================================
;Added by sheetal(15_09_10)
;rl62
; Modified by Amba Feb 29 2012
; iwi after any noun or verb is related to the previous word by sambanXa relation
;Note the direction also. Now iwi is the head, and not the verb.
;(defrule assign_samApwi_sUcakam
(defrule assign_iwi
(not (and (test (= (count-facts wif) 0)) (test (= (count-facts sup) 0)) (test (= (count-facts avykqw) 0))))
(test (eq (slot-val-match avy word iwi) TRUE))
=>
(do-for-all-facts
((?a avy) (?w wif kqw avykqw sup))
(and
(= (- ?a:id ?w:id) 1)
(eq ?a:word iwi)
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
;(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid ") " )
(printout bar "(" ?w:id " " ?w:mid " " ?k " " ?a:id " " ?a:mid ") " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl62 " ?k ?l crlf )
)
)
;=============================================================================

;Added by sheetal 
;modified by Pavan; changed the name of the sambanXa to anuyogI.
;SrUyawAm iwi Amanwrya rAmaH avocaw.
;This change is not good.
;Earlier solution was better.
; Counter example:
;praBAwe aham rAjasaBAm gawvA kA vArwA iwi paSyAmi.
; Here iwi is marked as an anuyogi, so praBAwe is marked as a karma, This is wrong.
;iwi itself denotes a vaakya karma.
;rl63
; In view of the change in the previous rule, from this rule sambanXa is removed by Amba; 29 feb 2012
(defrule assign_rel_for_iwi
(not (and (test (= (count-facts wif) 0)) (test (= (count-facts avykqw) 0))))
(test (eq (slot-val-match avy word iwi) TRUE))
=>
(do-for-all-facts
((?a avy) (?w wif avykqw))
(and
;(= (- ?w:id ?a:id) 1)
(< ?a:id ?w:id) 
(eq ?a:word iwi)
(eq (gdbm_lookup "vAkyakarma_XAwu_list.gdbm" (fact-slot-value ?w rt)) "1") 
)
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))        
    (printout bar "(" ?a:id " " ?a:mid " "  ?k " "  ?w:id " " ?w:mid ") " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rl63A " ?k ?l crlf )
))
;===============================================================================

;Added by sheetal 
;modified by Pavan; changed the name of the sambanXa to anuyogI.
;SrUyawAm iwi Amanwrya rAmaH avocaw.
;This change is not good.
;Earlier solution was better.
; Counter example:
;praBAwe aham rAjasaBAm gawvA kA vArwA iwi paSyAmi.
; Here iwi is marked as an anuyogi, so praBAwe is marked as a karma, This is wrong.
;iwi itself denotes a vaakya karma.
;rl63
; In view of the change in the previous rule, from this rule sambanXa is removed by Amba; 29 feb 2012
(defrule assign_rel_for_iwi_kqw
(test (> (count-facts kqw) 0))
(test (eq (slot-val-match avy word iwi) TRUE))
=>
(do-for-all-facts
((?a avy) (?w kqw))
(and
;(= (- ?w:id ?a:id) 1)
(< ?a:id ?w:id) 
(eq ?a:word iwi)
(eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1") 
)
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))        
    (printout bar "(" ?a:id " " ?a:mid " "  ?k " "  ?w:id " " ?w:mid ") " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rl63A " ?k ?l crlf )
))
;===============================================================================
;Added by sheetal
;praWamam aham SqNomi aWa liKAmi.
;rla
(defrule assign_rel_for_aWa
(test (eq (slot-val-match avy word aWa) TRUE))
=>
(do-for-all-facts
((?a avy) (?w1 wif) (?w2 wif))
(and
(< ?a:id ?w2:id)
(> ?a:id ?w1:id)
(eq ?a:word aWa))

(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt))
(printout bar "(" ?a:id " " ?a:mid " "  ?k " "  ?w2:id " " ?w2:mid ") " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl63a " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI"))
(printout bar "(" ?w1:id " " ?w1:mid " "  ?k " "  ?a:id " " ?a:mid ") " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl63a " ?k ?l crlf )
))
;===============================================================================
;Added by sheetal
;mAnavociwa-karwavyam kena kena bAXiwam na Bavawi.
;rl64
(defrule assign_vIpsA
(test (> (count-facts sup) 1))

=>
(do-for-all-facts
((?s1 sup) (?s2 sup) (?w wif))
(and
(= (- ?s2:id ?s1:id) 1)
(eq ?s1:word ?s2:word)
(eq ?s1:lifgam ?s2:lifgam)
(eq ?s1:vacanam ?s2:vacanam)
(eq ?s1:rt ?s2:rt)
(eq ?s1:viBakwiH ?s2:viBakwiH)
(neq ?w:rt as2);paWikAH paWikAH eva Asan.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "vIpsA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl64 " ?k ?l crlf )
))
;===============================================================================
;Added by Amba
;saH vAram vAram mama gqham AgacCawi.
;rl64a
(defrule assign_vIpsA_avy
(test (> (count-facts avy) 1))

=>
(do-for-all-facts
((?s1 avy) (?s2 avy)(?w wif kqw))
(and
(= (- ?s2:id ?s1:id) 1)
(eq ?s1:word ?s2:word)
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "vIpsA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl64a " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "kriyAviSeRaNam"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl64a " ?k ?l crlf )
))
;===============================================================================
;Added by sheetal
;wsamE gurave namaH.
;rl
(defrule assign_rel_for_namaH_Axi
(or (test (eq (slot-val-match avy word namaH) TRUE))(test (eq (slot-val-match avy word svaswi) TRUE))(test (eq (slot-val-match avy word svaXA) TRUE))(test (eq (slot-val-match avy word svAhA) TRUE)))
(test (> (count-facts sup) 0))

=>
(do-for-all-facts
((?s sup) (?a avy))
(and
(= ?s:viBakwiH 4)
(or (eq ?a:word namaH)(eq ?a:word svaswi)(eq ?a:word svaXA)(eq ?a:word svAhA))
(= (- ?a:id ?s:id) 1))
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "upapaxasambanXaH"))
(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?a:id " " ?a:mid " ) " )
(printout bar "upapaxa_viBakwi" crlf )
))
;==================================================================================
;Added by sheetal
;wvam icCasi warhi aham BavawaH gqham AgacCAmi.
;vqRtiH BaviRyawi cew suBikRam BaviRyawi.
;rly1
(defrule assign_rel_warhi
(or (test (eq (slot-val-match avy word cew) TRUE))(test (eq (slot-val-match avy word warhi) TRUE)))
(test (neq (slot-val-match avy word yaxi) TRUE))

=>
(do-for-all-facts
((?a avy)(?w wif)(?w1 wif))
(and
(or (eq ?a:word warhi)(eq ?a:word cew))
(< ?w:id ?a:id)
(> ?w1:id ?a:id)
;(eq (gdbm_lookup "avy_verb_list.gdbm" ?a:rt) "1");"?a" paxam "avyaya-sUcyAM" syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w1:id " " ?w1:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rly1 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI"))
(printout bar "(" ?w:id " " ?w:mid " " ?k " " ?a:id " " ?a:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rly1 " ?k ?l crlf )
))
;==================================================================================
;Added by sheetal
;aham AgamiRyAmi yaxi BavAn apekRiwam sOlaByam viXAsyawi.
;rly2
(defrule assign_rel_yaxi
(test (eq (slot-val-match avy word yaxi) TRUE))
(and (test (eq (slot-val-match avy word cew) FALSE))(test (eq (slot-val-match avy word warhi) FALSE)))
=>
(do-for-all-facts
((?a avy)(?w wif)(?w1 wif))
(and
(eq ?a:word yaxi)
(< ?w:id ?a:id)
(> ?w1:id ?a:id)
;(eq (gdbm_lookup "avy_verb_list.gdbm" ?a:rt) "1");"?a" paxam "avyaya-sUcyAM" syAw.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI"))
(printout bar "(" ?w1:id " " ?w1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rly2 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rly2 " ?k ?l crlf )
))
;=====================================================================================
;Added by sheetal
;yaxi BavAn apekRiwam sOlaByam karowi warhi aham AgamiRyAmi.
;rly3
(defrule assign_rel_for_yaxi_warhi
(test (eq (slot-val-match avy word yaxi) TRUE))
(or (test (eq (slot-val-match avy word cew) TRUE))(test (eq (slot-val-match avy word warhi) TRUE)))
=>
(do-for-all-facts
((?yaxi avy)(?cew avy)(?yw wif)(?cw wif))
(and
(eq ?yaxi:word yaxi)
(or (eq ?cew:word cew)(eq ?cew:word warhi))
(< ?yw:id ?cew:id)
(> ?cw:id ?cew:id)
(> ?yw:id ?yaxi:id)
;(eq (gdbm_lookup "avy_verb_list.gdbm" ?yaxi:rt) "1")
;(eq (gdbm_lookup "avy_verb_list.gdbm" ?cew:rt) "1")
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?cew:id " " ?cew:mid " " ?k " " ?cw:id " " ?cw:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rly3 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI"))
(printout bar "(" ?yw:id " " ?yw:mid " " ?k " " ?yaxi:id " " ?yaxi:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rly3 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
(printout bar "(" ?yaxi:id " " ?yaxi:mid " " ?k " " ?cew:id " " ?cew:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rly3 " ?k ?l crlf )

))
;======================================================================================
;Added by sheetal
;yaxA meGaH varRawi waxA mayUraH nqwyawi.
;waxA mayUraH nqwyawi yaxA meGaH varRawi.
;rly1a
(defrule assign_rel_for_yaxA_waxA
(and (test (eq (slot-val-match avy word yaxA) TRUE))
     (or (test (eq (slot-val-match avy word waxA) TRUE))
         (test (eq (slot-val-match avy word waxAnIm) TRUE))
     )
)
=>
(do-for-all-facts
((?yaxA avy)(?waxA avy)(?yw wif kqw)(?ww wif kqw))
(and
(eq ?yaxA:word yaxA)
(or (eq ?waxA:word waxA) (eq ?waxA:word waxAnIm))
(<> ?yw:id ?ww:id)
(<> ?yaxA:id ?waxA:id)
(if (< ?yaxA:id ?waxA:id)
    then 
    (< ?yaxA:id ?yw:id)
    (< ?yw:id ?waxA:id)
    (< ?waxA:id ?ww:id)
    else
    (< ?waxA:id ?ww:id)
    (< ?ww:id ?yaxA:id)
    (< ?yaxA:id ?yw:id)
)
)
(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?yaxA:rt))
(printout bar "(" ?yaxA:id " " ?yaxA:mid " " ?k " " ?yw:id " " ?yw:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rly1a " ?k ?l crlf )

(bind ?j (gdbm_lookup "avy_relation_list.gdbm" ?waxA:rt))
(printout bar "(" ?waxA:id " " ?waxA:mid " " ?j " " ?ww:id " " ?ww:mid " ) " )
(bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
(printout bar "#rly1a " ?j ?m crlf )

(bind ?j (gdbm_lookup "kAraka_num.gdbm" "niwya_sambanXaH"))
(printout bar "(" ?yw:id " " ?yw:mid " " ?j " " ?waxA:id " " ?waxA:mid " ) " )
(printout bar "#rly1a " ?j "niwya_sambanXaH" crlf )
))
;======================================================================================
;Added by amba
;yawra nAryaH pUjyanwe wawra xevawAH ramanwe
;rly1b
(defrule assign_rel_for_yawra_wawra
(and (test (eq (slot-val-match avy word yawra) TRUE))
     (test (eq (slot-val-match avy word wawra) TRUE))
)
=>
(do-for-all-facts
((?yawra avy)(?wawra avy)(?yw wif kqw)(?ww wif kqw))
(and
(eq ?yawra:word yawra)
(eq ?wawra:word wawra)
(<> ?yw:id ?ww:id)
(<> ?yawra:id ?wawra:id)
(if (< ?yawra:id ?wawra:id)
    then 
    (< ?yawra:id ?yw:id)
    (< ?yw:id ?wawra:id)
    (< ?wawra:id ?ww:id)
    else
    (< ?wawra:id ?ww:id)
    (< ?ww:id ?yawra:id)
    (< ?yawra:id ?yw:id)
)
)
(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?yawra:rt))
(printout bar "(" ?yawra:id " " ?yawra:mid " " ?k " " ?yw:id " " ?yw:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rly1b " ?k ?l crlf )

(bind ?j (gdbm_lookup "avy_relation_list.gdbm" ?wawra:rt))
(printout bar "(" ?wawra:id " " ?wawra:mid " " ?j " " ?ww:id " " ?ww:mid " ) " )
(bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
(printout bar "#rly1b " ?j ?m crlf )

(bind ?j (gdbm_lookup "kAraka_num.gdbm" "niwya_sambanXaH"))
(printout bar "(" ?yw:id " " ?yw:mid " " ?j " " ?wawra:id " " ?wawra:mid " ) " )
(printout bar "#rly1b " ?j "niwya_sambanXaH" crlf )
))
;=========================================================================================
;Added by sheetal
;mayUraH nqwyawi yaxA meGaH varRawi.
;rly2
(defrule assign_rel_for_yaxA
(test (eq (slot-val-match avy word yaxA) TRUE))
(test (neq (slot-val-match avy word waxA) TRUE))
=>
(do-for-all-facts
((?yaxA avy)(?yw wif)(?ww wif))
(and
(eq ?yaxA:word yaxA)
(<> ?yw:id ?yaxA:id)
(< ?ww:id ?yw:id)
(< ?ww:id ?yaxA:id)
(eq (gdbm_lookup "avy_verb_list.gdbm" ?yaxA:rt) "1"))

(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?yaxA:rt))
(printout bar "(" ?yaxA:id " " ?yaxA:mid " " ?k " " ?yw:id " " ?yw:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rly2 " ?k ?l crlf )

))
;=======================================================================================
;Added by sheetal
;meGaH varRawi waxA mayUraH nqwyawi.
;rlw
(defrule assign_rel_for_waxA
(test (eq (slot-val-match avy word waxA) TRUE))
(test (neq (slot-val-match avy word yaxA) TRUE))
=>
(do-for-all-facts
((?waxA avy)(?yw wif)(?ww wif))
(and
(eq ?waxA:word waxA)
(< ?yw:id ?waxA:id)
(< ?yw:id ?ww:id)
(<> ?ww:id ?waxA:id)
(eq (gdbm_lookup "avy_verb_list.gdbm" ?waxA:rt) "1"))

(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?waxA:rt))
(printout bar "(" ?waxA:id " " ?waxA:mid " " ?k " " ?ww:id " " ?ww:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlw " ?k ?l crlf )

))
;=======================================================================================
;Added by sheetal
;yaxyapi bAlakaH samyak calawi waWApi saH pawawi.
;rlyw
(defrule assign_rel_bAXaka_abAXiwa
(test (eq (slot-val-match avy word yaxyapi) TRUE))
(test (eq (slot-val-match avy word waWApi) TRUE))
=>
(do-for-all-facts
((?ypi avy)(?wpi avy)(?yw wif)(?ww wif))
(and
(eq ?ypi:word yaxyapi)
(eq ?wpi:word waWApi)
(<> ?ypi:id ?wpi:id)
(<> ?yw:id ?ww:id)
    (< ?yw:id ?ww:id)
    (< ?yw:id ?wpi:id)
    (> ?ww:id ?ypi:id))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI")) 
(printout bar "(" ?yw:id " " ?yw:mid " " ?k " " ?ypi:id " " ?ypi:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlw " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?wpi:id " " ?wpi:mid " " ?k " " ?ww:id " " ?ww:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlw " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
(printout bar "(" ?ypi:id " " ?ypi:mid " " ?k " " ?wpi:id " " ?wpi:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlw " ?k ?l crlf )
))
;=======================================================================================
;Added by sheetal
;ayam bahu-prayAsam kqwavAn waWApi saH a-saPalaH aBUw.
;rlyw1
(defrule assign_bAXaka_abAXiwa_for_waWApi
(test (neq (slot-val-match avy word yaxyapi) TRUE))
(test (eq (slot-val-match avy word waWApi) TRUE))
=>
(do-for-all-facts
((?wpi avy)(?yw wif kqw)(?ww wif))
(and
(eq ?wpi:word waWApi)
;(<> ?yw:id ?ww:id)
(< ?yw:id ?wpi:id)
(> ?ww:id ?wpi:id))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?ww:id " " ?ww:mid " " ?k " " ?wpi:id " " ?wpi:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlw1 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI"))
(printout bar "(" ?yw:id " " ?yw:mid " " ?k " " ?wpi:id " " ?wpi:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlyw1 " ?k ?l crlf )
))
;=======================================================================================
;Added by sheetal
;yawaH saH samaye na AgawaH wawaH(awaH) saH praveSaparIkRAyAm na anumawaH.
;rlyH
(defrule assign_yawaH_wawaH
(test (eq (slot-val-match avy word yawaH) TRUE))
(or (test (eq (slot-val-match avy word wawaH) TRUE))(test (eq (slot-val-match avy word awaH) TRUE)))
=>
(do-for-all-facts
((?ywH avy)(?wwH avy)(?yw wif kqw)(?ww wif kqw))
(and
(or (eq ?wwH:word wawaH)(eq ?wwH:word awaH))
(eq ?ywH:word yawaH)
;(<> ?ywH:id ?wwH:id)
(> ?yw:id ?ywH:id)
(< ?yw:id ?wwH:id)
(> ?ww:id ?wwH:id))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?wwH:id " " ?wwH:mid " " ?k " " ?ww:id " " ?ww:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlyH " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI"))
(printout bar "(" ?yw:id " " ?yw:mid " " ?k " " ?ywH:id " " ?ywH:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlyH " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
(printout bar "(" ?ywH:id " " ?ywH:mid " " ?k " " ?wwH:id " " ?wwH:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlyH " ?k ?l crlf )

))
;=======================================================================================
;Added by sheetal
;yaxi mexinI naSyew api yukwam.
;rlya
(defrule assign_yaxi_api
(test (eq (slot-val-match avy word yaxi) TRUE))
(or (test (eq (slot-val-match avy word api) TRUE))(test (eq (slot-val-match avy word waWApi) TRUE)))
=>
(do-for-all-facts
((?yaxi avy)(?api avy)(?yw wif kqw)(?aw wif kqw))
(and
(or (eq ?api:word api)(eq ?api:word waWApi))
(eq ?yaxi:word yaxi)
(<> ?yaxi:id ?api:id)
(> ?yw:id ?yaxi:id)
(> ?aw:id ?api:id)
(< ?yw:id ?api:id)
(> ?aw:id ?yaxi:id))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?api:id " " ?api:mid " " ?k " " ?aw:id " " ?aw:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlya " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI"))
(printout bar "(" ?yw:id " " ?yw:mid " " ?k " " ?yaxi:id " " ?yaxi:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlya " ?k ?l crlf )
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
;(printout bar "( -1 -1  " ?k " " ?yw:id " " ?yw:mid "  ) " )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
(printout bar "(" ?yaxi:id " " ?yaxi:mid " " ?k " " ?api:id " " ?api:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlya " ?k ?l crlf )

))
;=======================================================================================
;Added by sheetal
;yAvaw ayam prANena na viyujyawe wAvaw imam gqhANa.
;rlyvw
(defrule assign_yAvaw_wAvaw
(or (test (eq (slot-val-match avy word yAvaw) TRUE))(test (eq (slot-val-match sup word yAvaw) TRUE)))
(or (test (eq (slot-val-match avy word wAvaw) TRUE))(test (eq (slot-val-match sup word wAvaw) TRUE)))
=>
(do-for-all-facts
((?yvw avy sup)(?wvw avy sup)(?yw wif kqw)(?ww wif kqw))
(and
(eq ?wvw:word wAvaw)
(eq ?yvw:word yAvaw)
(<> ?yvw:id ?wvw:id)
(> ?yw:id ?yvw:id)
(> ?ww:id ?wvw:id)
(< ?yw:id ?wvw:id)
(> ?ww:id ?yvw:id)
;(eq (gdbm_lookup "avy_verb_list.gdbm" ?wvw:rt) "1")
;(eq (gdbm_lookup "avy_verb_list.gdbm" ?yvw:rt) "1")
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI"))
(printout bar "(" ?yw:id " " ?yw:mid " "  ?k " " ?yvw:id " " ?yvw:mid ") " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlyvw " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?wvw:id " " ?wvw:mid " "  ?k " " ?ww:id " " ?ww:mid ") " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlyvw " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
(printout bar "(" ?yvw:id " " ?yvw:mid " " ?k " " ?wvw:id " " ?wvw:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlyvw " ?k ?l crlf )

))
;=======================================================================================
;Added by sheetal
;yaWA rAjA prIwim eRyawi waWA rAGavaH prIwim eRyawi.
;rlyaWA
(defrule assign_yaWA_waWA
(test (eq (slot-val-match avy word yaWA) TRUE))
(test (eq (slot-val-match avy word waWA) TRUE))
=>
(do-for-all-facts
((?yaWA avy)(?waWA avy)(?yw wif kqw)(?ww wif kqw))
(and
(eq ?waWA:word waWA)
(eq ?yaWA:word yaWA)
(<> ?yaWA:id ?waWA:id)
(> ?yw:id ?yaWA:id)
(> ?ww:id ?waWA:id)
(< ?yw:id ?waWA:id)
(> ?ww:id ?yaWA:id)
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?waWA:id " " ?waWA:mid " " ?k " " ?ww:id " " ?ww:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlya " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI"))
(printout bar "(" ?yw:id " " ?yw:mid " " ?k " " ?yaWA:id " " ?yaWA:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlya " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
(printout bar "(" ?yaWA:id " " ?yaWA:mid " " ?k " " ?waWA:id " " ?waWA:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlya " ?k ?l crlf )

))

;=======================================================================================
;Added by sheetal
;rAme krIdawi mohanaH krIdawi.rAme puswake paTawi mohanaH api paTawi.
;rlS1
(defrule assign_samAnakAlika_for_sawisapwamI
(test (eq (slot-val-match kqw kqw_prawyayaH Sawq) TRUE))
(test (eq (slot-val-match sup viBakwiH 7) TRUE))
(test (> (count-facts wif) 0))
=>
(do-for-all-facts
((?Sawq kqw)(?sup sup)(?w wif))
(and
(< ?Sawq:id ?w:id)
(< ?sup:id ?Sawq:id)
(= ?sup:viBakwiH 7)
(eq ?Sawq:kqw_prawyayaH Sawq)
(= ?Sawq:viBakwiH 7))

(if (and (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?Sawq kqw_vb_rt)) "1")(neq ?Sawq:kqw_vb_rt gam1)) then
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samAnakAlaH"))
    (printout bar "(" ?Sawq:id " " ?Sawq:mid " " ?k " " ?w:id " " ?w:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlS1 " ?k ?l crlf )

    (bind ?j (gdbm_lookup "kAraka_num.gdbm" "karwA"))
    (printout bar "(" ?sup:id " " ?sup:mid " " ?j " " ?Sawq:id " " ?Sawq:mid " ) " )
    (bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
    (printout bar "#rlS1 " ?j ?m crlf )
    (bind ?f (gdbm_lookup "kAraka_num.gdbm" "karma"))
    (printout bar "(" ?sup:id " " ?sup:mid " " ?f " " ?Sawq:id " " ?Sawq:mid " ) " )
    (bind ?g (gdbm_lookup "kAraka_name_dev.gdbm" ?f))
    (printout bar "#rlS1 " ?f ?g crlf)
    else
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samAnakAlaH"))
    (printout bar "(" ?Sawq:id " " ?Sawq:mid " " ?k " " ?w:id " " ?w:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlS1 " ?k ?l crlf )
    (bind ?j (gdbm_lookup "kAraka_num.gdbm" "karwA"))
    (printout bar "(" ?sup:id " " ?sup:mid " " ?j " " ?Sawq:id " " ?Sawq:mid " ) " )
    (bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
    (printout bar "#rlS1 " ?j ?m crlf ))
))
;===============================================================================
;Added by sheetal
;rAme vanam gacCawi sIwA anusarawi.
;rlS2
(defrule assign_samAnakAlika_for_sawisapwamI_gam1
(test (eq (slot-val-match kqw kqw_prawyayaH Sawq) TRUE))
(test (eq (slot-val-match sup viBakwiH 7) TRUE))
(test (> (count-facts wif) 0))
=>
(do-for-all-facts
((?Sawq kqw)(?sup sup)(?w wif))
(and
(< ?Sawq:id ?w:id)
(< ?sup:id ?Sawq:id)
(or (= ?sup:viBakwiH 2)(= ?sup:viBakwiH 7))
(eq ?Sawq:kqw_prawyayaH Sawq)
(= ?Sawq:viBakwiH 7)
(eq ?Sawq:kqw_vb_rt gam1)
)
(if (= ?sup:viBakwiH 7)
    then
    (bind ?j (gdbm_lookup "kAraka_num.gdbm" "karwA"))
    (printout bar "(" ?sup:id " " ?sup:mid " " ?j " " ?Sawq:id " " ?Sawq:mid " ) " )
    (bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
    (printout bar "#rlS2 " ?j ?m crlf )
    else
    (bind ?j (gdbm_lookup "kAraka_num.gdbm" "karma"))
    (printout bar "(" ?sup:id " " ?sup:mid " " ?j " " ?Sawq:id " " ?Sawq:mid " ) " ) 
    (bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
    (printout bar "#rlS2 " ?j ?m crlf ))
    
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samAnakAlaH"))
(printout bar "(" ?Sawq:id " " ?Sawq:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlS2 " ?k ?l crlf )
))
;=======================================================================================
;Added by sheetal
;TO CHECK: AMBA
;rAme puswake paTiwe mohanaH api paTawi. rAme Sayiwe mohanaH api svapiwi.
;rlS3
(defrule assign_pUrvakAlika_for_sawisapwamI
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE))
(test (eq (slot-val-match sup viBakwiH 7) TRUE))
(test (> (count-facts wif) 0))
=>
(do-for-all-facts
((?Sawq kqw)(?sup sup)(?w wif))
(and
(< ?Sawq:id ?w:id)
(< ?sup:id ?Sawq:id)
(= ?sup:viBakwiH 7)
(eq ?Sawq:kqw_prawyayaH kwa)
(= ?Sawq:viBakwiH 7))
(if (and (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?Sawq kqw_vb_rt)) "1")(neq ?Sawq:kqw_vb_rt gam1)) then
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "pUrvakAlaH"))
    (printout bar "(" ?Sawq:id " " ?Sawq:mid " " ?k " " ?w:id " " ?w:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlS3 " ?k ?l crlf )

    (bind ?j (gdbm_lookup "kAraka_num.gdbm" "karwA"))
    (printout bar "(" ?sup:id " " ?sup:mid " " ?j " " ?Sawq:id " " ?Sawq:mid " ) " )
    (bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
    (printout bar "#rlS3 " ?j ?m crlf )
    (bind ?j (gdbm_lookup "kAraka_num.gdbm" "karma"))
    (printout bar "(" ?sup:id " " ?sup:mid " " ?j " " ?Sawq:id " " ?Sawq:mid " ) " )
    (bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
    (printout bar "#rlS3 " ?j ?m crlf )
    else
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "pUrvakAlaH"))
    (printout bar "(" ?Sawq:id " " ?Sawq:mid " " ?k " " ?w:id " " ?w:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlS3 " ?k ?l crlf )

    (bind ?j (gdbm_lookup "kAraka_num.gdbm" "karwA"))
    (printout bar "(" ?sup:id " " ?sup:mid " " ?j " " ?Sawq:id " " ?Sawq:mid " ) " )
    (bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
    (printout bar "#rlS3 " ?j ?m crlf ))
))
;=======================================================================================
;Added by sheetal
;rAme vanam gawe sIwA anusarawi.
;rls4
; TO CHECK: AMBA
(defrule assign_pUrvakAlika_for_sawisapwamI_gam1
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE))
(test (eq (slot-val-match sup viBakwiH 7) TRUE))
(or (test (> (count-facts wif) 0))(test (> (count-facts kqw) 0)))
=>
(do-for-all-facts
((?Sawq kqw)(?sup sup)(?w wif))
(and
(< ?Sawq:id ?w:id)
(< ?sup:id ?Sawq:id)
(or (= ?sup:viBakwiH 7)(= ?sup:viBakwiH 2))
(eq ?Sawq:kqw_prawyayaH kwa)
(= ?Sawq:viBakwiH 7)
(eq ?Sawq:kqw_vb_rt gam1)
)
(if (= ?sup:viBakwiH 7)
    then
    (bind ?j (gdbm_lookup "kAraka_num.gdbm" "karwA"))
    (printout bar "(" ?sup:id " " ?sup:mid " " ?j " " ?Sawq:id " " ?Sawq:mid " ) " )
    (bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
    (printout bar "#rls4 " ?j ?m crlf )
    else        
    (bind ?j (gdbm_lookup "kAraka_num.gdbm" "karma"))
    (printout bar "(" ?sup:id " " ?sup:mid " " ?j " " ?Sawq:id " " ?Sawq:mid " ) " )
    (bind ?m (gdbm_lookup "kAraka_name_dev.gdbm" ?j))
    (printout bar "#rls4 " ?j ?m crlf ))
    
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "pUrvakAlaH"))
(printout bar "(" ?Sawq:id " " ?Sawq:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rls4 " ?k ?l crlf )
))
;======================================================================================
;Added by sheetal
;puwraH puwrI ca janma-grahaNam akarow eva na.
;rAmaH sIwA ca vanam gacCawaH.
;rlca
(defrule assign_samucciwam_karwari
(test (or (eq (slot-val-match avy word ca) TRUE) (eq (slot-val-match avy word cEva) TRUE)))
(test (eq (slot-val-match wif prayogaH karwari) TRUE))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a avy)(?w wif))
(and
(or (eq ?a:word ca)
    (eq ?a:word cEva)
)
(< ?s1:id ?s2:id)
(= (- ?a:id ?s2:id) 1)
(< ?a:id ?w:id)
(= ?s1:viBakwiH ?s2:viBakwiH)
(eq ?s1:vacanam ?s2:vacanam)
(eq ?w:prayogaH karwari)
(eq ?w:puruRaH pra)
;(= (- ?a:id ?s2:id) 1)(neq ?w:vacanam ?s1:vacanam)
;(neq ?w:vacanam ?s2:vacanam)
;commented by Madhavachar.T.V
; Following conditions added by Madhvachar
; AMBA: the function should be generalised to take into account xvivacanam as well as bahuvacanam
;(neq ?w:vacanam ?s2:vacanam)
;(neq ?w:vacanam ?s1:vacanam)
;(eq ?w:prayogaH karwari)
)
   (if (= ?s1:viBakwiH 1)
       then
       (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
       (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
       (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
       (printout bar "#rlca " ?k ?l crlf )

       (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam1"))
       (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlca " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlca " ?k ?l crlf )
   )
))
;===================================================================================
;Added by Amba
;rAmaH vanam gqham ca gacCawi.
;rlca
(defrule assign_samucciwam_karma_karwari
(test (or (eq (slot-val-match avy word ca) TRUE) (eq (slot-val-match avy word cEva) TRUE)))
;(test (eq (slot-val-match wif prayogaH karwari) TRUE))
(not (and (test (= (count-facts sup) 0))(test (= (count-facts kqw) 0))(test (= (count-facts waxXiwa) 0))))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa)(?s2 sup kqw waxXiwa)(?a avy)(?w wif avykqw kqw))
(and
(or (eq ?a:word ca)
    (eq ?a:word cEva)
)
(< ?s1:id ?s2:id)
(= (- ?a:id ?s2:id) 1)
(< ?a:id ?w:id)
(= ?s1:viBakwiH ?s2:viBakwiH)
)
   (if (= ?s1:viBakwiH 2)
       then
       (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
       (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
       (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
       (printout bar "#rlcak " ?k ?l crlf )

       (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam2"))
       (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlcak " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlcak " ?k ?l crlf )
   )
))
;===================================================================================
;added by Madhavachar.T.V
;added by Madhavachar.T.V
;avy_kqw;rAmaH kqRNaH ca vanam gawvA KAxawi.
;Similar rule is to be written for other kqws also: rAmaH kqRNaH ca vanam gacCawaH Palam KaxaWaH.
;rlca8
;(defrule assign_samucciwam_single_ca_avykqw
;(and (test (eq (slot-val-match avy word ca) TRUE))
;(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0))
;)
;; AMBA: Any avykqw should suffice. Why is it necessary to list each of these 3 kqw prawyayas?
;;(or (test (eq (slot-val-match avykqw kqw_prawyayaH kwvA) TRUE))(test (eq (slot-val-match avykqw kqw_prawyayaH lyap) TRUE))(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))))
;=>
;(do-for-all-facts
;((?s1 sup)(?s2 sup)(?a1 avy)(?a2 avykqw))
;(and
;(eq ?a1:word ca)
;(< ?s1:id ?s2:id)
;(= (- ?a1:id ?s2:id) 1)
;;(= (- ?a2:id ?a1:id) 1)
;(< ?a1:id ?a2:id)
;(= ?s1:viBakwiH ?s2:viBakwiH)
;(eq ?s1:vacanam ?s2:vacanam)
;;(eq ?a2:kqw_prawyayaH wumun) ;Madhvachar
;; AMBA why only wumun? 
;;(eq ?w:vacanam ?s2:vacanam)
;)
;(if (= ?s1:viBakwiH 1)
;then
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
;(printout bar "(" ?a1:id " " ?a1:mid " " ?k " " ?a2:id " " ?a2:mid " ) " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlca8 " ?k ?l crlf )
;)
;(if (= ?s1:viBakwiH 2)
;then
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
;(printout bar "(" ?a1:id " " ?a1:mid " " ?k " " ?a2:id " " ?a2:mid " ) " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlca8 " ?k ?l crlf )
;)
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a1:id " " ?a1:mid " ) " )
;(printout bar "#rlca8 " ?k ?l crlf )
;
;(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a1:id " " ?a1:mid " )" )
;(printout bar "#rlca8 " ?k ?l crlf )
;)
;)
;===================================================================================
;modified by madhavachar(eq ?w:vacanam ?s2:vacanam)
;rAmaH kqRNaH ca vanam gacCawi.
;rlca1
;(defrule assign_samucciwam_single_ca_karwari
;(and (test (eq (slot-val-match avy word ca) TRUE))
;(test (eq (slot-val-match wif prayogaH karwari) TRUE)))
;=>
;(do-for-all-facts
;((?s1 sup)(?s2 sup)(?a avy)(?w wif))
;(and
;(eq ?a:word ca)
;;(= (-?s1:id ?s2:id) 1) ; AMBA: changed from < ?s1:id ?s2:id
;(< ?s1:id ?s2:id) ; AMBA: No it is not necessary that s1 and s2 be consecutive.
;; We may have synxaraH rAmaH sunxarI ramA ca vanam gacCawi.
;(= (- ?a:id ?s2:id) 1)
;(< ?a:id ?w:id)
;(= ?s1:viBakwiH ?s2:viBakwiH)
;;(eq ?s1:vacanam ?s2:vacanam)
;; Amba: Is it not necessary that both should be in the same vacana.
;; for example one may have rame rAmaH ca vanam gacCawi.
;(eq ?w:prayogaH karwari)
;(eq ?w:vacanam ?s2:vacanam)
;)
;(if (= ?s1:viBakwiH 1)
;then
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
;(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlca1 " ?k ?l crlf )
;)
;(if (= ?s1:viBakwiH 2)
;then
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
;(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlca1 " ?k ?l crlf )
;)
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
;(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlca1 " ?k ?l crlf )
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
;(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " )" )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlca1 " ?k ?l crlf )
;
;)
;)

;===================================================================================
;added by madhavachar.T.V
;rAmaH ramA vA vanam gacCawi.
;rlvA1
(defrule assign_anyawaraH_vA
(and (test (eq (slot-val-match avy word vA) TRUE))
(test (eq (slot-val-match wif prayogaH karwari) TRUE)))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a avy)(?w wif))
(and
(eq ?a:word vA)
(< ?s1:id ?s2:id)
(= (- ?a:id ?s2:id) 1)
(< ?a:id ?w:id)
(= ?s1:viBakwiH ?s2:viBakwiH)
(eq ?s1:vacanam ?s2:vacanam)
(eq ?w:prayogaH karwari)
(eq ?w:vacanam ?s1:vacanam)
)
(if (= ?s1:viBakwiH 1)
then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlvA1" ?k ?l crlf )
)
(if (= ?s1:viBakwiH 2)
then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlvA1" ?k ?l crlf )
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anyawaraH"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlvA1" ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anyawaraH"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlvA1" ?k ?l crlf )
)
)

;===================================================================================
;added by Madhavachar.T.V
;rAmaH gacCawi vA KAxawi. 
;rlvA2
(defrule assign_anyawaraH_for_wif_2
(test (eq (slot-val-match avy word vA) TRUE))
(test (> (count-facts wif) 1))
=>
(do-for-all-facts
((?a avy)(?w1 wif)(?w2 wif))
(and

(eq ?a:word vA)
(> ?a:id ?w1:id)
(< ?a:id ?w2:id)
(eq ?w1:puruRaH ?w2:puruRaH)
(eq ?w1:vacanam ?w2:vacanam)
(eq ?w1:lakAraH ?w2:lakAraH) ; Added by Amba
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anyawaraH"))
    (printout bar "(" ?w1:id " " ?w1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k)) 
    (printout bar "#rlcw1 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anyawaraH"))
    (printout bar "(" ?w2:id " " ?w2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlcw1 " ?k ?l crlf )
))
;===================================================================================
;Added by Madhavachar.T.V 
;rAmeNa sIwayA vA vanam gamyawe.
;rlvA6
(defrule assign_anyawaraH_karmaNi
(test (eq (slot-val-match avy word vA) TRUE))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a avy)(?w wif avykqw kqw))
(and
(eq ?a:word vA)
(< ?s1:id ?s2:id)
(= (- ?a:id ?s2:id) 1)
(< ?a:id ?w:id)
(= ?s1:viBakwiH ?s1:viBakwiH)
;(eq ?s1:vacanam ?s2:vacanam)
(eq ?w:prayogaH karmaNi)
)
   (if (= ?s1:viBakwiH 3)
       then
       (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
       (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
       (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
       (printout bar "#rlvA6 " ?k ?l crlf )
; Amba: karaNa is also possible; see next function for karaNAxi
   )
   (if (= ?s1:viBakwiH 1)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlvA6 " ?k ?l crlf )
   )
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "anyawaraH"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlvA6 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlvA6 " ?k ?l crlf )
))

;===================================================================================
;added by Madhavachar.T.V
;rAmaH paxByAm yAnena vA gacCawi.
;rlvA5 
(defrule assign_anyawaraH_for_karaNAxi
(test (eq (slot-val-match avy word vA) TRUE))
(test (> (count-facts sup) 1))
=>        
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a avy)(?w wif avykqw kqw)) 
(and(eq ?a:word vA)(= (- ?s2:id ?s1:id) 1)(= (- ?a:id ?s2:id) 1)(< ?a:id ?w:id)(= ?s1:viBakwiH ?s2:viBakwiH)
;(eq ?s1:vacanam ?s2:vacanam)
)  
(if (= ?s1:viBakwiH 3)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlvA5" ?k ?l crlf )  
   )
(if (= ?s1:viBakwiH 4)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "sampraxAnam"))
   (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlvA5 " ?k ?l crlf )
   )
(if (= ?s1:viBakwiH 5)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "apAxAnam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlvA5 " ?k ?l crlf )
   )
(if (= ?s1:viBakwiH 6)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "RaRTI_sambanXaH"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlvA5 " ?k ?l crlf )
 )
(if (= ?s1:viBakwiH 7)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "aXikaraNam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlvA5 " ?k ?l crlf )
   )
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "anyawaraH"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlvA5 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlvA5 " ?k ?l crlf )
))

;===================================================================================
;Added by sheetal
;puwraH puwrI ca janma-grahaNam akarow eva na.
;rAmeNa sIwayA ca vanam gamyawe.
;rlc1
(defrule assign_samucciwam_karmaNi
(test (or (eq (slot-val-match avy word ca) TRUE) (eq (slot-val-match avy word cEva) TRUE)))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a avy)(?w wif))
(and
(or (eq ?a:word ca)
    (eq ?a:word cEva)
)
(< ?s1:id ?s2:id)
(= (- ?a:id ?s2:id) 1)
(< ?a:id ?w:id)
(= ?s1:viBakwiH ?s2:viBakwiH)
(eq ?s1:vacanam ?s2:vacanam)
(eq ?w:prayogaH karmaNi)
)
   (if (= ?s1:viBakwiH 3)
       then
       (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
       (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
       (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
       (printout bar "#rlc1 " ?k ?l crlf )
   )
   (if (= ?s1:viBakwiH 1)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc1 " ?k ?l crlf ) 
   )
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam2"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc1 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc1 " ?k ?l crlf )
))
;===================================================================================
;Added by sheetal
;niwyaH nirAkAra ca AwmA kaWaM na xqRyawe
;rlc1a
(defrule assign_samucciwam_viSeRaNam
(test (or (eq (slot-val-match avy word ca) TRUE) (eq (slot-val-match avy word cEva) TRUE)))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa)(?s2 sup kqw waxXiwa)(?a avy)(?s3 sup kqw waxXiwa))
(and
(or (eq ?a:word ca)
    (eq ?a:word cEva)
)
(< ?s1:id ?s2:id)
(= (- ?a:id ?s2:id) 1)
(= (- ?s3:id ?a:id) 1)
(= ?s1:viBakwiH ?s2:viBakwiH)
(eq ?s1:vacanam ?s2:vacanam)
(eq ?s1:lifgam ?s2:lifgam)
(= ?s2:viBakwiH ?s3:viBakwiH)
(eq ?s2:vacanam ?s3:vacanam)
(eq ?s2:lifgam ?s3:lifgam)
(neq ?s1:word ?s3:word)
(neq ?s2:word ?s3:word)
)
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "viSeRaNam"))
    (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s3:id " " ?s3:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlc1a " ?k ?l crlf )
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwamviSeRaNam"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc1a " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc1a " ?k ?l crlf )
))
;===================================================================================
;Added by Amba
;samavewAH mAmakAH pANdavAH ca
;rlc1b
(defrule assign_samucciwam_viSeRya
(test (or (eq (slot-val-match avy word ca) TRUE) (eq (slot-val-match avy word cEva) TRUE)))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa)(?s2 sup kqw waxXiwa)(?s3 sup kqw waxXiwa)(?a avy))
(and
(or (eq ?a:word ca)
    (eq ?a:word cEva)
)
(< ?s1:id ?s2:id)
(= (- ?a:id ?s3:id) 1)
(= (- ?s3:id ?s2:id) 1)
(= ?s1:viBakwiH ?s2:viBakwiH)
(eq ?s1:vacanam ?s2:vacanam)
(eq ?s1:lifgam ?s2:lifgam)
(= ?s2:viBakwiH ?s3:viBakwiH)
(eq ?s2:vacanam ?s3:vacanam)
(eq ?s2:lifgam ?s3:lifgam)
)
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "viSeRaNam"))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlc1b " ?k ?l crlf )
))
;===================================================================================
;Added by Amba
;
;rlc2a
(defrule assign_samucciwam_for_prayojanam
(test (or (eq (slot-val-match avy word ca) TRUE) (eq (slot-val-match avy word cEva) TRUE)))
(not (and (test (= (count-facts sup) 0))(test (= (count-facts kqw) 0))))
=>
(do-for-all-facts
((?s1 sup kqw)(?s2 sup kqw)(?a avy)(?w wif avykqw kqw))
(and (or (eq ?a:word ca)
         (eq ?a:word cEva)
     )
     ;(= (- ?s2:id ?s1:id) 1)
     ;(= (- ?a:id ?s2:id) 1)
      (< ?a:id ?w:id)
      (= ?s1:viBakwiH ?s2:viBakwiH)
      (eq ?s1:vacanam ?s2:vacanam))
(if (= ?s1:viBakwiH 4)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc2a " ?k ?l crlf ) 
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwamprayojanam"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2a " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2a " ?k ?l crlf )
   )
))
;===================================================================================
;Added by sheetal
;
;rlc2
(defrule assign_samucciwam_for_karaNAxi
(test (or (eq (slot-val-match avy word ca) TRUE) (eq (slot-val-match avy word cEva) TRUE)))
(not (and (test (= (count-facts sup) 0))(test (= (count-facts kqw) 0))))
=>
(do-for-all-facts
((?s1 sup kqw)(?s2 sup kqw)(?a avy)(?w wif avykqw kqw))
(and (or (eq ?a:word ca)(eq ?a:word cEva)) (= (- ?s2:id ?s1:id) 1)(= (- ?a:id ?s2:id) 1)(< ?a:id ?w:id)(= ?s1:viBakwiH ?s2:viBakwiH)(eq ?s1:vacanam ?s2:vacanam))
(if (and (= ?s1:viBakwiH 3)
         (eq (gdbm_lookup "karaNa_XAwu_list.gdbm" ?w:rt) "1");XAwuH sakaraNakaH syAw.
         (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1"))
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc2" ?k ?l crlf ) 
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam3"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )
   )
(if (and (= ?s1:viBakwiH 4)
         (eq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:rt) "1");XAwuH sasampraxAnako Bavew..
    )
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "sampraxAnam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc2 " ?k ?l crlf ) 
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam4"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )
   )

(if (and (= ?s1:viBakwiH 5)
         (eq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:rt) "1");XAwuH sApAxAnakaH syAw.
    )
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "apAxAnam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc2 " ?k ?l crlf ) 
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam5"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )
   )

(if (= ?s1:viBakwiH 7)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "aXikaraNam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc2 " ?k ?l crlf ) 
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam7"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )
   )
))
;===================================================================================
;Added by sheetal
;mod:by M.T.V"(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " ) 
;rAmaH ca vanam gacCawi.
;rlc
;(defrule assign_samucciwam_for_single_ca
;(test (eq (slot-val-match avy word ca) TRUE))
;=>
;(do-for-all-facts
;((?s1 sup)(?a avy)(?w wif))
;(and
;(eq ?a:word ca)
;(= (- ?a:id ?s1:id) 1)
;(< ?a:id ?w:id)
;(= ?s1:viBakwiH 1))

;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
;(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlc " ?k ?l crlf )
;
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
;    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
;    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;    (printout bar "#rlc " ?k ?l crlf )
;
;))
;===================================================================================
;Added by sheetal
;Added by sheetal, modified by Madhavachar.T.V(> ?a1:id ?a2:id)
;rAmaH ca sIwA ca vanam gacCawi.
;rlc3
;(defrule assign_samucciwam_for_multi_ca
;(test (eq (slot-val-match avy word ca) TRUE))
;=>
;(do-for-all-facts
;((?s1 sup)(?s2 sup)(?a1 avy)(?a2 avy)(?w wif))
;(and
;(eq ?a1:word ca)
;(eq ?a2:word ca)
;(= (- ?a1:id ?s1:id) 1)
;(= (- ?a2:id ?s2:id) 1)
;;(< ?a1:id ?w:id)
;(< ?a2:id ?w:id)
;;(<> ?a2:id ?a1:id)
;(= ?s1:viBakwiH ?s1:viBakwiH)
;(eq ?s1:vacanam ?s2:vacanam)
;(= ?s1:viBakwiH 1))
;
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
;(printout bar "(" ?a1:id " " ?a1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlc3 " ?k ?l crlf )
;
;    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
;    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;
;    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a1:id " " ?a1:mid " ) " )
;    (printout bar "#rlc3 " ?k ?l crlf )
;
;    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a1:id " " ?a1:mid " ) " )
;    (printout bar "#rlc3 " ?k ?l crlf )
;
;))
;===================================================================================
;Added by sheetal
;modified by Madhavachar.T.V (it was taking rAmaH(rA XAwuH, uwwama puruRaH)  is also samucciwa kriyApaxa)
;rAmaH paTawi KAxawi ca.
;rlcw
(defrule assign_samucciwam_for_wif_1
(test (or (eq (slot-val-match avy word ca) TRUE) (eq (slot-val-match avy word cEva) TRUE)))
(test (> (count-facts wif) 1))
=>
(do-for-all-facts
((?a avy)(?w1 wif)(?w2 wif))
(and
(or (eq ?a:word ca)
    (eq ?a:word cEva)
)
(or (= (- ?a:id ?w2:id) 1) (= (- ?w2:id ?a:id) 1))
(< ?w1:id ?w2:id)
(eq ?w1:puruRaH ?w2:puruRaH)
)
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwamkriyA"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?w1:id " " ?w1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlcw " ?k ?l crlf )

    (printout bar "(" ?w2:id " " ?w2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlcw " ?k ?l crlf )
))
;===================================================================================
;;Added by sheetal
;;modified by Madhavachar.T.V(eq ?w1:puruRaH ?w2:puruRaH)(eq ?w1:vacanam ?w2:vacanam)
;;rAmaH pATam paTawi Palam ca KAxawi.
;;rlcw1
;(defrule assign_samucciwam_for_wif_2
;(test (eq (slot-val-match avy word ca) TRUE))
;(test (> (count-facts wif) 1))
;=>
;(do-for-all-facts
;((?a avy)(?w1 wif)(?w2 wif))
;(and
;(eq ?a:word ca)
;(> ?a:id ?w1:id)
;(< ?a:id ?w2:id)
;(eq ?w1:puruRaH ?w2:puruRaH)
;(eq ?w1:vacanam ?w2:vacanam)
;)
;    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
;    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;
;    (printout bar "(" ?w1:id " " ?w1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
;    (printout bar "#rlcw1 " ?k ?l crlf )
;
;    (printout bar "(" ?w2:id " " ?w2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
;    (printout bar "#rlcw1 " ?k ?l crlf )
;))
;===================================================================================
;rlsamb
(defrule assign_samboXyaH
(not (and (test (= (count-viBakwi sup 8) 0))(test (= (count-viBakwi kqw 8) 0))(test (= (count-viBakwi waxXiwa 8) 0))))
=>
(do-for-all-facts
((?s sup kqw waxXiwa) (?w wif));sarveByaH subanweByaH "?s" iwi nAma xIyawe wifanweByaSca "?w" iwi.
(and
(= ?s:viBakwiH 8)
(<> ?s:id ?w:id));vAkye  "?s" "?w"- uBayoH sWAne pqWak BavewAm.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samboXyaH"))
(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlsamb " ?k ?l crlf )

)
)
;===========================================================================
;Added by sheetal
;Bo rAma mAm pAhi.
;rlsbX
(defrule assign_samboXanasUcakam
(not (and (test (= (count-viBakwi sup 8) 0))(test (= (count-viBakwi waxXiwa 8) 0))))
(or (test (eq (slot-val-match avy rt BoH) TRUE))(test (eq (slot-val-match avy rt ayi) TRUE))(test (eq (slot-val-match avy rt Bo) TRUE))(test (eq (slot-val-match avy rt he) TRUE))(test (eq (slot-val-match avy rt Am) TRUE)))
=>
(do-for-all-facts
((?s avy)(?s1 sup waxXiwa) (?w wif)); waxXiwa added to handle Bagavan
(and
(= ?s1:viBakwiH 8)
(<> ?s1:id ?w:id)
(= (- ?s1:id ?s:id) 1)
(or (eq ?s:word BoH)(eq ?s:word ayi)(eq ?s:word Bo)(eq ?s:word he)(eq ?s:word Am)))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samboXanasUcakam"))
(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?s1:id " " ?s1:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlsbX " ?k ?l crlf )

)
)
;===========================================================================
;Added by sheetal
;Bo rAmaH mAm pAhi.; Change the example: AMBA
;rlsbX
(defrule assign_niReXyaH
(or (test (eq (slot-val-match avy word alam) TRUE))(test (eq (slot-val-match avy word alaM) TRUE)))
(test (> (count-viBakwi sup 3) 0))
=>
(do-for-all-facts
((?a avy)(?s sup))
(and
(= ?s:viBakwiH 3)
(<> ?s:id ?a:id)
(or (eq ?a:word alam)(eq ?a:word alaM)))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "niReXyaH"))
(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?a:id " " ?a:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlsbX " ?k ?l crlf )

)
)
;===========================================================================
;Added by pavan
;wvaM mA gacCa.
;rlmA
(defrule assign_mAsambanXaH
(test (eq (slot-val-match avy word mA) TRUE))
(test (> (count-facts wif) 0) )
 =>
 (do-for-all-facts
  ((?a avy)(?w wif))
  (and
   (= (- ?w:id ?a:id) 1)
   (eq ?a:word mA)
   (or
     (eq ?w:lakAraH lot)
     (eq ?w:lakAraH viXilif)
     (eq ?w:lakAraH lqt)
   )
  )

  (bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
  (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
  (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
  (printout bar "#rlmA " ?k ?l crlf )
)
)

;===========================================================================
;Added by pavan
;rAmaH brAhmaNavaw aXIwe.
;rlvawkriyA_viSeRaNa
(defrule assign_vawkriyA_viSeRaNa
(test (eq (slot-val-match waxXiwa waxXiwa_prawyayaH vaw) TRUE))
(test (> (count-facts wif) 0) )
=>
(do-for-all-facts
 ((?s1 waxXiwa) (?w wif ));sarveByosvyayeByaH "?s1" iwi nAma xIyawe kqxanwAvyayakqxanwawifanweByaScawi.w" i 
 (and
  (= ?s1:viBakwiH 1) ;
  (< ?s1:id ?w:id)
  (eq ?s1:waxXiwa_prawyayaH vaw)
 )

 (bind ?k (gdbm_lookup "kAraka_num.gdbm" "kriyA_viSeRaNam"))
 (printout bar "(" ?s1:id " " ?s1:mid " "  ?k " " ?w:id " " ?w:mid ") " );"?s1" paxaM "?w" kriyAyAH kriyAviSeRaNaM saMBavawi.
 (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
 (printout bar "#rlvawkriyA_viSeRaNam " ?k ?l crlf )

)
)
;===========================================================================
;added by Madhavachar.T.V
;rAmaH vA sIwA vA vanam gacCawi.
rlvA3
(defrule assign_samucciwam_for_multi_vA
(test (eq (slot-val-match avy word vA) TRUE))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a1 avy)(?a2 avy)(?w wif))
(and
(eq ?a1:word vA)
(eq ?a2:word vA)
(= (- ?a1:id ?s1:id) 1)
(= (- ?a2:id ?s2:id) 1)
(< ?a2:id ?w:id)
(> ?a1:id ?a2:id)
(= ?s1:viBakwiH ?s2:viBakwiH)
(eq ?s1:vacanam ?s2:vacanam)
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?a1:id " " ?a1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlvA3 " ?k ?l crlf )

    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "anyawaraH"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a1:id " " ?a1:mid " ) " )
    (printout bar "#rlvA3 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a1:id " " ?a1:mid " ) " )
    (printout bar "#rlvA3 " ?k ?l crlf )
))

;===========================================================================
;added by Madhavachar.T.V
;rAmaH vA vanam gacCawi.
;rlvA4
;(defrule assign_samucciwam_for_single_vA
;(test (eq (slot-val-match avy word vA) TRUE))
;=>
;(do-for-all-facts
;((?s1 sup)(?a avy)(?w wif))
;(and
;(eq ?a:word vA)
;(= (- ?a:id ?s1:id) 1)
;(< ?a:id ?w:id)
;(= ?s1:viBakwiH 1))
;
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
;(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlvA4 " ?k ?l crlf )
;
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
;    (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s1:id " " ?s1:mid " ) " )
;    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;    (printout bar "#rlvA4 " ?k ?l crlf )
;))

; This needs to be modified a lot. So we do it later. -- amba
;;added by MADHAVACHAR .T.V.
;;rAmaH vanam gacCawi sIwA ca.
;;rlc7
;(defrule assign_samucciwam_for_wif_aXyAhAra
;(test (eq (slot-val-match avy word ca) TRUE))
;(test (eq (slot-val-match wif prayogaH karwari) TRUE))
;(test (> (count-facts sup) 1))
;=>
;(do-for-all-facts
;((?s1 sup)(?s2 sup)(?a avy)(?w wif))
;(and
;(eq ?a:word ca)
;(> ?a:id ?w:id)
;(< ?s1:id ?s2:id)
;(> ?s2:id ?w:id)
;(eq ?s1:viBakwiH ?s2:viBakwiH)
;(eq ?s1:vacanam ?s2:vacanam)
;(eq ?s1:vacanam ?w:vacanam)
;(= (- ?a:id ?s2:id) 1)
;(= (- ?s2:id ?w:id) 1)
;)
;    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwamkriyA"))
;    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;
;    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
;    (printout bar "#rlc7 " ?k ?l crlf )
;
;    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
;    (printout bar "#rlc7 " ?k ?l crlf )
;
;(if (= ?s1:viBakwiH 1)
;then
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
;(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlc7 " ?k ?l crlf )
;)
;(if (= ?s1:viBakwiH 2)
;then
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
;(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;(printout bar "#rlc7 " ?k ?l crlf )
;)
;(if (= ?s1:viBakwiH 3)
;          then
;           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
;           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;           (printout bar "#rlc7" ?k ?l crlf )
;)
;
;(if (= ?s1:viBakwiH 4)
;          then
;           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "sampraxAnam"))
;           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;           (printout bar "#rlc7" ?k ?l crlf )
;)
;(if (= ?s1:viBakwiH 5)
;          then
;           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "apAxAnam"))
;           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;           (printout bar "#rlc7" ?k ?l crlf )
;)
;(if (= ?s1:viBakwiH 7)
;          then
;           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "aXikaraNam"))
;           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
;           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
;           (printout bar "#rlc7" ?k ?l crlf )
;)
;)
;)
;======================================================================
;added by MADHAVACHAR.T.V.
;rAmasya gqhaM aswi sIwAyAH ca.
;rlc8
(defrule assign_samucciwam_for_RaRTI_sambanXaH
(test (or (eq (slot-val-match avy word ca) TRUE) (eq (slot-val-match avy word cEva) TRUE)))
(test (eq (slot-val-match wif prayogaH karwari) TRUE))
(test (> (count-facts sup) 2))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?s3 sup)(?a avy)(?w wif))
(and
(or (eq ?a:word ca)
    (eq ?a:word cEva)
)
(< ?w:id ?a:id)
(< ?s1:id ?s2:id)
(= ?s1:viBakwiH 6)
(= ?s1:viBakwiH ?s2:viBakwiH)
(= ?s3:viBakwiH 1)
(eq ?s1:vacanam ?s2:vacanam)
;(eq ?s1:vacanam ?w:vacanam)
(= (- ?a:id ?s2:id) 1)
;(= (- ?s3:id ?w:id) 1)
(eq ?s3:vacanam ?w:vacanam)
)
(if (= ?s3:viBakwiH 1)
then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "RaRTI_sambanXaH"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s3:id " " ?s3:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc8 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam6"))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlc8 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam6"))
    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlc8 " ?k ?l crlf )

) 
 ))
;=============================================================
;added by MADHAVACHAR.T.V.
;cEwreNa rAmasya gqhaM gamyawe sIwAyAH ca.
;rlc9
(defrule assign_samucciwam_for_RaRTI_sambanXaH_karmaNi
(test (or (eq (slot-val-match avy word ca) TRUE) (eq (slot-val-match avy word cEva) TRUE)))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE))
(test (> (count-facts sup) 2))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?s3 sup)(?a avy)(?w wif))
(and
(or (eq ?a:word ca)
    (eq ?a:word cEva)
)
(< ?w:id ?a:id)
(< ?s1:id ?s2:id)
(= ?s1:viBakwiH 6)
(= ?s1:viBakwiH ?s2:viBakwiH)
(= ?s3:viBakwiH 1)
(eq ?s1:vacanam ?s2:vacanam)
;(eq ?s1:vacanam ?w:vacanam)
(= (- ?a:id ?s2:id) 1)
;(= (- ?s3:id ?w:id) 1)
(eq ?s3:vacanam ?w:vacanam)
)
(if (= ?s3:viBakwiH 1)
then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "RaRTI_sambanXaH"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s3:id " " ?s3:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc9 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam6"))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlc9 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam6"))
    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlc9 " ?k ?l crlf )

) 
 ))
;===========================================================================
;Added by pavan
;rAmaH yuxXAya wvarayA/vegena gacCawi.
;rlprayojana
(defrule assign_prayojanam_kriyAviSeRaNa
(not (and (test (= (count-viBakwi sup 4) 0)) (test (= (count-viBakwi kqw 4) 0)) (test (= (count-viBakwi waxXiwa 4) 0))))
;(test (= (count-list wif sakarmaka_XAwu_list.gdbm rt) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa)(?w wif kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaH "?s1" evaM "?w" wifanwAvyayakqxanweByaSca "?w" iwi.
	
(and (= (- ?w:id ?s1:id) 2) ;vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
     (= ?s1:viBakwiH 4);sarveRu subAxiRu waxeva "?s1" yaw cawurWyAM varwawe.
     (neq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:rt) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxasya "?w" kriyayA saha prayojana-saMbanXaH saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlprayojana " ?k ?l crlf )
)
)
;===========================================================================
;Added by pavan
;rAmaH yuxXAya gacCawi.
;rlprayojana
(defrule assign_prayojanam_verb
(not (and (test (= (count-viBakwi sup 4) 0)) (test (= (count-viBakwi kqw 4) 0)) (test (= (count-viBakwi waxXiwa 4) 0))))
;(test (= (count-list wif sakarmaka_XAwu_list.gdbm rt) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa)(?w wif kqw));sarveByaH supwaxXiwAnweByaH "?s1" iwi nAma xIyawe kqxanweByaH "?s1" evaM "?w" wifanwAvyayakqxanweByaSca "?w" iwi.


(and 
     (<> ?w:id ?s1:id) ;vAkye "?s1" "?w"- uBayoH sWAne pqWak BavewAm. 
     (= ?s1:viBakwiH 4);sarveRu subAxiRu waxeva "?s1" yaw cawurWyAM varwawe.
     ;(neq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:rt) "1")
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" paxasya "?w" kriyayA saha prayojana-saMbanXaH saMBavawi.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlprayojana " ?k ?l crlf )
)
)
;Added by pavan
;vArwAlApaM kurvanwaH Asan yaw manuRyAH weRAM PalAni wrotayiwvA nayanwi.
;rlyaw
(defrule assign_yaw_rel
(test (eq (slot-val-match avy word yaw) TRUE))
=>
(do-for-all-facts
((?a avy)(?w1 wif)(?w2 wif))
(and
(eq ?a:word yaw)
(> ?w2:id ?a:id)
(< ?w1:id ?a:id)
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI")) 
(printout bar "(" ?w1:id " " ?w1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlyaw " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w2:id " " ?w2:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlyaw " ?k ?l crlf )
)
)

;Added by pavan
;canxraH nAma BUpawiH prawivasawi sma
;rlnAma
(defrule assign_nAma_rel
(test (eq (slot-val-match avy word nAma) TRUE))
=>
(do-for-all-facts
((?a avy)(?s1 sup kqw)(?s2 sup kqw))
(and
(eq ?a:word nAma)
(> ?s2:id ?a:id)
(< ?s1:id ?a:id)
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prawiyogI")) 
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlnAma " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "anuyogI"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s2:id " " ?s2:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlnAma " ?k ?l crlf )
)
)
;===========================================================================
(agenda)
(run)
(facts)
(close bar)
(exit)
