#!PERLPATH -I LIB_PERL_PATH/

#  Copyright (C) 2009-2017 Amba Kulkarni (ambapradeep@gmail.com)
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


$Data_Path=$ARGV[0];
$LANG = $ARGV[1];
if($ARGV[2] eq "D") { $DEBUG = 1; } else {$DEBUG = 0;}

use GDBM_File;
tie(%NOUN,GDBM_File,"$Data_Path/$LANG/noun.dbm",GDBM_READER,0644) || die "Can't open noun.dbm for reading";
tie(%PRONOUN,GDBM_File,"$Data_Path/$LANG/pronoun.dbm",GDBM_READER,0644) || die "Can't open pronoun.dbm for reading";
tie(%TAM,GDBM_File,"$Data_Path/$LANG/tam.dbm",GDBM_READER,0644) || die "Can't open tam.dbm for reading";
tie(%VERB,GDBM_File,"$Data_Path/$LANG/verb.dbm",GDBM_READER,0644) || die "Can't open verb.tam for reading";
tie(%AVY,GDBM_File,"$Data_Path/$LANG/avy.dbm",GDBM_READER,0644) || die "Can't open avy.dbm for reading";
if($LANG eq "hi") {
 tie(%FEM,GDBM_File,"$Data_Path/$LANG/fem_hnd_noun.dbm",GDBM_READER,0644) || die "Can't open avy.dbm for reading";
}


if($LANG eq "fr") {
tie(%LINK,GDBM_File,"$Data_Path/$LANG/link.dbm",GDBM_READER,0644) || die "Can't open link.dbm for reading";
}

open(TMP_N,">dict_noun_add.txt") || die "Can't open dict_noun_add.txt";
open(TMP_V,">dict_verb_add.txt") || die "Can't open dict_verb_add.txt";
open(TMP_A,">dict_avy_add.txt") || die "Can't open dict_avy_add.txt";

while($in = <STDIN>){
  #print "IN = $in";
  chomp($in);
  $in =~ s/></;/g;
  $in =~ s/</{/g;
  $in =~ s/>/}/g;
  $in =~ s/}\-/#/g;
  $in =~ s/{[^#]+#/-/g;
      #print "before in = $in\n";
  $in =~ s/({vargaH:sa\-pU\-pa;[^}]+}(\/[^{]+)?)+\$\-/-/g;
  #    print STDERR "after in = $in\n";
  if($in =~ /\-/) { $in =~ /^(.*)\-([^\-]+)/; $samAsa_pUrvapaxa = $1; $in = $2;}       else { $samAsa_pUrvapaxa = "";}
     # print STDERR "samAsa_pUrvapaxa  = $samAsa_pUrvapaxa\n";
  @in = split(/\//,$in);
  if($in ne ""){
    for($i=0;$i<=$#in;$i++){
      if($in[$i] =~ /^([^{]+).*vargaH:sarva.*lifgam:([^;]+).*viBakwiH:([^;]+).*vacanam:([^;]+)/){
       $rt = $1;
       $cat = "P";
       $lifga = $2;
       $viBakwi = $3;
       $vacana = $4;
       $vacana = &get_hn_vacana($vacana);

       #print "rt = $rt\n";
       $key = $rt."_".$lifga;
       if($PRONOUN{$key}) {$map_rt = $PRONOUN{$key};} 
       else { print TMP_N $key,"\n"; $map_rt = $rt;}
       $map_rt =~ s/\^.*//;
       $map_rt =~ s/\{.*\}//;
       $tmp_rt = $map_rt;
      # print STDERR "noun = $key\n";
       #print STDERR "map_rt = $map_rt\n";
       $lifga = &get_hn_lifga($map_rt,$lifga);
       if($samAsa_pUrvapaxa) { $map_rt = $samAsa_pUrvapaxa."-".$map_rt;}
       if($TAM{$viBakwi}) {$map_viBakwi = $TAM{$viBakwi};} else {$map_viBakwi = "0";}
      
       if(($map_rt ne "") && ($map_viBakwi ne "")){
          if($DEBUG ) {print STDERR  "sarvanAma  ","$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt $cat $lifga $vacana NW $map_viBakwi\n";}
          if($LANG eq "en"){
             if(($map_viBakwi eq "subj") || ($map_viBakwi eq "obj")) {
               print $map_rt."_{".$map_viBakwi."}";
             } else {print $map_viBakwi."_".$map_rt;}
          }elsif($LANG eq "fr"){
            # $tmp_rt = $map_rt;
           #  print STDERR $map_rt,"\n";
           #  print STDERR $rt,"\n";
             $map_rt =~ s/à/\&agrave;/g;
             $map_rt =~ s/é/\&eacute;/g;
             $map_rt =~ s/ê/\&ecirc;/g;
          #   print STDERR $map_rt,"\n";
             if($tmp_rt ne $rt) {
                if(($map_viBakwi eq "subj") || ($map_viBakwi eq "obj")) {
                  print "<a href=\"file:\/\/\/home\/amba\/SHMT\/data\/fr\/".$LINK{$rt}."\">".$map_rt."<\/a>_{".$map_viBakwi."}";
                } else {
                  print "{".$map_viBakwi."}_<a href=\"file:\/\/\/home\/amba\/SHMT\/data\/fr\/".$LINK{$rt}."\">".$map_rt."<\/a>";
                }
             }
          } elsif($LANG eq "hi") {
          system("$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt $cat $lifga $vacana NW $map_viBakwi");
         }
       }

      } elsif($in[$i] =~ /^([^{]+).*vargaH:([^;]+).*lifgam:([^;]+).*viBakwiH:([^;]+).*vacanam:([^;]+)/){
       $rt = $1;
       $cat = &get_hn_cat($2);
       $lifga = $3;
       $viBakwi = $4;
       $vacana = $5;
       $vacana = &get_hn_vacana($vacana);

       #print "rt = $rt\n";
       $key = $rt."_".$lifga;
       if($NOUN{$key}) {$map_rt = $NOUN{$key};} 
       else { print TMP_N $key,"\n"; $map_rt = $rt;}
       #print STDERR "map_rt = $map_rt\n";
       $map_rt =~ s/\^.*//;
       $tmp_rt = $map_rt;
       #print STDERR "noun = $key\n";
       #print STDERR "map_rt = $map_rt\n";
       if($samAsa_pUrvapaxa) { $map_rt = $samAsa_pUrvapaxa."-".$map_rt;}
       if($TAM{$viBakwi}) {$map_viBakwi = $TAM{$viBakwi};} else {$map_viBakwi = "0";}
      
       $lifga = &get_hn_lifga($map_rt,$lifga);
       if(($map_rt ne "") && ($map_viBakwi ne "")){
          if($DEBUG) {print STDERR "any other noun ","$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt $cat $lifga $vacana NW $map_viBakwi\n";}
          if($LANG eq "en"){
             if(($map_viBakwi eq "subj") || ($map_viBakwi eq "obj")) {
               print $map_rt."_{".$map_viBakwi."}";
             } else {print $map_viBakwi."_".$map_rt;}
          }elsif($LANG eq "fr"){
            # $tmp_rt = $map_rt;
           #  print STDERR $map_rt,"\n";
           #  print STDERR $rt,"\n";
             $map_rt =~ s/à/\&agrave;/g;
             $map_rt =~ s/é/\&eacute;/g;
             $map_rt =~ s/ê/\&ecirc;/g;
            # print STDERR $map_rt,"\n";
             if($tmp_rt ne $rt) {
                if(($map_viBakwi eq "subj") || ($map_viBakwi eq "obj")) {
                  print "<a href=\"file:\/\/\/home\/amba\/SHMT\/data\/fr\/".$LINK{$rt}."\">".$map_rt."<\/a>_{".$map_viBakwi."}";
                } else {
                  print "{".$map_viBakwi."}_<a href=\"file:\/\/\/home\/amba\/SHMT\/data\/fr\/".$LINK{$rt}."\">".$map_rt."<\/a>";
                }
             }
          } elsif($LANG eq "hi") {
          system("$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt $cat $lifga $vacana NW $map_viBakwi");
         }
       }

      } elsif($in[$i] =~ /^([^{]+){vargaH:avy;kqw_prawyayaH:([^;]+);XAwuH:([^;]+);gaNaH:([^;]+)/){

       $rt = $1;
       $kqw = $2;
       $XAwu = $3;
       $gaNa = $4;

       if($LANG eq "fr") { $rt =~ s/[1-4]//; $rt =~ s/-//;}
       if($VERB{$rt}) {$map_rt = $VERB{$rt};} 
       else {print TMP_V $rt,"\n"; $map_rt = $rt;}
      # print STDERR "verb = $rt\n";
    #   print STDERR "map_rt = $map_rt\n";
       $map_rt =~ s/\^.*//;
       if($TAM{$kqw}) {$map_kqw = $TAM{$kqw};} else {$map_kqw = "0";}

      # print STDERR "kqw = $kqw\n";
      # print STDERR "map_kqw = $map_kqw\n";
        if(($map_rt ne "") && ($map_kqw ne "")) {
          if($DEBUG) {print STDERR "kqw avyaya ", "$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt v m $vacana $purURa $map_lakAra\n";}
          if($LANG eq "en"){
             print $map_rt,"_{",$map_kqw."}";
          }elsif($LANG eq "fr"){
             $tmp_rt = $map_rt;
           #  print STDERR $tmp_rt,"\n";
            # print STDERR $map_rt,"\n";
             $map_rt =~ s/à/\&agrave;/g;
             $map_rt =~ s/é/\&eacute;/g;
             $map_rt =~ s/ê/\&ecirc;/g;
             if($tmp_rt ne $rt) {
                print "<a href=\"file:\/\/\/home\/amba\/SHMT\/data\/fr\/".$LINK{$rt}."\">".$map_rt."<\/a>". "_{".$map_kqw."}";
             }
          } elsif($LANG eq "hi") {
          system("$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt v m NW NW $map_kqw");
         }
       }
      } elsif($in[$i] =~ /^([^{]+){vargaH:avy;waxXiwa_prawyayaH:([^;]+);lifgam:([^;]+)/){

       $rt = $1;
       $waxXiwa = $2;
       $cat = "n";
       $lifga = $3;

       #print "rt = $rt\n";
       $key = $rt."_".$lifga;
       if($NOUN{$key}) {$map_rt = $NOUN{$key};} 
       else { print TMP_N $key,"\n"; $map_rt = $rt;}
       $map_rt =~ s/\^.*//;
       $map_rt =~ s/{.*}//;
       $tmp_rt = $map_rt;
      # print STDERR "noun = $key\n";
       #print STDERR "map_rt = $map_rt\n";
       if($samAsa_pUrvapaxa) { $map_rt = $samAsa_pUrvapaxa."-".$map_rt;}
       if($TAM{$waxXiwa}) {$map_waxXiwa = $TAM{$waxXiwa};} else {$map_waxXiwa = "0";}
      
       $lifga = &get_hn_lifga($map_rt,$lifga);
       if(($map_rt ne "") && ($map_waxXiwa ne "")){
          if($DEBUG) {print STDERR " waxXiwa ","$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt $cat $lifga $vacana NW $map_waxXiwa\n";}
          if($LANG eq "en"){
             if(($map_viBakwi eq "subj") || ($map_waxXiwa eq "obj")) {
               print $map_rt."_{".$map_waxXiwa."}";
             } else {print $map_waxXiwa."_".$map_rt;}
          }elsif($LANG eq "fr"){
            # $tmp_rt = $map_rt;
           #  print STDERR $map_rt,"\n";
           #  print STDERR $rt,"\n";
             $map_rt =~ s/à/\&agrave;/g;
             $map_rt =~ s/é/\&eacute;/g;
             $map_rt =~ s/ê/\&ecirc;/g;
            # print STDERR $map_rt,"\n";
             if($tmp_rt ne $rt) {
                if(($map_waxXiwa eq "subj") || ($map_waxXiwa eq "obj")) {
                  print "<a href=\"file:\/\/\/home\/amba\/SHMT\/data\/fr\/".$LINK{$rt}."\">".$map_rt."<\/a>_{".$map_waxXiwa."}";
                } else {
                  print "{".$map_viBakwi."}_<a href=\"file:\/\/\/home\/amba\/SHMT\/data\/fr\/".$LINK{$rt}."\">".$map_rt."<\/a>";
                }
             }
          } elsif($LANG eq "hi") {
          system("$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt $cat $lifga $vacana NW $map_waxXiwa");
         }
       }
      } elsif($in[$i] =~ /^([^{]+).*vargaH:avy/){
       $rt = $1;
       if($AVY{$rt}) {$map_rt = $AVY{$rt};} 
       else {print TMP_A $rt,"\n"; $map_rt = $rt;}
     #  print STDERR "avy = $rt\n";
       if($DEBUG) { print STDERR "avyaya ","$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt avy NW NW NW NW\n";}
          if($LANG eq "en"){
             print $map_rt;
          }elsif($LANG eq "fr"){
             $tmp_rt = $map_rt;
            # print STDERR $map_rt,"\n";
             $map_rt =~ s/à/\&agrave;/g;
             $map_rt =~ s/é/\&eacute;/g;
             $map_rt =~ s/ê/\&ecirc;/g;
            # print STDERR $map_rt,"\n";
             if($tmp_rt ne $rt) {
                print "<a href=\"file:\/\/\/home\/amba\/SHMT\/data\/fr\/".$LINK{$rt}."\">".$map_rt."<\/a>";
             }
          } elsif($LANG eq "hi") {
       system("$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt avy NW NW NW NW");
         }

      } elsif($in[$i] =~ /^([^{]+){prayogaH:([^;]+);lakAraH:([^;]+);puruRaH:([^;]+);vacanam:([^;]+);.*XAwuH:([^;]+);gaNaH:([^;]+)/){

       $rt = $1;
       $prayoga = $2;
       $lakAra = $3;
       $purURa = $4;
       $vacana = $5;
       $XAwu = $6;
       $gaNa = $7;
#       $rt =~ s/_/-/g;

       if($LANG eq "fr") { $rt =~ s/[1-4]//; $rt =~ s/-//;}
       if($VERB{$rt}) {$map_rt = $VERB{$rt};} 
       else {print TMP_V $rt,"\n"; $map_rt = $rt;}
      # print STDERR "verb = $rt\n";
     #  print STDERR "map_rt = $map_rt\n";
       $map_rt =~ s/\^.*//;
       $map_rt =~ s/{.*}//;
       $pra_lakAra = $prayoga."_".$lakAra;
       if($TAM{$pra_lakAra}) {$map_lakAra = $TAM{$pra_lakAra};} else {$map_lakAra = "0";}
       $map_lakAra =~ /^([^_]+)_([^_]+)_(.*)$/; 

       $purURa = &get_hn_purURa($purURa);
       $vacana = &get_hn_vacana($vacana);

        if(($map_rt ne "") && ($map_lakAra ne "")) {
          if($DEBUG) { print STDERR  " verb ","$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt v m $vacana $purURa $map_lakAra\n";}
          if($LANG eq "en"){
             print $map_rt,"_{",$map_lakAra."}";
          }elsif($LANG eq "fr"){
             $tmp_rt = $map_rt;
            # print STDERR $tmp_rt,"\n";
            # print STDERR $map_rt,"\n";
             $map_rt =~ s/à/\&agrave;/g;
             $map_rt =~ s/é/\&eacute;/g;
             $map_rt =~ s/ê/\&ecirc;/g;
             if($tmp_rt ne $rt) {
                print "<a href=\"file:\/\/\/home\/amba\/SHMT\/data\/fr\/".$LINK{$rt}."\">".$map_rt."<\/a>". "_{".$map_lakAra."}";
             }
          } elsif($LANG eq "hi") {
          system("$Data_Path/../prog/hnd_gen/test/new_gen.out ON NOT $map_rt v m $vacana $purURa $map_lakAra");
         }
       }
   }
      print "\/";
  }
  }
  print "\n";
}

close(TMP_N);
close(TMP_V);
close(TMP_A);


sub get_hn_lifga{
 my($wrd,$lifga) = @_;

 if($FEM{$wrd}) { $lifga = "f";}
 elsif($lifga eq "napuM") { $lifga = "m";}
 elsif($lifga eq "puM") { $lifga = "m";}
 elsif($lifga eq "swrI") { $lifga = "f";}
 elsif($lifga eq "a") { $lifga = "m";}

$lifga;
}
1;

sub get_hn_purURa{
 my($purURa) = @_;

 if($purURa eq "u") { $purURa = "u";}
 elsif($purURa eq "ma") { $purURa = "m";}
 elsif($purURa eq "pra") { $purURa = "a";}

$purURa;
}
1;

sub get_hn_vacana{
 my($vacana) = @_;

 if($vacana eq "1") { $vacana = "s";}
 elsif($vacana eq "2") { $vacana = "p";}
 elsif($vacana eq "3") { $vacana = "p";}

$vacana;
}
1;

sub get_hn_cat{
 my($cat) = @_;

 if($cat eq "nA") { $cat = "n";}
 if($cat eq "saMKyeyam") { $cat = "n";}
 if($cat eq "pUraNam") { $cat = "n";}

$cat;
}
1;
