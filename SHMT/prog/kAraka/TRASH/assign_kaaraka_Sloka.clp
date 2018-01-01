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
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w wif))
(and 
  (= ?s1:viBakwiH 1);सर्वेषु सुबादिषु तदेव "?s1" यत् प्रथमा-विभक्तौ वर्तते. 
  (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.अयम् आसीत् घोर-ग्रीष्म-समयः.
; <> changed to <; because in complex sentences such as rAmaH pATam paTawi Palam ca Kaxawi, Palam is taken as a karwA of PaTawi.
  (eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्.
  (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - उभयोः वचने समाने स्याताम्.
  (or 
    (and (eq ?w:puruRaH pra) (neq ?s1:rt yuRmax) (neq ?s1:rt asmax)) ;तिङन्तं प्रथम-पुरुषे स्यात्.
    (and (eq ?w:puruRaH ma) (eq ?s1:rt yuRmax)) ;यदि तिङन्तं मध्यम-पुरुषे तर्हि  "?s1"-पदस्य प्रातिपदिकं "युष्मद्" स्यात्.
    (and (eq ?w:puruRaH u) (eq ?s1:rt asmax));यदि तिङन्तं उत्तम-पुरुषे तर्हि  "?s1"-पदस्य प्रातिपदिकं "अस्मद्" स्यात्.
  )
  (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1"-पदं "?w"-क्रियायाः कर्त्ता संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl1 " ?k ?l crlf )

))
;===========================================================================
; Assign karwA_kwavawu
;rAmaH gqham gawavAn
;rlkvw
(defrule assign_karwA_kwavawu_karwqvAcya
(not (and (test (= (count-viBakwi sup 1) 0))(test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match kqw kqw_prawyayaH kwavawu) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w kqw))
(and 
  (= ?s1:viBakwiH 1);सर्वेषु सुबादिषु तदेव "?s1" यत् प्रथमा-विभक्तौ वर्तते. 
  (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.अयम् आसीत् घोर-ग्रीष्म-समयः.
  (eq ?w:kqw_prawyayaH kwavawu);तिङन्तं कर्तरि स्यात्.
  (= ?w:viBakwiH 1);तिङन्तं कर्तरि स्यात्.
  (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - उभयोः वचने समाने स्याताम्.
  (or (eq ?w:lifgam ?s1:lifgam);"?s1" "?w" - उभयोः वचने समाने स्याताम्.
      (eq ?s1:rt yuRmax)
      (eq ?s1:rt asmax))
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1"-पदं "?w"-क्रियायाः कर्त्ता संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlkvw " ?k ?l crlf )

))
;==========================================================================
;Added by sheetal
;rAmaH grAmam gawaH.
;rAmeNa grAmaH gawaH.
;rlkw
(defrule assign_karwA_kwa_karwqvAcya1
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (> (count-list kqw karwari_karmaNi_kwa_XAwu_list.gdbm kqw_vb_rt) 0))
(not (and (test (= (count-viBakwi sup 1) 0))(test (= (count-viBakwi waxXiwa 1) 0))))
;(not (test (> (count-list kqw sakarmaka_XAwu_list.gdbm kqw_vb_rt) 0))))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w kqw))
(and 
  (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.अयम् आसीत् घोर-ग्रीष्म-समयः.
  (eq ?w:kqw_prawyayaH kwa);तिङन्तं कर्तरि स्यात्.
  (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - उभयोः वचने समाने स्याताम्.
  (eq ?w:lifgam ?s1:lifgam);"?s1" "?w" - उभयोः वचने समाने स्याताम्.
  (eq (gdbm_lookup "karwari_karmaNi_kwa_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
  ;(neq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1"))
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
;rlkw
(defrule assign_karwA_kwa_karwqvAcya2
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (> (count-list kqw karwari_karmaNi_kwa_XAwu_list.gdbm kqw_vb_rt) 0))
(not (and (test (= (count-facts sup) 0))(test (= (count-facts waxXiwa) 0))))
;(not (test (> (count-list kqw sakarmaka_XAwu_list.gdbm kqw_vb_rt) 0))))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w kqw))
(and 
  (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.अयम् आसीत् घोर-ग्रीष्म-समयः.
  (eq ?w:kqw_prawyayaH kwa);तिङन्तं कर्तरि स्यात्.
  (eq (gdbm_lookup "karwari_karmaNi_kwa_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
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
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(not (and (test (= (count-viBakwi sup 1) 0))(test (= (count-viBakwi waxXiwa 1) 0))))
(not (test (> (count-list kqw sakarmaka_XAwu_list.gdbm kqw_vb_rt) 0)))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w kqw))
(and
  (= ?s1:viBakwiH 1) 
  (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.अयम् आसीत् घोर-ग्रीष्म-समयः.
  (eq ?w:kqw_prawyayaH kwa);तिङन्तं कर्तरि स्यात्.
  (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - उभयोः वचने समाने स्याताम्.
  (eq ?w:lifgam ?s1:lifgam);"?s1" "?w" - उभयोः वचने समाने स्याताम्.
  (neq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
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
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(not (and (test (= (count-viBakwi sup 3) 0))(test (= (count-viBakwi waxXiwa 3) 0))))
(not (test (> (count-list kqw sakarmaka_XAwu_list.gdbm kqw_vb_rt) 0)))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w kqw))
(and
  (= ?s1:viBakwiH 3) 
  (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.अयम् आसीत् घोर-ग्रीष्म-समयः.
  (eq ?w:kqw_prawyayaH kwa);तिङन्तं कर्तरि स्यात्.
  (= ?w:viBakwiH 1)
  ;(eq ?w:vacanam eka);"?s1" "?w" - उभयोः वचने समाने स्याताम्.
;The above condition is wrong. vacanam may be different.
; e.g. rAmEH hasiwam/kqwam/gawam.
  (eq ?w:lifgam napuM);"?s1" "?w" - उभयोः वचने समाने स्याताम्.
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
(<> ?s1:id ?w:id)
(eq ?w:prayogaH karwari)
(eq ?w:vacanam ?s1:vacanam)
(neq ?w:sanAxiH Nic)
(or 
   (eq ?w:puruRaH pra);तिङन्तं प्रथम-पुरुषे स्यात्.
   (and (eq ?w:puruRaH ma) (eq ?s1:rt yuRmax)) ;यदि तिङन्तं मध्यम-पुरुषे तर्हि  "?s1दस्य प्रातिपदिकं "युष्मद्" स्यात्.
   (and (eq ?w:puruRaH u) (eq ?s1:rt asmax));यदि तिङन्तं उत्तम-पुरुषे तर्हि  "?s1"-प प्रातिपदिकं "अस्मद्" स्यात्.
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
;(or (test (> (count-viBakwi sup 1) 0)) (test (> (count-viBakwi kqw 1) 0)) (test (> (count-viBakwi waxXiwa 1) 0)));प्रदत्त-वाक्ये न्यूनातिन्यूनमेकं पदं सुप्कृत्तद्धितान्तं प्रथमायामस्तीति निरीक्ष्यते.
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));तिङन्तं कर्मणि वाच्ये अस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
;((?s1 sup kqw waxXiwa) (?w wif avykqw kqw))
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
; for avykqw and kqw, we have to think about the condition.
; The condition of karmaNi/BAve will not work
(and 
  (= ?s1:viBakwiH 1) ;सर्वेषु सुबादिषु तदेव "?s1" यत् प्रथमा-विभक्तौ वर्तते.
  (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
; The following condition will not work with avykqw or kqw
  (eq ?w:prayogaH karmaNi);तिङन्तं कर्मणि स्यात्. 
  (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - उभयोः वचने समाने स्याताम्.
  (or 
    (eq ?w:puruRaH pra);तिङन्तं प्रथम-पुरुषे स्यात्.
    (and (eq ?w:puruRaH ma) (eq ?s1:rt yuRmax));यदि तिङन्तं मध्यम-पुरुषे तर्हि  "?s1"-पदस्य प्रातिपदिकं "युष्मद्" स्यात्.
    (and (eq ?w:puruRaH u) (eq ?s1:rt asmax));यदि तिङन्तं उत्तम-पुरुषे तर्हि  "?s1"-पदस्य प्रातिपदिकं "अस्मद्" स्यात्.
  )
  (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
  (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1"-पदं "?w"-क्रियायाः कर्म संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl3 " ?k ?l crlf )

))
;============================================================================
;Added by sheetal
;rAmeNa pATaH paTiwaH.
;rl4
(defrule assign_karma_of_kwAnwa_kriyA
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match kqw kqw_prawyayaH kwa) TRUE))
=>
(do-for-all-facts
((?s1 sup waxXiwa)(?w kqw))
(and 
  (= ?s1:viBakwiH 1) ;सर्वेषु सुबादिषु तदेव "?s1" यत् प्रथमा-विभक्तौ वर्तते.
  (<> ?s1:id ?w:id)
  (eq ?w:kqw_prawyayaH kwa);तिङन्तं कर्मणि स्यात्. 
  (eq ?w:vacanam ?s1:vacanam)
  (eq ?w:viBakwiH ?s1:viBakwiH)
  (eq ?w:lifgam ?s1:lifgam)
  (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1")
  (neq (gdbm_lookup "karwari_karmaNi_kwa_XAwu_list.gdbm" (fact-slot-value ?w kqw_vb_rt)) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1"-पदं "?w"-क्रियायाः कर्म संभवति.
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
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));तिङन्तं कर्मणि वाच्ये अस्तीति निरीक्ष्यते.
(test (eq (slot-val-match wif prayogaH BAve) TRUE));तिङन्तं भाव-वाच्ये अस्तीति निरीक्ष्यते.
)
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
  (= ?s1:viBakwiH 3);सर्वेषु सुबादिषु तदेव "?s1" यत् तृतीया-विभक्तौ वर्तते. 
  (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
  (or 
    (eq ?w:prayogaH karmaNi);तिङन्तं कर्मणि स्यात्. 
    (eq ?w:prayogaH BAve);तिङन्तं भावे स्यात्. 
  )
  (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः कर्त्ता संभवति.
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
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (> (count-list wif sakarmaka_XAwu_list.gdbm rt) 0));धातुः सकर्मकोस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
  (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते. 
  (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
  (eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्. 
  (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
  (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1") 
  (neq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" (fact-slot-value ?w rt)) "1");द्विकर्मक-धातुर्न स्यात्.
  (neq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" (fact-slot-value ?w rt)) "1");द्विकर्मक-धातुर्न स्यात्.
  (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w rt)) "1");धातुः सकर्मकः स्यात्.
  (neq ?w:rt iR2)
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः कर्म संभवति.
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
((?s1 sup waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
  (= ?s1:viBakwiH 2)
  ;(= (- ?w:id ?s1:id) 1)
  (eq ?w:prayogaH karwari)
  (eq ?w:rt iR2)
  )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः कर्म संभवति.
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
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (> (count-list wif sakarmaka_XAwu_list.gdbm rt) 0));धातुः सकर्मकोस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 kqw) (?w wif));सर्वेभ्यः कृदन्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and
  (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते.
  (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
  ;(neq ?s1:kqw_prawyayaH kwa);कृत्-प्रत्ययः "क्त" न भवेत् : saH api pUrNaM moxakaM grahIwum icCawi sma.Removed by AMBA, tested this sentence and it works. 17/1/2011.
  (eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्.
  (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
  (neq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" (fact-slot-value ?w rt)) "1");द्विकर्मक-धातुर्न स्यात्.
  (neq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" (fact-slot-value ?w rt)) "1");द्विकर्मक-धातुर्न स्यात्.
  (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w rt)) "1");धातुः सकर्मकः स्यात्.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः कर्म संभवति.
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
;(test (neq (slot-val-match kqw kqw_prawyayaH wumun) TRUE));कृत्-प्रत्ययः "तुमुन्" नास्तीति निरीक्ष्यते.
;=>
;(do-for-all-facts
;((?s1 sup ) (?wu avykqw)(?w wif kqw) );सर्वेभ्यः सुबन्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
;(and
;  (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते.
;  (< ?s1:id ?wu:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
;  (< ?wu:id ?w:id)
;  (eq ?w:rt iR2)
;  (eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?wu rt)) "1")
;  (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
;)
;(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
;(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?wu:id " " ?wu:mid " ) " );"?w" पदस्य "?s1" पदं कर्म संभवति.
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
;(= (- ?w:id ?s1:id) 1)
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
(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0));कृत्-प्रत्ययोsव्ययकृत्सूच्यां अस्तीति निरीक्ष्यते.
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
(test (eq (slot-val-match sup rt icCuka) TRUE))
=>
(do-for-all-facts
((?s sup) (?a avykqw));सर्वेभ्यः तिङन्तकृदन्तेभ्यः "?w" इति नाम दीयते अव्ययकृदन्तेभ्यश्च "?w" एवं "?a" इति.

(and (eq ?a:kqw_prawyayaH wumun);कृत्-प्रत्ययः तुमुन् स्यात्. 
     (eq (- ?s:id ?a:id) 1)
     (eq ?s:rt icCuka)
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s:id " " ?s:mid " ) " );"?a" पदं "?w" पदेन सह प्रयोजनत्वेन संबद्धुमर्हति.
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
(<> ?s1:id ?w:id)
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
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 2) ;सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते.
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्. 
    (eq ?w:sanAxiH Nic);तिङन्तं णिचि स्यात्.
    (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1")
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः कर्म संभवति.
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
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));तिङन्तं णिचि वर्तत इति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 1);सर्वेषु सुबादिषु तदेव "?s1" यत् प्रथमा-विभक्तौ वर्तते. 
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्. 
    (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - उभयोः वचने समाने स्याताम्. 
    (or 
      (eq ?w:puruRaH pra);तिङन्तं प्रथम-पुरुषे स्यात्. 
      (and (eq ?w:puruRaH ma) (eq ?s1:rt yuRmax));यदि तिङन्तं मध्यम-पुरुषे तर्हि "?s1"-पदस्य प्रातिपदिकं "युष्मद्" स्यात्. 
      (and (eq ?w:puruRaH u) (eq ?s1:rt asmax));यदि तिङन्तं उत्तम-पुरुषे तर्हि "?s1"-पदस्य प्रातिपदिकं "अस्मद्" स्यात्.
    )
    (eq ?w:sanAxiH Nic);तिङन्तं णिचि स्यात्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojakakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः प्रयोजक-कर्त्ता संभवति.
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
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));तिङन्तं कर्मणि वाच्ये अस्तीति निरीक्ष्यते.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));तिङन्तं णिचि वर्तत इति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 1);सर्वेषु सुबादिषु तदेव "?s1" यत् प्रथमा-विभक्तौ वर्तते. 
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karmaNi);तिङन्तं कर्मणि स्यात्. 
    (eq ?w:vacanam ?s1:vacanam);"?s1" "?w" - उभयोः वचने समाने स्याताम्. 
    (or 
      (eq ?w:puruRaH pra);तिङन्तं प्रथम-पुरुषे स्यात्. 
      (and (eq ?w:puruRaH ma) (eq ?s1:rt yuRmax));यदि तिङन्तं मध्यम-पुरुषे तर्हि "?s1"-पदस्य प्रातिपदिकं "युष्मद्" स्यात्. 
      (and (eq ?w:puruRaH u) (eq ?s1:rt asmax));यदि तिङन्तं उत्तम-पुरुषे तर्हि "?s1"-पदस्य प्रातिपदिकं "अस्मद्" स्यात्.
    )
    (eq ?w:sanAxiH Nic);तिङन्तं णिचि स्यात्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojyakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः प्रयोज्य-कर्त्ता संभवति.
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
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));तिङन्तं णिचि वर्तत इति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते. 
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्. 
    (eq ?w:sanAxiH Nic);तिङन्तं णिचि स्यात्.
    (eq (gdbm_lookup "gawibuxXi_XAwu_list.gdbm" ?w:rt) "1");धातुर्गत्यादिषु(१/४/५२) वर्तेत.
    (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1")
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojyakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः प्रयोज्य-कर्त्ता संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl14 " ?k ?l crlf )

))
;===========================================================================
;Added by sheetal
;xampawyoH kalahaH mAm niwarAm upahAsayawi sma.
;rl15
(defrule assign_prayojya_karwA_karwqvAcya_akarmaka
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));तिङन्तं णिचि वर्तत इति निरीक्ष्यते.
(test (= (count-list wif sakarmaka_XAwu_list.gdbm rt) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते. 
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्. 
    (eq ?w:sanAxiH Nic);तिङन्तं णिचि स्यात्.
    (neq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" ?w:rt) "1")
    (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1")
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojyakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः प्रयोज्य-कर्त्ता संभवति.
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
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));तिङन्तं णिचि वर्तत इति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 3);सर्वेषु सुबादिषु तदेव "?s1" यत् तृतीया-विभक्तौ वर्तते. 
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्. 
    (eq ?w:sanAxiH Nic);तिङन्तं णिचि स्यात्.
    (neq (gdbm_lookup "gawibuxXi_XAwu_list.gdbm" ?w:rt) "1");धातुर्गत्यादिषु(१/४/५२) न भवेत्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojyakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः प्रयोज्य-कर्त्ता संभवति.
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
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));तिङन्तं कर्मणि वाच्ये अस्तीति निरीक्ष्यते.
(test (eq (slot-val-match wif sanAxiH Nic) TRUE));तिङन्तं णिचि वर्तत इति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 3);सर्वेषु सुबादिषु तदेव "?s1" यत् तृतीया-विभक्तौ वर्तते. 
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karmaNi);तिङन्तं कर्मणि स्यात्. 
    (eq ?w:sanAxiH Nic);तिङन्तं णिचि स्यात्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojakakarwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );;"?s1" पदं "?w" क्रियायाः प्रयोजक-कर्त्ता संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl17 " ?k ?l crlf )

))
;===========================================================================
; Assign gOna-muKyakarma
;rAmaH vexam paTawi
;rl18
(defrule assign_gONamuKyakarma_1karwqvAcya
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (> (count-list wif xvikarmaka_XAwu_list1.gdbm rt) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते. 
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्. 
    (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" ?w:rt) "1");द्विकर्मक-धातुः स्यात्.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः गौण-कर्म संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl18 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "muKyakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः मुख्य-कर्म संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl18 " ?k ?l crlf )

))
;===========================================================================
; Assign muKya-gONakarma
;rAmaH vexam paTawi
;rl19
(defrule assign_gONamuKyakarma_2karwqvAcya
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
(test (> (count-list wif xvikarmaka_XAwu_list2.gdbm rt) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते. 
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्. 
    (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" ?w:rt) "1");द्विकर्मक-धातुः स्यात्.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः गौण-कर्म संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl19 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "muKyakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः मुख्य-कर्म संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl19 " ?k ?l crlf )

))
;===========================================================================
; Assign muKyakarma
;rAmeNa ajA grAmam nIyawe
;rl20
(defrule assign_muKyakarma_2karmavAcya
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi kqw 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));तिङन्तं कर्मणि वाच्ये अस्तीति निरीक्ष्यते.
(test (> (count-list wif xvikarmaka_XAwu_list2.gdbm rt) 0));द्विकर्मक-धातुः स्यात्.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 1);सर्वेषु सुबादिषु तदेव "?s1" यत् प्रथमा-विभक्तौ वर्तते. 
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karmaNi);तिङन्तं कर्मणि स्यात्. 
    (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" ?w:rt) "1");द्विकर्मक-धातुः स्यात्.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः मुख्य-कर्म संभवति.
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
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));तिङन्तं कर्मणि वाच्ये अस्तीति निरीक्ष्यते.
(test (> (count-list wif xvikarmaka_XAwu_list2.gdbm rt) 0));द्विकर्मक-धातुः स्यात्.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and
    (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते.
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
    (eq ?w:prayogaH karmaNi);तिङन्तं कर्मणि स्यात्.
    (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list2.gdbm" ?w:rt) "1");द्विकर्मक-धातुः स्यात्.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः गौण-कर्म संभवति.
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
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));तिङन्तं कर्मणि वाच्ये अस्तीति निरीक्ष्यते.
(test (> (count-list wif xvikarmaka_XAwu_list1.gdbm rt) 0));द्विकर्मक-धातुः स्यात्.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and
    (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते.
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
    (eq ?w:prayogaH karmaNi);तिङन्तं कर्मणि स्यात्.
    (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" ?w:rt) "1");द्विकर्मक-धातुः स्यात्.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः मुख्य-कर्म संभवति.
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
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE));तिङन्तं कर्मणि वाच्ये अस्तीति निरीक्ष्यते.
(test (> (count-list wif xvikarmaka_XAwu_list1.gdbm rt) 0));द्विकर्मक-धातुः स्यात्.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताय च "?w" इति.
(and 
    (= ?s1:viBakwiH 1);सर्वेषु सुबादिषु तदेव "?s1" यत् प्रथमा-विभक्तौ वर्तते. 
    (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
    (eq ?w:prayogaH karmaNi);तिङन्तं कर्मणि स्यात्. 
    (neq ?w:sanAxiH Nic);तिङन्तं णिचि न स्यात्.
    (eq (gdbm_lookup "xvikarmaka_XAwu_list1.gdbm" ?w:rt) "1");द्विकर्मक-धातुः स्यात्.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "gONakarma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" क्रियायाः गौण-कर्म संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl23 " ?k ?l crlf )

))
;===========================================================================
;rAmaH xAwreNa pAxapam lunAwi
;rl24
(defrule assign_karaNa
(not (and (test (= (count-viBakwi sup 3) 0)) (test (= (count-viBakwi kqw 3) 0)) (test (= (count-viBakwi waxXiwa 3) 0))))
(test (> (count-list wif karaNa_XAwu_list.gdbm rt) 0));धातुः सकरणको वर्तत इति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif avykqw));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
(and (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
     (= ?s1:viBakwiH 3);सर्वेषु सुबादिषु तदेव "?s1" यत् तृतीया-विभक्तौ वर्तते.
     (eq (gdbm_lookup "karaNa_XAwu_list.gdbm" ?w:rt) "1");धातुः सकरणकः स्यात्.
     (neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियायाः करणं संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl24 " ?k ?l crlf )

)
)
;===========================================================================
;rAmaH SyAmena xAwreNa lunam pAxapam paSyawi
;rl25
(defrule assign_karaNa_kqw
(not (and (test (= (count-viBakwi sup 3) 0)) (test (= (count-viBakwi kqw 3) 0)) (test (= (count-viBakwi waxXiwa 3) 0))))
(test (> (count-list kqw karaNa_XAwu_list.gdbm kqw_vb_rt) 0));धातुः सकरणकः अस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w kqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यश्च "?s1" एवं "?w" इति.
(and (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
     (= ?s1:viBakwiH 3);सर्वेषु सुबादिषु तदेव "?s1" यत् तृतीया-विभक्तौ वर्तते.
     (eq (gdbm_lookup "karaNa_XAwu_list.gdbm" ?w:kqw_vb_rt) "1"));धातुः सकरणकः स्यात्.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियायाः करणं संभवति.
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
((?s1 sup kqw waxXiwa) (?w wif avykqw kqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यः "?s1" एवं "?w" तिङन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
(and (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
     (= ?s1:viBakwiH 3);सर्वेषु सुबादिषु तदेव "?s1" यत् तृतीया-विभक्तौ वर्तते.
(neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "hewuH"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियायाः हेतुः संभवति.
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
((?s1 avy sup kqw waxXiwa) (?w wif avykqw kqw));सर्वेभ्योsव्ययेभ्यः "?s1" इति नाम दीयते कृदन्ताव्ययकृदन्ततिङन्तेभ्यश्च "?w" इति.
(and 
;(= (- ?w:id ?s1:id) 1)
(<> ?s1:id ?w:id)
(eq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1");"?s1" पदं क्रियाविशेषणसूच्यां स्यात्
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "kriyAviSeRaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " "  ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियायाः क्रियाविशेषणं संभवति.
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
((?s1 sup waxXiwa) (?w wif avykqw kqw)(?s2 avy));सर्वेभ्योsव्ययेभ्यः "?s1" इति नाम दीयते कृदन्ताव्ययकृदन्ततिङन्तेभ्यश्च "?w" इति.
(and 
;(= (- ?w:id ?s1:id) 2) 
;(= (- ?w:id ?s2:id) 1)
(eq ?s2:rt na)
(eq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1"));"?s1" पदं क्रियाविशेषणसूच्यां स्यात्.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "kriyAviSeRaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियायाः क्रियाविशेषणं संभवति.
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
(or (test (> (count-list wif sampraxAna_XAwu_list.gdbm rt) 0));धातुः ससम्प्रदानकोsस्तीति निरीक्ष्यते. 
    (test (> (count-list avykqw sampraxAna_XAwu_list.gdbm rt) 0)));धातुः ससम्प्रदानकोsस्तीति निरीक्ष्यते. 
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif avykqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यः "?s1" एवं "?w" तिङन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
	
(and (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
     (= ?s1:viBakwiH 4);सर्वेषु सुबादिषु तदेव "?s1" यत् चतुर्थ्यां वर्तते. 
     (eq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:rt) "1");धातुः ससम्प्रदानको भवेत्..
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sampraxAnam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियायाः सम्प्रदानं संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl29 " ?k ?l crlf )

)
)
;========================================================================
;piwA rAmAya xawwam Palam KAxawi
;rl30
(defrule assign_sampraxAna_kqw
(not (and (test (= (count-viBakwi sup 4) 0)) (test (= (count-viBakwi kqw 4) 0)) (test (= (count-viBakwi waxXiwa 4) 0))))
(test (> (count-list kqw sampraxAna_XAwu_list.gdbm kqw_vb_rt) 0));धातुः ससम्प्रदानकोsस्तीति निरीक्ष्यते. 
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w kqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यश्च "?s1" एवं "?w" इति.

(and (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
     (= ?s1:viBakwiH 4);सर्वेषु सुबादिषु तदेव "?s1" यत् चतुर्थ्यां वर्तते.
     (eq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:kqw_vb_rt) "1"));धातुः ससम्प्रदानको भवेत्.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sampraxAnam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियायाः सम्प्रदानं संभवति.
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
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa) (?w wif kqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यः "?s1" एवं "?w" तिङन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
	
(and 
        (<> ?s2:id ?s1:id) ;वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
	(<> ?s1:id ?w:id)
     	(<> ?s2:id ?w:id)
     	(= ?s1:viBakwiH 4);सर्वेषु सुबादिषु तदेव "?s1" यत् चतुर्थ्यां वर्तते.
        (neq ?s2:rt kiFciw)
        (neq ?s2:rt asmax)
        (neq ?s2:rt yuRmax)
        (neq ?s2:rt sarva); 
     	(neq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:rt) "1")
     	(neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s2:word) "1") ; this is added to avoid the relation between yuxXAya and vegena/wvarayA in yuxXAya vegena gacCawi
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "wAxarWyam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid ") " );"?s1" पदस्य "?w" क्रियया सह तादर्थ्य-संबन्धः संभवति.
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
((?s1 sup kqw waxXiwa) (?w wif avykqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यः "?s1" एवं "?w" तिङन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
(and (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
     (= ?s1:viBakwiH 5);सर्वेषु सुबादिषु तदेव "?s1" यत् पञ्चम्यां वर्तते.
     (eq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:rt) "1");धातुः सापादानकः स्यात्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "apAxAnam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियाया अपादानं संभवति.
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
(and (<> ?s1:id ?w:id) (= ?s1:viBakwiH 5)
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
((?s1 avywaxXiwa) (?w wif kqw avykqw));सर्वेभ्योsव्ययतद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्तकृदन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
(and 
;(= (- ?w:id ?s1:id) 1)
(eq ?s1:waxXiwa_prawyayaH wasil)
(or (eq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:rt) "1");धातुः सापादानकः स्यात्.
    (eq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:kqw_vb_rt) "1"));धातुः सापादानकः स्यात्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "apAxAnam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियाया अपादानं संभवति.
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
(not (and (test (= (count-list wif apAxAna_XAwu_list.gdbm rt) 0))(test (= (count-list avykqw apAxAna_XAwu_list.gdbm rt) 0))))
=>
(do-for-all-facts
((?s1 sup waxXiwa) (?w wif avykqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यः "?s1" एवं "?w" तिङन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
; kqw is deleted from s1 by Amba. See the modified rule below.
(and (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
     (= ?s1:viBakwiH 5);सर्वेषु सुबादिषु तदेव "?s1" यत् पञ्चम्यां वर्तते.
     (neq (gdbm_lookup "apAxAna_XAwu_list.gdbm" ?w:rt) "1")
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
(not (and (test (= (count-list wif apAxAna_XAwu_list.gdbm rt) 0))(test (= (count-list avykqw apAxAna_XAwu_list.gdbm rt) 0))))
=>
(do-for-all-facts
((?s1 kqw) (?w wif avykqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यः "?s1" एवं "?w" तिङन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
(and (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
     (eq ?s1:kqw_prawyayaH lyut)
;This is added to stop assigning hewu to a Sawq+5
;mAwaH mama piwA kva Aswe
; Here mAwaH: mA+Sawq+5 is assigned hewu of Aswe.
; To stop it, lyut is added.
; If any other kqws are also possible, they are to be listed here.
     (= ?s1:viBakwiH 5);सर्वेषु सुबादिषु तदेव "?s1" यत् पञ्चम्यां वर्तते.
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
;(or (test (> (count-viBakwi sup 7) 0)) (test (> (count-viBakwi kqw 7) 0)) (test (> (count-viBakwi waxXiwa 7) 0)));प्रदत्त-वाक्ये न्यूनातिन्यूनमेकं पदं सुप्कृत्तद्धितान्तं सप्तम्यामस्तीति निरीक्ष्यते.
; Removed kqw 7 to avoid unnecessary answers with sawi sapwamii in case of gacCawi
(not (and (test (= (count-viBakwi sup 7) 0))(test (= (count-viBakwi waxXiwa 7) 0))))
; (test (= (count-viBakwi kqw 7) 0))))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w wif kqw avykqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते तिङन्तकृदन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
(and (= ?s1:viBakwiH 7);सर्वेषु सुबादिषु तदेव "?s1" यत् सप्तम्यां वर्तते. 
   (<> ?s1:id ?w:id));वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "aXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियाया अधिकरणं संभवति.
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
(<> ?s1:id ?w:id)
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
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" एवं "?s2" इति नाम्नी दीयेते कृदन्तेभ्यश्च "?s1" इति.Added 'kqw' for "prakqwInAM hiwEH yukwam"
(and (= ?s1:viBakwiH 6);सर्वेषु सुबादिषु तदेव "?s1" यत् षष्ठ्यां वर्तते. 
     (= (- ?s2:id ?s1:id) 1) ;"?s1" पदं "?s2" पदतः एकेन पूर्वं स्यात्.
; sarvanAmas can not have RaRTI sambanXa
;	(neq ?s2:rt asmax); xyUwa-Asakwasya me ... from Panchatantra
;	(neq ?s2:rt yuRmax)
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "RaRTIsambanXaH"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid ") " );"?s1" पदं "?s2" पदेन सह षठ्या संबध्यते.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl38 " ?k ?l crlf )

)
)
;========================================================================
;rAmeNa prajAyAH SAsanam kriyawe
;rl39
(defrule assign_kAraka_RaRTI
(not (and (test (= (count-viBakwi sup 6) 0)) (test (= (count-viBakwi kqw 6) 0)) (test (= (count-viBakwi waxXiwa 6) 0))))
(test (> (count-list kqw RaRTI_kqw_list.gdbm kqw_prawyayaH) 0));कृत्-प्रत्ययः कर्त्तृकर्मण्योः षष्ठीं ध्रियत इति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?s2 kqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यश्च "?s1" एवं "?s2" इति.
(and (= ?s1:viBakwiH 6);सर्वेषु सुबादिषु तदेव "?s1" यत् षष्ठ्यां वर्तते. 
     (<> ?s1:id ?s2:id));वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
     (eq (gdbm_lookup "RaRTI_kqw_list.gdbm" ?s2:kqw_vb_rt) "1")

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid ") " );"?s1" पदं "?s2" पदस्य कर्त्ता कर्म वा संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl39 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid ") " );"?s1" पदं "?s2" पदस्य कर्त्ता कर्म वा संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl39 " ?k ?l crlf )
)
)
;===========================================================================
;grAmasya samIpe paSavaH caranwi.
;rl40
(defrule assign_upapaxa_verb_rel
(test (> (count-list avy upapaxa_verb_list.gdbm word) 0));अव्यय-पदं "उपपद-सूच्यां" अस्तीति निरक्ष्यते.
=>

(do-for-all-facts
((?a avy) (?s sup kqw waxXiwa) (?w wif kqw avykqw));सर्वेभ्योsव्ययेभ्यः "?a" इति नाम दीयते सुप्कृत्तद्धितान्तेभ्यः "?s" इति तिङन्तेभ्यश्च "?w" इति. 
(and
;(= (- ?a:id ?s:id) 1);"?s" पदं "?a" पदाद् एकेन पूर्वं स्यात्.
(<> ?s:id ?w:id);वाक्ये "?s" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(<> ?a:id ?w:id);वाक्ये "?a" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(eq (gdbm_lookup "upapaxa_verb_list.gdbm" ?a:rt) "1");"?a" पदं "उपपद-सूच्यां" स्यात्.
; In case of avyayas we take rt and not word, since normalisation takes place in rt
 (or
   (and (eq (gdbm_lookup "upapaxa_2_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 2));यदि "?a" पदं "उपपद_२_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिर्द्वितीया स्यात्.
   (and (eq (gdbm_lookup "upapaxa_3_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 3));यदि "?a" पदं "उपपद_३_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः तृतीया स्यात्.
   (and (eq (gdbm_lookup "upapaxa_4_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 4));यदि "?a" पदं "उपपद_४_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिश्चतुर्थी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_5_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 5));यदि "?a" पदं "उपपद_५_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः पञ्चमी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_6_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 6));यदि "?a" पदं "उपपद_६_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिष्षष्ठी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_7_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 7));यदि "?a" पदं "उपपद_७_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः सप्तमी स्यात्.
))
(bind ?k (gdbm_lookup "upapaxa_avy_verb_left_relation.gdbm" ?a:rt));उपपद-सम्बन्धायोचिता सङ्ख्या "?k" इत्यतस्मिन् स्थाप्यते.

(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?a:id " " ?a:mid ") " );"?a" पदेन सह "?s" पदस्य "उपपद-अव्यय" संबन्धेन संबद्धुमर्हति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl40 " ?k ?l crlf )

(bind ?k (gdbm_lookup "upapaxa_avy_verb_right_relation.gdbm" ?a:rt));उपपद-सम्बन्धायोचिता सङ्ख्या "?k" इत्यतस्मिन् स्थाप्यते.
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid ") " );"?w" क्रियापदेन सह "?a" पदं "upapaxa_avy_verb" संबन्धेन संबद्धुमर्हति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl40 " ?k ?l crlf )

)
)
;===========================================================================
;grAmam aBiwaH vqkRAH sanwi.
;rl41
(defrule assign_noun_upapaxa_verb_rel
(test (> (count-list sup upapaxa_verb_list.gdbm rt) 0));सुबन्त-पदं "उपपद-सूच्यां" अस्तीति निरक्ष्यते.
=>

(do-for-all-facts
((?us sup) (?s sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुबन्तेभ्यः "?us" एवं "?s" इति नाम्नी दीयेते कृत्तद्धितान्तेभ्यः "?s" इति तिङन्तेभ्यश्च "?w" इति. 
(and
(<> ?us:id ?s:id);"?s" पदं "?us" पदाद् एकेन पूर्वं स्यात्.
(<> ?s:id ?w:id);वाक्ये "?s" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(<> ?us:id ?w:id);वाक्ये "?us" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(eq (gdbm_lookup "upapaxa_verb_list.gdbm" ?us:rt) "1");"?us" पदं "उपपद-सूच्यां" स्यात्.
 (or
   (and (eq (gdbm_lookup "upapaxa_2_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 2));यदि "?us" पदं "उपपद_२_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिर्द्वितीया स्यात्.
   (and (eq (gdbm_lookup "upapaxa_3_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 3));यदि "?us" पदं "उपपद_३_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः तृतीया स्यात्.
   (and (eq (gdbm_lookup "upapaxa_4_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 4));यदि "?us" पदं "उपपद_४_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिश्चतुर्थी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_5_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 5));यदि "?us" पदं "उपपद_५_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः पञ्चमी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_6_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 6));यदि "?us" पदं "उपपद_६_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिष्षष्ठी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_7_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 7));यदि "?us" पदं "उपपद_७_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः सप्तमी स्यात्.
))
(bind ?k (gdbm_lookup "upapaxa_noun_verb_left_relation.gdbm" ?us:rt));उपपद-सम्बन्धायोचिता सङ्ख्या "?k" इत्यतस्मिन् स्थाप्यते.

(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?us:id " " ?us:mid ") " );"?us" पदेन सह "?s" पदं "उपपद-अव्यय" संबन्धेन संबद्धुमर्हति. 
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl41 " ?k ?l crlf )

(bind ?k (gdbm_lookup "upapaxa_noun_verb_right_relation.gdbm" ?us:rt));उपपद-सम्बन्धायोचिता सङ्ख्या "?k" इत्यतस्मिन् स्थाप्यते.
(printout bar "(" ?us:id " " ?us:mid " " ?k " " ?w:id " " ?w:mid ") " );"?w" पदेन सह "?us" पदं "noun_upapaxa_avy_verb" संबन्धेन संबद्धुमर्हति. 
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl41 " ?k ?l crlf )

)
)
;===========================================================================
;rAmeNa saha sIwA vanam gacCawi.
;rl42
(defrule assign_upapaxa_noun_rel
(test (> (count-list avy upapaxa_noun_list.gdbm word) 0));अव्यय-पदं "उपपद-सूच्यां" अस्तीति निरक्ष्यते.
=>
(do-for-all-facts
((?a avy) (?s sup kqw waxXiwa) (?s1 sup kqw waxXiwa));सर्वेभ्योsव्ययेभ्यः "?a" इति नाम दीयते सुप्कृत्तद्धितान्तेभ्यः "?s" एवं "?s1" इति. 
(and 
;(= (- ?a:id ?s:id) 1);"?s" पदं "?a" पदाद् एकेन पूर्वं स्यात्.
(<> ?s:id ?s1:id);वाक्ये "?s" "?s1"- उभयोः स्थाने पृथक् भवेताम्. 
(<> ?s1:id ?a:id);वाक्ये "?s1" "?a"- उभयोः स्थाने पृथक् भवेताम्.
(<> ?s1:viBakwiH 8);वाक्ये "?s1" "?a"- उभयोः स्थाने पृथक् भवेताम्.
(eq (gdbm_lookup "upapaxa_noun_list.gdbm" ?a:rt) "1");"?a" पदं "उपपद-सूच्यां" स्यात्.
;(= (- ?s1:id ?a:id) 1) 
(or
   (and (eq (gdbm_lookup "upapaxa_2_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 2));यदि "?a" पदं "उपपद_२_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिर्द्वितीया स्यात्.
   (and (eq (gdbm_lookup "upapaxa_3_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 3));यदि "?a" पदं "उपपद_३_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः तृतीया स्यात्.
   (and (eq (gdbm_lookup "upapaxa_4_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 4));यदि "?a" पदं "उपपद_४_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिश्चतुर्थी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_5_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 5));यदि "?a" पदं "उपपद_५_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः पञ्चमी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_6_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 6));यदि "?a" पदं "उपपद_६_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिष्षष्ठी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_7_list.gdbm" ?a:rt) "1") (= ?s:viBakwiH 7));यदि "?a" पदं "उपपद_७_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः सप्तमी स्यात्.
)
)
(bind ?k (gdbm_lookup "upapaxa_avy_noun_left_relation.gdbm" ?a:rt));उपपद-सम्बन्धायोचिता सङ्ख्या "?k" इत्यतस्मिन् स्थाप्यते.
(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?a:id " " ?a:mid ") " );"?a" पदेन सह "?s" पदं "upapaxa_avy" संबन्धेन संबद्धुमर्हति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl42 " ?k ?l crlf )

(bind ?k (gdbm_lookup "upapaxa_avy_noun_right_relation.gdbm" ?a:rt));उपपद-सम्बन्धायोचिता सङ्ख्या "?k" इत्यतस्मिन् स्थाप्यते.
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s1:id " " ?s1:mid ") " );"?s1" पदेन सह "?a" पदं "upapaxa_avy_noun" संबन्धेन संबद्धुमर्हति.
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
(not (and (test (= (count-list sup upapaxa_noun_list.gdbm rt) 0));सुबन्त-पदं "उपपद-सूच्यां" अस्तीति निरक्ष्यते.
   (test (= (count-list kqw upapaxa_noun_list.gdbm rt) 0));कृदन्त-पदं "उपपद-सूच्यां" अस्तीति निरक्ष्यते.
))
=>

(do-for-all-facts
((?us sup kqw) (?s sup kqw waxXiwa) (?s1 sup kqw waxXiwa));सर्वेभ्यः सुप्कृदन्तेभ्यः "?us" "?s" एवं "?s1" इति नामानि दीयन्ते तद्धितेभ्यश्च "?s" एवं "?s1" इति. 
; us: noun_upapaxa, e.g. saxqSaH
; lagnaH is a kqw, hence kqw is added in us
(and 
;(= (- ?us:id ?s:id) 1);"?s" पदं "?us" पदाद् एकेन पूर्वं स्यात्.
(<> ?us:id ?s1:id);वाक्ये "?us" "?s1"- उभयोः स्थाने पृथक् भवेताम्. 
(<> ?s1:id ?s:id);वाक्ये "?s1" "?s"- उभयोः स्थाने पृथक् भवेताम्.
(= ?s1:viBakwiH ?us:viBakwiH); वाक्ये "?us" "?s1"- उभयोर्विभक्ती समाने स्याताम्.
(eq ?s1:vacanam ?us:vacanam);"?s1" "?us" - उभयोः वचने समाने स्याताम्. 
(or
(eq ?s1:lifgam ?us:lifgam);"?s1" "?us" - उभयोः लिङ्गे समाने स्याताम्. 
(eq ?s1:rt yuRmax);"?s1" पदस्य प्रातिपदिकं "युष्मद्" स्यात्.
(eq ?s1:rt asmax);"?s1" पदस्य प्रातिपदिकं "अस्मद्" स्यात्.
(eq ?us:rt yuRmax);"?us" पदस्य प्रातिपदिकं "युष्मद्" स्यात्.
(eq ?us:rt asmax);"?us" पदस्य प्रातिपदिकं "अस्मद्" स्यात्.
)
(or
   (and (eq (gdbm_lookup "upapaxa_2_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 2));यदि "?us" पदं "उपपद_२_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिर्द्वितीया स्यात्.
   (and (eq (gdbm_lookup "upapaxa_3_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 3));यदि "?us" पदं "उपपद_२_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः तृतीया स्यात्.
   (and (eq (gdbm_lookup "upapaxa_4_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 4));यदि "?us" पदं "उपपद_२_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिश्चतुर्थी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_5_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 5));यदि "?us" पदं "उपपद_२_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः पञ्चमी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_6_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 6));यदि "?us" पदं "उपपद_२_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिष्षष्ठी स्यात्.
   (and (eq (gdbm_lookup "upapaxa_7_list.gdbm" ?us:rt) "1") (= ?s:viBakwiH 7));यदि "?us" पदं "उपपद_२_सूच्याम्" अस्ति चेत् "?s" पदस्य विभक्तिः सप्तमी स्यात्.
)
(eq (gdbm_lookup "upapaxa_noun_list.gdbm" ?us:rt) "1")
)
(bind ?k (gdbm_lookup "upapaxa_noun_noun_left_relation.gdbm" ?us:rt));उपपद-सम्बन्धायोचिता सङ्ख्या "?k" इत्यतस्मिन् स्थाप्यते.
(printout bar "(" ?s:id " " ?s:mid " " ?k " " ?us:id " " ?us:mid ") " );"us" पदेन सह "?s" पदं "upapaxa_noun" संबन्धेन संबद्धुमर्हति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl43 " ?k ?l crlf )
(bind ?k (gdbm_lookup "upapaxa_noun_noun_right_relation.gdbm" ?us:rt));उपपद-सम्बन्धायोचिता सङ्ख्या "?k" इत्यतस्मिन् स्थाप्यते.
(printout bar "(" ?us:id " " ?us:mid " " ?k " " ?s1:id " " ?s1:mid ") " );"?s1" पदेन सह "?us" पदं "upapaxa_noun_noun" संबन्धेन संबद्धुमर्हति.
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
((?s1 kqw) (?s2 sup kqw waxXiwa));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s2" इति नाम दीयते कृदन्तेभ्यश्च "?s1" एवं "?s2" इति. 
(and 
(<> ?s1:id ?s2:id);"?s1" पदं "?s2" पदतः पूर्वं स्यात्.
;(= (- ?s2:id ?s1:id) 1)
(= ?s1:viBakwiH ?s2:viBakwiH);उभयोर्विभक्ती समाने स्याताम्. 
(eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - उभयोः वचने समाने स्याताम्. 
(or (eq ?s1:lifgam ?s2:lifgam);"?s1" "?s2" - उभयोः लिङ्गे समाने स्याताम्.
    (eq ?s2:rt asmax)
    (eq ?s2:rt yuRmax)
)
; This should be generalise further to handle any sarvanAma.
; pronouns can not have viSeRaNas.

      (neq ?s2:rt kim)
;) pronouns can have viSeRaNas. 'kim' can't have a viSeRaNa.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "viSeRaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid " ) " );"?s1" पदं "?s2" पदस्य विशेषणं भवितुमर्हति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl44 " ?k ?l crlf )

))
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
(test (eq (slot-val-match wif prayogaH karwari) TRUE));तिङन्तं कर्तरि वाच्ये अस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
((?s2 kqw) (?s1 sup kqw waxXiwa)(?w wif));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यः "?s1" एवं "?s2" इति तिङन्तेभ्यश्च "?w" इति. 
(and 
	(<> ?s2:id ?s1:id) ;"?s2" पदं "?s1" पदतः पश्चात् स्यात्.
	(= ?s1:viBakwiH 1)(= ?s2:viBakwiH 1);उभे प्रथमायां स्यात्. 
	(eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - उभयोः वचने समाने स्याताम्. 
	(or (eq ?s2:kqw_prawyayaH Sawq);कृत्-प्रत्ययः "शतृ" स्यात्.
	    (eq ?s2:kqw_prawyayaH SAnac)
        )
;	(eq ?s1:lifgam ?s2:lifgam);"?s1" "?s2" - उभयोः लिङ्गे समाने स्याताम्.;commented for : aham rela-yAwrAm kurvan Asam.
	(<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
	(<> ?s2:id ?w:id);वाक्ये "?s2" "?w"- उभयोः स्थाने पृथक् भवेताम्.
	(eq ?w:prayogaH karwari);तिङन्तं कर्तरि स्यात्.
	(eq ?w:vacanam ?s1:vacanam);"?w" "?s1" - उभयोः वचने समाने स्याताम्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samAnakAlaH"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?w" पदेन सह" ?s2" पदं समानकालीनत्वेन योक्तुमर्हति.
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
((?s1 sup waxXiwa) (?s2 sup waxXiwa kqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" "?s2" इति नाम्नी दीयेते. 
; kqw is added to account for (by AMBA)
;wam hasanwam vilokya sarve swabXAH jAwAH.
(and 
(<> ?s1:id ?s2:id);"?s1" पदं "?s2" पदतः पूर्वं स्यात्.
;(or 
 ;(= (- ?s2:id ?s1:id) 2)
 ;(= (- ?s2:id ?s1:id) 1)
;); it can be 1 or 2, in case there is a shashti rel in between. In fact there can be any no of words in between when a kqw is used as a wif. 'saH gqham gawvA snAnam kqwvA pATaSAlAm AgawaH.'
(= ?s1:viBakwiH ?s2:viBakwiH);उभयोःविभक्ती समाने स्याताम्. 
(eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - उभयोः वचने समाने स्याताम्.
(neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s1:word) "1")
(neq (gdbm_lookup "kriyAviSeRaNa.gdbm" ?s2:word) "1");yaH gAyawrI-manwram niwyam na japawi.
(or 
(eq ?s1:lifgam ?s2:lifgam);"?s1" "?s2" - उभयोः लिङ्गे समाने स्याताम्.
   ;  (eq ?s1:rt yuRmax);"?s1" पदस्य प्रातिपदिकं "युष्मद्" स्यात्. How can s1 be a sarvanAma? -- Amba -- sunxaraH aham ...
   ;  (eq ?s1:rt asmax);"?s1" पदस्य प्रातिपदिकं "अस्मद्" स्यात्.
     (eq ?s2:rt yuRmax)
     (eq ?s2:rt asmax); sunxaraH aham
)
(and (neq ?s2:rt yaw)
    (neq ?s2:rt waw)
)
)


(bind ?k (gdbm_lookup "kAraka_num.gdbm" "viSeRaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?s2:id " " ?s2:mid " ) " );"?s1" पदं "?s2" पदस्य विशेषणं संभवति.
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
;(= (- ?s:id ?a:id) 1)
(or (eq ?a:rt awIva)
    (eq ?a:rt kimapi))
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "viSeRaNam"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s:id " " ?s:mid " ) " );"?s1" पदं "?s2" पदस्य विशेषणं संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl46a " ?k ?l crlf )

))
;======================================================================
;rl47
; Test sentences:
;saH SvewaH aswi.
;vexAH pramANam sanwi.
;neharO asya prawikriyA kA AsIw.
(defrule assign_noun_samAnAXikaraNa
(not (and (test (= (count-viBakwi sup 1) 0))(test (= (count-viBakwi kqw 1) 0))(test (= (count-viBakwi waxXiwa 1) 0))))
(test (> (count-list wif BU_as_vixyawe_list.gdbm rt) 0))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa)(?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" एवं "?s2" इति नाम्नी दीयेते तिङन्तेभ्यश्च "?w" इति. 
(and 
(<> ?s1:id ?s2:id);"?s1" पदं "?s2" पदतः पश्चात् स्यात्.
(<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(< (- ?w:id ?s1:id) 3) ;वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(= ?s1:viBakwiH 1) (= ?s2:viBakwiH 1);उभे पदे प्रथमायां स्याताम्. 
(or (eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - उभयोः वचने समाने स्याताम्.  
;We have to list/handle the exceptional cases such as: vexAH pramANam sanwi, separately.
    (eq ?s2:word vexAH)
)
(eq ?w:vacanam ?s2:vacanam);"?s1" "?w" - उभयोः वचने समाने स्याताम्.

(or 
    (and 
         (eq ?w:puruRaH pra);तिङन्तं प्रथम-पुरुषे स्यात्. 
         (eq ?s1:lifgam ?s2:lifgam);
    )
    (and (eq ?w:puruRaH ma) (eq ?s2:rt yuRmax));यदि तिङन्तं मध्यम-पुरुषे तर्हि "?s2"-पदस्य प्रातिपदिकं "युष्मद्" स्यात्. 
    (and (eq ?w:puruRaH u) (eq ?s2:rt asmax));यदि तिङन्तं उत्तम-पुरुषे तर्हि "?s2"-पदस्य प्रातिपदिकं "अस्मद्" स्यात्.
    (and (eq ?w:puruRaH pra) (eq ?s2:word vexAH))
 )
(eq (gdbm_lookup "BU_as_vixyawe_list.gdbm" ?w:rt) "1"));धातुर्भ्वादि-सूच्यां विद्येत.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्त्ता-समानाधिकरणं संभवति.
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
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa)(?w kqw));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" एवं "?s2" इति नाम्नी दीयेते तिङन्तेभ्यश्च "?w" इति. 
(and 
(<> ?s1:id ?s2:id);"?s1" पदं "?s2" पदतः पश्चात् स्यात्.
(<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(< (- ?w:id ?s1:id) 3) ;वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(<> ?s2:id ?w:id);वाक्ये "?s2" "?w"- उभयोः स्थाने पृथक् भवेताम्.
(= ?s1:viBakwiH 1) (= ?s2:viBakwiH 1);उभे पदे प्रथमायां स्याताम्. 
(eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - उभयोः वचने समाने स्याताम्.  
;We have to list/handle the exceptional cases such as: vexAH pramANam sanwi, separately.
(eq ?w:vacanam ?s2:vacanam);"?s1" "?w" - उभयोः वचने समाने स्याताम्.

(neq ?s2:rt kim) ;Added for : neharO asya kA prawikriyA AsIw.
(eq (gdbm_lookup "BU_as_vixyawe_list.gdbm" ?w:kqw_vb_rt) "1"));धातुर्भ्वादि-सूच्यां विद्येत.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्त्ता-समानाधिकरणं संभवति.
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
((?s1 sup waxXiwa) (?s2 sup kqw waxXiwa)(?a avykqw)(?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" एवं "?s2" इति नाम्नी दीयेते तिङन्तेभ्यश्च "?w" इति. 
(and
(<> ?s2:id ?s1:id)
;(= (- ?a:id ?s2:id) 1)
;(= (- ?w:id ?a:id) 1)
(eq ?s1:viBakwiH ?s2:viBakwiH)
(eq ?s1:vacanam ?s2:vacanam) 
(eq ?a:kqw_prawyayaH wumun)
(eq ?w:rt iR2)
(eq ?w:prayogaH karwari)
(eq (gdbm_lookup "BU_as_vixyawe_list.gdbm" ?a:rt) "1"));धातुर्भ्वादि-सूच्यां विद्येत.

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " );"?s1" पदं "?w" पदस्य कर्त्ता-समानाधिकरणं संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl47b " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्त्ता-समानाधिकरणं संभवति.
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
((?s1 sup waxXiwa) (?s2 sup kqw waxXiwa)(?a avykqw)(?w wif));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" एवं "?s2" इति नाम्नी दीयेते तिङन्तेभ्यश्च "?w" इति. 
(and
(<> ?s2:id ?s1:id)
;(= (- ?a:id ?s2:id) 1)
;(= (- ?w:id ?a:id) 1)
(= ?s1:viBakwiH 3) 
(= ?s2:viBakwiH 1)
(eq ?a:kqw_prawyayaH wumun)
(eq ?w:rt iR2)
(eq ?w:prayogaH karmaNi)
(eq (gdbm_lookup "BU_as_vixyawe_list.gdbm" ?a:rt) "1"))
 
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " );"?s1" पदं "?w" पदस्य कर्त्ता-समानाधिकरणं संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl47c " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्त्ता-समानाधिकरणं संभवति.
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
(<> ?s1:id ?s2:id);"?s1" पदं "?s2" पदतः पश्चात् स्यात्.
(<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(<> ?s2:id ?w:id)
;(or (eq ?s1:word samyak)(eq ?s1:word kim)) ; kim is removed by Amba, since kim is a noun
(eq ?s1:word samyak)
(eq (gdbm_lookup "BU_as_vixyawe_list.gdbm" ?w:rt) "1"))
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्त्ता-समानाधिकरणं संभवति.
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
((?s1 sup kqw waxXiwa) (?s2 sup kqw waxXiwa)(?w wif avykqw));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" एवं "?s2" इति नाम्नी दीयेते तिङन्तेभ्यश्च "?w" इति. 
(and
(<> ?s1:id ?s2:id);"?s1" पदं "?s2" पदतः पश्चात् स्यात्.
(<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
;(< ?s2:id ?w:id);वाक्ये "?s2" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(= ?s1:viBakwiH 2)(= ?s2:viBakwiH 2)
(neq ?s2:rt kim); Added for : vqkRAH kam vArwAlApam kurvanwi sma.
(eq ?s1:vacanam ?s2:vacanam);"?s1" "?s2" - उभयोः वचने समाने स्याताम्.
(eq ?s1:lifgam ?s2:lifgam);"?s1" "?s2" - उभयोः लिङ्गे समाने स्याताम्.
(eq (gdbm_lookup "kq_gaNa_Axi_list.gdbm" ?w:rt) "1"))


(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्म-समानाधिकरणं संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl48 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "vikAryakarma"))
(printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्म-समानाधिकरणं संभवति.
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
(<> ?s1:id ?s2:id) 
;(= (- ?w:id ?s1:id) 1) 
(<> ?s2:id ?w:id)
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
;(or (test (> (count-viBakwi sup 2) 0)) (test (> (count-viBakwi kqw 2) 0)) (test (> (count-viBakwi waxXiwa 2) 0)));प्रदत्त-वाक्ये न्यूनातिन्यूनमेकं पदं सुप्कृत्तद्धितान्तं द्वितीयायामस्तीति निरीक्ष्यते.
(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0));कृत्-प्रत्ययोsव्ययकृत्सूच्यां स्यात्.
(test (> (count-list avykqw sakarmaka_XAwu_list.gdbm rt) 0));धातुः सकर्मकः स्यात्.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w avykqw));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते अव्ययकृदन्तेभ्यश्च "?w" इति. 
(and (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते.
   (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
   (neq ?w:kqw_prawyayaH wumun) 
(eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" ?w:rt) "1");धातुः सकर्मकः स्यात्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्म संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl50 " ?k ?l crlf )
(printout bar "(-1 -1 0 " ?w:id " " ?w:mid " ) " );प्रदत्त-वाक्ये "?w" पदस्य कोsपि कर्त्ता न संभवति.
(printout bar "#rl50 " ?k 0 crlf )

))
;==========================================================================

;saH prasannaH BUwvA mAwaram avaxaw.

;rl50a
(defrule assign_kawq_samAnAXikaraNa_BUwvA
(not (and (test (= (count-viBakwi sup 1) 0)) (test (= (count-viBakwi kqw 1) 0)) (test (= (count-viBakwi waxXiwa 1) 0))))
(test (eq (slot-val-match avykqw word BUwvA) TRUE))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w avykqw));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते अव्ययकृदन्तेभ्यश्च "?w" इति. 
(and (= ?s1:viBakwiH 1);
(or 
;(= (- ?w:id ?s1:id) 1) 
;(= (- ?w:id ?s1:id) 2) 
)
;   (< ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
(eq ?w:word BUwvA);
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwqsamAnAXikaraNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्म संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl50a " ?k ?l crlf )
(printout bar "(-1 -1 0 " ?w:id " " ?w:mid " ) " );प्रदत्त-वाक्ये "?w" पदस्य कोsपि कर्त्ता न संभवति.
(printout bar "#rl50a " ?k 0 crlf )

))
;===================================================================================================================
;Added by sheetal
;rl51
(defrule assign_karma_of_wumuna_no_iR2
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0));कृत्-प्रत्ययोsव्ययकृत्सूच्यां स्यात्.
(test (> (count-list avykqw sakarmaka_XAwu_list.gdbm rt) 0));धातुः सकर्मकः स्यात्.
;(and (test (neq (slot-val-match wif rt iR2) TRUE))
;   (test (neq (slot-val-match sup rt icCuka) TRUE))
;   (test (neq (slot-val-match kqw kqw_vb_rt iR2) TRUE)))
(test (eq (slot-val-match avykqw kqw_prawyayaH wumun) TRUE))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w avykqw));सर्वेभ्यः सुप्कृत्तद्धितान्तेभ्यः "?s1" इति नाम दीयते अव्ययकृदन्तेभ्यश्च "?w" इति. 
(and (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते.
     (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
(eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" ?w:rt) "1");धातुः सकर्मकः स्यात्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्म संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl51 " ?k ?l crlf )
(printout bar "(-1 -1 0 " ?w:id " " ?w:mid " ) " );प्रदत्त-वाक्ये "?w" पदस्य कोsपि कर्त्ता न संभवति.
(printout bar "#rl51 " ?k 0 crlf )

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
(<> ?s2:id ?s1:id)
;(= (- ?w:id ?s1:id) 1)
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
(defrule assign_pUrvakAlInawva
(test (> (count-list avykqw avy_kqw_list.gdbm kqw_prawyayaH) 0));कृत्-प्रत्ययोsव्ययकृत्सूच्यां अस्तीति निरीक्ष्यते.
(or (test (eq (slot-val-match avykqw kqw_prawyayaH kwvA) TRUE))(test (eq (slot-val-match avykqw kqw_prawyayaH lyap) TRUE)))
=>
(do-for-all-facts
((?w wif avykqw kqw) (?a avykqw));सर्वेभ्यः तिङन्तेभ्यः "?w" इति नाम दीयते अव्ययकृदन्तेभ्यश्च "?w" एवं "?a" इति. 
; w can not be kqw. It should only by avykqw
(and 
    (or 
      (eq ?a:kqw_prawyayaH kwvA);कृत् क्त्वा स्यात्. 
      (eq ?a:kqw_prawyayaH lyap);कृत् ल्यप् स्यात्.
    )
    (<> ?w:id ?a:id);वाक्ये "?w" पदं "?a" पदतः पश्चात् भवेत्.
    (neq ?w:rt as2) ; kwvA can not relate to as2, e.g. gawvA aswi is not possible 
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "pUrvakAlaH"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" पदं "?w" पदेन सह पूर्वकालीनत्वेन संबद्धुमर्हति.
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
((?w wif) (?a avykqw));सर्वेभ्यः तिङन्तकृदन्तेभ्यः "?w" इति नाम दीयते अव्ययकृदन्तेभ्यश्च "?w" एवं "?a" इति.

(and (eq ?a:kqw_prawyayaH wumun);कृत्-प्रत्ययः तुमुन् स्यात्. 
     (<> ?w:id ?a:id);वाक्ये "?w" पदं "?a" पदतः पश्चात् भवेत्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" पदं "?w" पदेन सह प्रयोजनत्वेन संबद्धुमर्हति.
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
((?w kqw) (?a avykqw));सर्वेभ्यः तिङन्तकृदन्तेभ्यः "?w" इति नाम दीयते अव्ययकृदन्तेभ्यश्च "?w" एवं "?a" इति.

(and (eq ?a:kqw_prawyayaH wumun);कृत्-प्रत्ययः तुमुन् स्यात्. 
     (<> ?w:id ?a:id);वाक्ये "?w" पदं "?a" पदतः पश्चात् भवेत्.
     (neq ?w:kqw_vb_rt iR2)
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" पदं "?w" पदेन सह प्रयोजनत्वेन संबद्धुमर्हति.
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
((?w avykqw) (?a avykqw));सर्वेभ्यः तिङन्तकृदन्तेभ्यः "?w" इति नाम दीयते अव्ययकृदन्तेभ्यश्च "?w" एवं "?a" इति.

(and (eq ?a:kqw_prawyayaH wumun);कृत्-प्रत्ययः तुमुन् स्यात्. 
     (<> ?w:id ?a:id);वाक्ये "?w" पदं "?a" पदतः पश्चात् भवेत्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" पदं "?w" पदेन सह प्रयोजनत्वेन संबद्धुमर्हति.
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
((?w wif) (?a avykqw));सर्वेभ्यः तिङन्तकृदन्तेभ्यः "?w" इति नाम दीयते अव्ययकृदन्तेभ्यश्च "?w" एवं "?a" इति.

(and (eq ?a:kqw_prawyayaH wumun);कृत्-प्रत्ययः तुमुन् स्यात्. 
     ;(= (- ?w:id ?a:id) 1);वाक्ये "?w" पदं "?a" पदतः पश्चात् भवेत्.
)

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sahAyakakriyA"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?a" पदं "?w" पदेन सह प्रयोजनत्वेन संबद्धुमर्हति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl55a " ?k ?l crlf )

)
)
;==========================================================================
;rAmaH grAmam gacCan wqNam spqSawi.
;rl56
(defrule assign_karma_karwqkqxanwa
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0)) (test (= (count-viBakwi waxXiwa 2) 0))))
(test (> (count-list kqw karwq_kqw_list.gdbm kqw_prawyayaH) 0));धातुः कर्त्तृ-कृत्-सूच्यामस्तीति निरीक्ष्यते.
(or (test (> (count-list kqw sakarmaka_XAwu_list.gdbm rt) 0));धातुः सकर्मकोsस्तीति निरीक्ष्यते.
    (test (> (count-list kqw sakarmaka_XAwu_list.gdbm kqw_vb_rt) 0)));धातुः सकर्मकोsस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa) (?w kqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यश्च "?s1" एवं "?w" इति. 
(and (= ?s1:viBakwiH 2);सर्वेषु सुबादिषु तदेव "?s1" यत् द्वितीया-विभक्तौ वर्तते. 
     (<> ?s1:id ?w:id);वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
(eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" ?w:kqw_vb_rt) "1");धातुः सकर्मकः स्यात्.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्म संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl56 " ?k ?l crlf )
(printout bar "(-1 -1 0 " ?w:id " " ?w:mid " ) ");प्रदत्त-वाक्ये "?w" पदस्य कोsपि कर्त्ता न संभवति.
(printout bar "#rl56 " ?k 0 crlf )
))
;==========================================================================
;rAmeNa KAxiwam Palam maXuram AsIw
;haswena KAxiwam Palam maXuram AsIw
;rl57
(defrule assign_karwA_sakarmaka_karma_BAvakqxanwa
(not (and (test (= (count-viBakwi sup 2) 0)) (test (= (count-viBakwi kqw 2) 0))))
(or (test (> (count-list kqw karma_kqw_list.gdbm kqw_prawyayaH) 0));धातुः कर्म-कृत्-सूच्यामस्तीति निरीक्ष्यते.
(test (> (count-list kqw BAva_kqw_list.gdbm kqw_prawyayaH) 0));धातुः भाव-कृत्-सूच्यामस्तीति निरीक्ष्यते.
)
=>
(do-for-all-facts
((?s1 sup kqw) (?w kqw ));सर्वेभ्यः सुबन्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यश्च "?s1" एवं "?w" इति. 
(and (= ?s1:viBakwiH 3);सर्वेषु सुबादिषु तदेव "?s1" यत् तृतीया-विभक्तौ वर्तते. 
     (<> ?s1:id ?w:id); वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्.
(eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" ?w:kqw_vb_rt) "1");धातुः सकर्मकः स्यात्.
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) ");"?s1" पदं "?w" पदस्य कर्त्ता संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl57 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) " );"?s1" पदं "?w" पदस्य कर्त्ता संभवति.
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
((?s1 sup kqw) (?w kqw avykqw ));सर्वेभ्यः सुबन्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यश्च "?s1" एवं "?w" इति. 
(and (= ?s1:viBakwiH 3);सर्वेषु सुबादिषु तदेव "?s1" यत् तृतीया-विभक्तौ वर्तते. 
     ;(= (- ?w:id ?s1:id) 1)
     (or (eq ?w:word yokwuM)(and(eq ?w:rt yukwa)(eq ?w:kqw_prawyayaH kwa)))
)
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "sambanXaH"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid " ) ");"?s1" पदं "?w" पदस्य कर्त्ता संभवति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl57a " ?k ?l crlf )
))
;=====================================================================================
;mohanaH awra AgacCawi.
;rl58
(defrule assign_avy_verb
(test (> (count-list avy avy_verb_list.gdbm rt) 0));अव्यय-पदम् "अव्यय-सूच्यां" अस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
((?a avy) (?w wif avykqw kqw));सर्वेभ्योsव्ययेभ्यः "?a" इति नाम दीयते तिङन्तेभ्यश्च "?w" इति. 
(and
(<> ?a:id ?w:id);वाक्ये "?a" "?w"- उभयोः स्थाने पृथक् भवेताम्.
(neq ?a:rt api)(neq ?a:rt eva)(neq ?a:rt yaxA)(neq ?a:rt yaxi)(neq ?a:rt warhi)(neq ?a:rt yAvaw)(neq ?a:rt iwi)
(eq (gdbm_lookup "avy_verb_list.gdbm" ?a:rt) "1"));"?a" पदम् "अव्यय-सूच्यां" स्यात्.
(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt));अव्यय-सम्बन्धायोचिता सङ्ख्या "?k" इत्येतस्मिन् स्थाप्यते.
(printout bar "(" ?a:id " " ?a:mid " "  ?k " " ?w:id " " ?w:mid ") " );"?w" पदेन सह "?a" पदं "avyaya_relation_verb" संबन्धेन संबद्धुमर्हति.
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
((?a avy) (?w wif kqw avykqw));सर्वेभ्योsव्ययेभ्यः "?a" इति नाम दीयते तिङन्तेभ्यश्च "?w" इति. 
(and
(= (- ?a:id ?w:id) 1) ;वाक्ये "?a" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
(or (eq ?a:rt na)(eq ?a:rt eva)(eq ?a:rt api)(eq ?a:rt sma))
(eq (gdbm_lookup "avy_verb_list.gdbm" ?a:rt) "1"));"?a" पदम् "अव्यय-सूच्यां" स्यात्.
(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt));अव्यय-सम्बन्धायोचिता सङ्ख्या "?k" इत्येतस्मिन् स्थाप्यते.
(printout bar "(" ?a:id " " ?a:mid " "  ?k " " ?w:id " " ?w:mid ") " );"?w" पदेन सह "?a" पदं "avyaya_relation_verb" संबन्धेन संबद्धुमर्हति.
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rl58a " ?k ?l crlf )
)
)
;===========================================================================
;rAmaH eva vanam gacCawi.
;rl59
(defrule assign_avy_noun
(test (> (count-list avy avy_noun_list.gdbm word) 0));अव्यय-पदम् "अव्यय-सूच्यां" अस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
((?a avy) (?s sup kqw waxXiwa));सर्वेभ्योsव्ययेभ्यः "?a" इति नाम दीयते सुप्कृत्तद्धितान्तेभ्यः "?s" इति. 
(and
    ;(= (- ?a:id ?s:id) 1);"?s" पदं "?a" पदाद् एकेन पूर्वं स्यात्.
    (neq ?a:word iva)
    (neq ?a:word ca)
    (neq ?a:word iwi)
(eq (gdbm_lookup "avy_noun_list.gdbm" ?a:rt) "1"));"?a" पदम् "अव्यय-सूच्यां" स्यात्.
(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt));अव्यय-सम्बन्धायोचिता सङ्ख्या "?k" इत्येतस्मिन् स्थाप्यते.

(printout bar "(" ?a:id " " ?a:mid " "  ?k " " ?s:id " " ?s:mid ") " );"?s" पदेन सह "?a" पदं "avyaya_relation_noun" संबन्धेन संबद्धुमर्हति.
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
((?a avy) (?s1 sup) (?s2 sup kqw));सर्वेभ्योsव्ययेभ्यः "?a" इति नाम दीयते सुप्कृत्तद्धितान्तेभ्यः "?s" इति. 
(and
;(= (- ?a:id ?s1:id) 1);"?s" पदं "?a" पदाद् एकेन पूर्वं स्यात्.
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
(test (> (count-list avy avy_avy_list.gdbm word) 0));अव्यय-पदम् "अव्यय-सूच्यां" अस्तीति निरीक्ष्यते.
=>
(do-for-all-facts
((?a avy) (?b avy avykqw));सर्वेभ्योsव्ययेभ्यः "?a" एवं "?b" इति नाम्नी दीयेते. 
(and
;(= (- ?a:id ?b:id) 1);"?b" पदं "?a" पदाद् एकेन पूर्वं स्यात्. 
(eq (gdbm_lookup "avy_avy_list.gdbm" ?a:rt) "1"));"?a" पदम् "अव्यय-सूच्यां" स्यात्.
(bind ?k (gdbm_lookup "avy_relation_list.gdbm" ?a:rt));अव्यय-सम्बन्धायोचिता सङ्ख्या "?k" इत्येतस्मिन् स्थाप्यते.

(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?b:id " " ?b:mid ") " );"?b" पदेन सह "?a" पदं "avyaya_relation_avy" संबन्धेन संबद्धुमर्हति.
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
;(= (- ?a:id ?w:id) 1)
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
(<> ?a:id ?w:id) 
(eq ?a:word iwi)
(eq (gdbm_lookup "sakarmaka_XAwu_list.gdbm" (fact-slot-value ?w rt)) "1") 
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
(<> ?a:id ?w:id) 
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
(<> ?a:id ?w2:id)
(<> ?a:id ?w1:id)
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
;(= (- ?s2:id ?s1:id) 1)
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
(or (eq ?a:word namaH)(eq ?a:word svaswi)(eq ?a:word svaXA)(eq ?a:word svAhA)))
;(= (- ?a:id ?s:id) 1))
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
(<> ?w:id ?a:id)
(<> ?w1:id ?a:id)
;(eq (gdbm_lookup "avy_verb_list.gdbm" ?a:rt) "1");"?a" पदम् "अव्यय-सूच्यां" स्यात्.
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
(<> ?w:id ?a:id)
(<> ?w1:id ?a:id)
;(eq (gdbm_lookup "avy_verb_list.gdbm" ?a:rt) "1");"?a" पदम् "अव्यय-सूच्यां" स्यात्.
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
(<> ?yw:id ?cew:id)
(<> ?cw:id ?cew:id)
(<> ?yw:id ?yaxi:id)
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
(if (<> ?yaxA:id ?waxA:id)
    then 
    (<> ?yaxA:id ?yw:id)
    (<> ?yw:id ?waxA:id)
    (<> ?waxA:id ?ww:id)
    else
    (<> ?waxA:id ?ww:id)
    (<> ?ww:id ?yaxA:id)
    (<> ?yaxA:id ?yw:id)
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
(<> ?ww:id ?yw:id)
(<> ?ww:id ?yaxA:id)
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
(<> ?yw:id ?waxA:id)
(<> ?yw:id ?ww:id)
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
    (<> ?yw:id ?ww:id)
    (<> ?yw:id ?wpi:id)
    (<> ?ww:id ?ypi:id))

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
(<> ?yw:id ?wpi:id)
(<> ?ww:id ?wpi:id))

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
(<> ?yw:id ?ywH:id)
(<> ?yw:id ?wwH:id)
(<> ?ww:id ?wwH:id))

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
(<> ?yw:id ?yaxi:id)
(<> ?aw:id ?api:id)
(<> ?yw:id ?api:id)
(<> ?aw:id ?yaxi:id))

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
(<> ?yw:id ?yvw:id)
(<> ?ww:id ?wvw:id)
(<> ?yw:id ?wvw:id)
(<> ?ww:id ?yvw:id)
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
(<> ?yw:id ?yaWA:id)
(<> ?ww:id ?waWA:id)
(<> ?yw:id ?waWA:id)
(<> ?ww:id ?yaWA:id)
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
(<> ?Sawq:id ?w:id)
(<> ?sup:id ?Sawq:id)
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
(<> ?Sawq:id ?w:id)
(<> ?sup:id ?Sawq:id)
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
(<> ?Sawq:id ?w:id)
(<> ?sup:id ?Sawq:id)
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
(<> ?Sawq:id ?w:id)
(<> ?sup:id ?Sawq:id)
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
(test (eq (slot-val-match avy word ca) TRUE))
(test (eq (slot-val-match wif prayogaH karwari) TRUE))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a avy)(?w wif))
(and
(eq ?a:word ca)
(<> ?s1:id ?s2:id)
;(= (- ?a:id ?s2:id) 1)
(<> ?a:id ?w:id)
(= ?s1:viBakwiH ?s2:viBakwiH)
;(= (- ?a:id ?s2:id) 1)(neq ?w:vacanam ?s1:vacanam)
;(neq ?w:vacanam ?s2:vacanam)
;commented by Madhavachar.T.V
; Following conditions added by Madhvachar
; AMBA: the function should be generalised to take into account xvivacanam as well as bahuvacanam
;(neq ?w:vacanam ?s2:vacanam)
;(neq ?w:vacanam ?s1:vacanam)
(eq ?w:prayogaH karwari)
)
   (if (= ?s1:viBakwiH 1)
       then
       (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
       (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
       (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
       (printout bar "#rlca " ?k ?l crlf )

       (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
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
(test (eq (slot-val-match avy word ca) TRUE))
;(test (eq (slot-val-match wif prayogaH karwari) TRUE))
(not (and (test (= (count-facts sup) 0))(test (= (count-facts kqw) 0))(test (= (count-facts waxXiwa) 0))))
=>
(do-for-all-facts
((?s1 sup kqw waxXiwa)(?s2 sup kqw waxXiwa)(?a avy)(?w wif avykqw kqw))
(and
(eq ?a:word ca)
(<> ?s1:id ?s2:id)
;(= (- ?a:id ?s2:id) 1)
(<> ?a:id ?w:id)
(= ?s1:viBakwiH ?s2:viBakwiH)
)
   (if (= ?s1:viBakwiH 2)
       then
       (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
       (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
       (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
       (printout bar "#rlcak " ?k ?l crlf )

       (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
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
(<> ?s1:id ?s2:id)
;(= (- ?a:id ?s2:id) 1)
(<> ?a:id ?w:id)
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
(<> ?a:id ?w1:id)
(<> ?a:id ?w2:id)
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
(<> ?s1:id ?s2:id)
;(= (- ?a:id ?s2:id) 1)
(<> ?a:id ?w:id)
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
(and(eq ?a:word vA)(= (- ?s2:id ?s1:id) 1)(= (- ?a:id ?s2:id) 1)
 (<> ?a:id ?w:id)(= ?s1:viBakwiH ?s2:viBakwiH)
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
(test (eq (slot-val-match avy word ca) TRUE))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a avy)(?w wif))
(and
(eq ?a:word ca)
(<> ?s1:id ?s2:id)
;(= (- ?a:id ?s2:id) 1)
(<> ?a:id ?w:id)
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
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
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
(test (eq (slot-val-match avy word ca) TRUE))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a avy)(?s3 sup))
(and
(eq ?a:word ca)
(<> ?s1:id ?s2:id)
;(= (- ?a:id ?s2:id) 1)
;(= (- ?s3:id ?a:id) 1)
(= ?s1:viBakwiH ?s2:viBakwiH)
(eq ?s1:vacanam ?s2:vacanam)
(eq ?s1:lifgam ?s2:lifgam)
(= ?s2:viBakwiH ?s3:viBakwiH)
(eq ?s2:vacanam ?s3:vacanam)
(eq ?s2:lifgam ?s3:lifgam)
)
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "viSeRaNam"))
    (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s3:id " " ?s3:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlc1a " ?k ?l crlf )
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc1a " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc1a " ?k ?l crlf )
))
;===================================================================================
;Added by sheetal
;
;rlc2
(defrule assign_samucciwam_for_karaNAxi
(test (eq (slot-val-match avy word ca) TRUE))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a avy)(?w wif avykqw kqw))
(and(eq ?a:word ca)
(<> ?s2:id ?s1:id)
(<> ?a:id ?s2:id)
(<> ?a:id ?w:id)(= ?s1:viBakwiH ?s1:viBakwiH)(eq ?s1:vacanam ?s2:vacanam))
(if (= ?s1:viBakwiH 3)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc2" ?k ?l crlf ) 
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )
   )
(if (= ?s1:viBakwiH 4)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "sampraxAnam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc2 " ?k ?l crlf ) 
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )
   )
(if (= ?s1:viBakwiH 4)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc2 " ?k ?l crlf ) 
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )
   )
(if (= ?s1:viBakwiH 5)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "apAxAnam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc2 " ?k ?l crlf ) 
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc2 " ?k ?l crlf )
   )
(if (= ?s1:viBakwiH 6)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "RaRTIsambanXaH"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc2 " ?k ?l crlf ) 
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
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
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
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
(test (eq (slot-val-match avy word ca) TRUE))
(test (> (count-facts wif) 1))
=>
(do-for-all-facts
((?a avy)(?w1 wif)(?w2 wif))
(and
(eq ?a:word ca)
(<> ?a:id ?w2:id)
(<> ?w1:id ?w2:id)
(eq ?w1:puruRaH ?w2:puruRaH)
)
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?w1:id " " ?w1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlcw " ?k ?l crlf )

    (printout bar "(" ?w2:id " " ?w2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlcw " ?k ?l crlf )
))
;===================================================================================
;Added by sheetal
;modified by Madhavachar.T.V(eq ?w1:puruRaH ?w2:puruRaH)(eq ?w1:vacanam ?w2:vacanam)
;rAmaH pATam paTawi Palam ca KAxawi.
;rlcw1
(defrule assign_samucciwam_for_wif_2
(test (eq (slot-val-match avy word ca) TRUE))
(test (> (count-facts wif) 1))
=>
(do-for-all-facts
((?a avy)(?w1 wif)(?w2 wif))
(and
(eq ?a:word ca)
(<> ?a:id ?w1:id)
(<> ?a:id ?w2:id)
(eq ?w1:puruRaH ?w2:puruRaH)
(eq ?w1:vacanam ?w2:vacanam)
)
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?w1:id " " ?w1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlcw1 " ?k ?l crlf )

    (printout bar "(" ?w2:id " " ?w2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlcw1 " ?k ?l crlf )
))
;===================================================================================
;rlsamb
(defrule assign_samboXyaH
(not (and (test (= (count-viBakwi sup 8) 0))(test (= (count-viBakwi kqw 8) 0))(test (= (count-viBakwi waxXiwa 8) 0))))
=>
(do-for-all-facts
((?s sup kqw waxXiwa) (?w wif));सर्वेभ्यः सुबन्तेभ्यः "?s" इति नाम दीयते तिङन्तेभ्यश्च "?w" इति.
(and
(= ?s:viBakwiH 8)
(<> ?s:id ?w:id));वाक्ये  "?s" "?w"- उभयोः स्थाने पृथक् भवेताम्.

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
;(= (- ?s1:id ?s:id) 1)
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
   ;(= (- ?w:id ?a:id) 1)
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
 ((?s1 waxXiwa) (?w wif ));सर्वेभ्योsव्ययेभ्यः "?s1" इति नाम दीयते कृदन्ताव्ययकृदन्ततिङन्तेभ्यश्चति.w" इ 
 (and
  (= ?s1:viBakwiH 1) ;
  (<> ?s1:id ?w:id)
  (eq ?s1:waxXiwa_prawyayaH vaw)
 )

 (bind ?k (gdbm_lookup "kAraka_num.gdbm" "kriyA_viSeRaNam"))
 (printout bar "(" ?s1:id " " ?s1:mid " "  ?k " " ?w:id " " ?w:mid ") " );"?s1" पदं "?w" क्रियायाः क्रियाविशेषणं संभवति.
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
;(= (- ?a1:id ?s1:id) 1)
;(= (- ?a2:id ?s2:id) 1)
(<> ?a2:id ?w:id)
(<> ?a1:id ?a2:id)
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

;added by MADHAVACHAR .T.V.
;rAmaH vanam gacCawi sIwA ca.
;rlc7
(defrule assign_samucciwam_for_wif_aXyAhAra
(test (eq (slot-val-match avy word ca) TRUE))
(test (eq (slot-val-match wif prayogaH karwari) TRUE))
(test (> (count-facts sup) 1))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?a avy)(?w wif))
(and
(eq ?a:word ca)
(<> ?a:id ?w:id)
(<> ?s1:id ?s2:id)
(eq ?s1:viBakwiH ?s2:viBakwiH)
(eq ?s1:vacanam ?s2:vacanam)
(eq ?s1:vacanam ?w:vacanam)
;(= (- ?a:id ?s2:id) 1)
;(= (- ?s2:id ?w:id) 1)
)
    (bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))

    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc7 " ?k ?l crlf )

    (printout bar "(" ?s2:id " " ?s2:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (printout bar "#rlc7 " ?k ?l crlf )

(if (= ?s1:viBakwiH 1)
then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karwA"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlc7 " ?k ?l crlf )
)
(if (= ?s1:viBakwiH 2)
then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "karma"))
(printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
(bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
(printout bar "#rlc7 " ?k ?l crlf )
)
(if (= ?s1:viBakwiH 3)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "karaNam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc7" ?k ?l crlf )
)

(if (= ?s1:viBakwiH 4)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "sampraxAnam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc7" ?k ?l crlf )
)
(if (= ?s1:viBakwiH 5)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "apAxAnam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc7" ?k ?l crlf )
)
(if (= ?s1:viBakwiH 7)
          then
           (bind ?k (gdbm_lookup "kAraka_num.gdbm" "aXikaraNam"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?w:id " " ?w:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc7" ?k ?l crlf )
)
)
)
;======================================================================
;added by MADHAVACHAR.T.V.
;rAmasya gqhaM aswi sIwAyAH ca.
;rlc8
(defrule assign_samucciwam_for_RaRTI_sambanXaH
(test (eq (slot-val-match avy word ca) TRUE))
(test (eq (slot-val-match wif prayogaH karwari) TRUE))
(test (> (count-facts sup) 2))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?s3 sup)(?a avy)(?w wif))
(and
(eq ?a:word ca)
(<> ?w:id ?a:id)
(<> ?s1:id ?s2:id)
(= ?s1:viBakwiH 6)
(= ?s1:viBakwiH ?s2:viBakwiH)
(= ?s3:viBakwiH 1)
(eq ?s1:vacanam ?s2:vacanam)
;(eq ?s1:vacanam ?w:vacanam)
;(= (- ?a:id ?s2:id) 1)
;(= (- ?s3:id ?w:id) 1)
(eq ?s3:vacanam ?w:vacanam)
)
(if (= ?s3:viBakwiH 1)
then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "RaRTI_sambanXaH"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s3:id " " ?s3:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc8 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlc8 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
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
(test (eq (slot-val-match avy word ca) TRUE))
(test (eq (slot-val-match wif prayogaH karmaNi) TRUE))
(test (> (count-facts sup) 2))
=>
(do-for-all-facts
((?s1 sup)(?s2 sup)(?s3 sup)(?a avy)(?w wif))
(and
(eq ?a:word ca)
(<> ?w:id ?a:id)
(<> ?s1:id ?s2:id)
(= ?s1:viBakwiH 6)
(= ?s1:viBakwiH ?s2:viBakwiH)
(= ?s3:viBakwiH 1)
(eq ?s1:vacanam ?s2:vacanam)
;(eq ?s1:vacanam ?w:vacanam)
;(= (- ?a:id ?s2:id) 1)
;(= (- ?s3:id ?w:id) 1)
(eq ?s3:vacanam ?w:vacanam)
)
(if (= ?s3:viBakwiH 1)
then
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "RaRTI_sambanXaH"))
           (printout bar "(" ?a:id " " ?a:mid " " ?k " " ?s3:id " " ?s3:mid " ) " )
           (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
           (printout bar "#rlc9 " ?k ?l crlf )
(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
    (printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?a:id " " ?a:mid " ) " )
    (bind ?l (gdbm_lookup "kAraka_name_dev.gdbm" ?k))
    (printout bar "#rlc9 " ?k ?l crlf )

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "samucciwam"))
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
((?s1 sup kqw waxXiwa)(?w wif kqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यः "?s1" एवं "?w" तिङन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
	
(and 
     (<> ?w:id ?s1:id)
     (= ?s1:viBakwiH 4);सर्वेषु सुबादिषु तदेव "?s1" यत् चतुर्थ्यां वर्तते.
     (neq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:rt) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदस्य "?w" क्रियया सह प्रयोजन-संबन्धः संभवति.
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
((?s1 sup kqw waxXiwa)(?w wif kqw));सर्वेभ्यः सुप्तद्धितान्तेभ्यः "?s1" इति नाम दीयते कृदन्तेभ्यः "?s1" एवं "?w" तिङन्ताव्ययकृदन्तेभ्यश्च "?w" इति.
	
(and 
     (<> ?w:id ?s1:id) ;वाक्ये "?s1" "?w"- उभयोः स्थाने पृथक् भवेताम्. 
     (= ?s1:viBakwiH 4);सर्वेषु सुबादिषु तदेव "?s1" यत् चतुर्थ्यां वर्तते.
     (neq (gdbm_lookup "sampraxAna_XAwu_list.gdbm" ?w:rt) "1"))

(bind ?k (gdbm_lookup "kAraka_num.gdbm" "prayojanam"))
(printout bar "(" ?s1:id " " ?s1:mid " " ?k " " ?w:id " " ?w:mid ") " );"?s1" पदस्य "?w" क्रियया सह प्रयोजन-संबन्धः संभवति.
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
(<> ?w2:id ?a:id)
(<> ?w1:id ?a:id)
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
(<> ?s2:id ?a:id)
(<> ?s1:id ?a:id)
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
