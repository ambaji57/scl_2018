sub printscripts{

print "<script>\n
function analyse_noun_forms(encod,word){
  window.open('CGIURL/morph/morph.cgi?encoding='+encod+'&morfword='+word+'','popUpWindow','height=200,width=600,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes').focus();}\n

function generate_noun_forms(encod,prAwi,lifga,jAwi,level){
  window.open('CGIURL/skt_gen/noun/noun_gen.cgi?encoding='+encod+'&rt='+prAwi+'&gen='+lifga+'&jAwi='+jAwi+'&level='+level+'','popUpWindow','height=500,width=400,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes').focus();
}\n

function generate_kqw_forms(encod,vb,upasarga){
  window.open('CGIURL/skt_gen/kqw/kqw_gen.cgi?encoding='+encod+'&vb='+vb+'&upasarga='+upasarga+'','popUpWindow','height=500,width=400,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes').focus();
}\n

function generate_waxXiwa_forms(encod,rt,gen){
  window.open('CGIURL/skt_gen/waxXiwa/waxXiwa_gen.cgi?encoding='+encod+'&rt='+rt+'&gen='+gen+'','popUpWindow','height=500,width=400,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes').focus();
}\n

function generate_verb_forms(encod,rt,prayoga,upasarga,paxI){
  window.open('CGIURL/skt_gen/verb/verb_gen.cgi?encoding='+encod+'&vb='+rt+'&prayoga='+prayoga+'&upasarga='+upasarga+'&paxI='+paxI+'','popUpWindow','height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes').focus();
}\n

function show(word){
  window.open('CGIURL/SHMT/options1.cgi?word='+word+'','popUpWindow','height=500,width=400,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no, status=yes').focus(); } 

</script>\n";
}
1;
