#!PERLPATH -I LIB_PERL_PATH/

#  Copyright (C) 2010-2016 Amba Kulkarni (ambapradeep@gmail.com)
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later
#  version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

use GDBM_File;

tie(%upaviB,GDBM_File,"$ARGV[0]/upaviB.gdbm",GDBM_READER,0644) || die "Can't open $ARGV[0]/upaviB.dbm for reading";

$/ = "\n\n";

while($in = <STDIN>){
   @in = split(/\n/,$in);
   $i = 0;
   for($i=0; $i<= $#in; $i++){
       if($in[$i] =~ /<rel_nm:prawiyogI|upapaxasambanXaH>/) {

          $in[$i] =~ /<relata_pos:([0-9]+)>/;
          $relata_pos = $1;

          $rel_pos_less_1 = $relata_pos - 1;
          $in[$rel_pos_less_1] =~ /word:([^>]+)/;
          $rel_word = $1;

          $in[$i] =~ /viBakwiH:([^>]+)/;
          $viBakwiH = $1;

          $new_viBakwiH = &get_viBakwiH($rel_word, $viBakwiH);
          $in[$i] =~ s/<viBakwiH:$viBakwiH>/<viBakwiH:$new_viBakwiH>/;
       }
# In case of gONa karma relation, the hindi parsarg is se 
#माणवकं मार्गं अपृच्छाम.
#गोपाः अजान् ग्रामं अनयन्.
       if(($in[$i] =~ /rel_nm:gONakarma/)  && ($in[$i] =~ /<relata_pos:([0-9]+)>/)){
          $verb_pos = $1;
          print STDERR "verb_pos = $verb_pos\n";
          print STDERR "in = $in[$verb_pos-1]\n";
          if($in[$verb_pos-1] =~ />kaWa1|xuh2|yAc1|ruX1|praC1|BikR1|ci1|brU1|SAs1|ji1|maW1|manW1|muR1</){
#vax1 is removed.
#कन्यायाः भर्तारं जामातरं वदन्ति.
             $in[$i] =~ s/<viBakwiH:2>/<viBakwiH:2se>/;
          }
       }
# In case of wAxarWya relation, the hindi parsarg is ke_liye
       if($in[$i] =~ /rel_nm:wAxarWyam/) { 
          $in[$i] =~ s/<viBakwiH:4>/<viBakwiH:4ke_liye>/;
       }
# In case of prayojana relation, the hindi parsarg is ke_liye
       if($in[$i] =~ /rel_nm:prayojanam/) { 
          $in[$i] =~ s/<viBakwiH:4>/<viBakwiH:4ke_liye>/;
       }
# In case of sahAyaka kriyA, wumun is mapped to 0 in Hindi
       if($in[$i] =~ /rel_nm:sahAyakakriyA/) { 
          $in[$i] =~ s/<kqw_prawyayaH:wumun>/<kqw_prawyayaH:wumun0>/;
       }
# In case of gONakarma of IR2 kriyA, wumun is mapped to kI in Hindi
       if($in[$i] =~ /rel_nm:gONakarma/) { 
          $in[$i] =~ s/<kqw_prawyayaH:wumun>/<kqw_prawyayaH:wumunkI>/;
       }
# In case of karwA relation with 3rd viBkawi, the hindi parsarg is xvArA
       if($in[$i] =~ /rel_nm:karwA/) { 
          $in[$i] =~ s/<viBakwiH:3>/<viBakwiH:3xvArA>/;
       }
# In case of kriyAviSeRaNa, absorb the 2 viBakwi
       if($in[$i] =~ /rel_nm:kriyAviSeRaNam/) { 
          $in[$i] =~ s/<viBakwiH:2>/<viBakwiH:20>/;
       }
# If the relation is not marked, more probably it is wAxarWya, since all the sampraxAna cases aer covered in the kaaraka charts.
#CAUTION: It might be a case of parser failure!
       if($in[$i] =~ /<rel_nm:>/) {
          $in[$i] =~ s/<viBakwiH:4>/<viBakwiH:4ke_liye>/;
       }
       if($in[$i] =~ /kim<vargaH:sarva><lifgam:napuM><viBakwiH:[12]>/) { 
 #kim in napuM in both 1 and 2 viBakwi is always kyA in Hindi ; 
          $in[$i] =~ s/kim<vargaH:sarva><lifgam:napuM><viBakwiH:[12]>/kim_1<vargaH:sarva><lifgam:napuM><viBakwiH:20>/;
#evaM kqwvA kim Bavawi.
       }
       if($in[$i] =~ /<kqw_prawyayaH:kwavawu>.*<rel_nm:aBihiwa_karwA>/) { 
          $in[$i] =~ s/<kqw_prawyayaH:kwavawu>/<kqw_prawyayaH:kwavawu_fin>/;
       }
       if($in[$i] =~ /<kqw_prawyayaH:kwavawu>.*<rel_nm:>/) { 
          $in[$i] =~ s/<kqw_prawyayaH:kwavawu>/<kqw_prawyayaH:kwavawu_fin>/;
       }
       if($in[$i] =~ /<kqw_prawyayaH:kwa>.*<rel_nm:aBihiwa_karwA>/) { 
          $in[$i] =~ s/<kqw_prawyayaH:kwa>/<kqw_prawyayaH:kwa_fin>/;
       }
       if($in[$i] =~ /<kqw_prawyayaH:kwa>.*<rel_nm:>/) { 
          $in[$i] =~ s/<kqw_prawyayaH:kwa>/<kqw_prawyayaH:kwa_fin>/;
       }
       if($in[$i] !~ /\-/) { $in[$i] =~ s/(<word:[^>]+>)([^<]+)</$2$1</;}
       else { $in[$i] =~ s/(<word:[^>]+>)(.*\-[^<]+)</$2$1</;}
       print $in[$i],"\n"; 
    }
    print "\n";
}

sub get_viBakwiH{
my($upapaxa,$viBakwi) = @_;

$upa_viB = $viBakwi."_".$upapaxa;
$new_viBakwiH = $upaviB{$upa_viB};

if($new_viBakwiH eq "") { $new_viBakwiH = $viBakwi;}
$new_viBakwiH;
}
1;
