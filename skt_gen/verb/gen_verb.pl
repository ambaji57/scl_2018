#!PERLPATH -I LIB_PERL_PATH/

#  Copyright (C) 2010-2017 Amba Kulkarni (ambapradeep@gmail.com)
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

my $myPATH="SCLINSTALLDIR";
require "$myPATH/converters/convert.pl";

package main;
use CGI qw/:standard/;

@lakAra = ("lat","lit","lut","lqt","lot","laf","viXilif","ASIrlif","luf","lqf");
@person = ("pra","ma","u");
@vacanam = ("eka","xvi","bahu");

 $encoding = $ARGV[0];
 $prygH = $ARGV[1];
 $upasarga = $ARGV[2];
 $rt = $ARGV[3];
 $paxI = $ARGV[4];

 #$generator = "LTPROCBINDIR/lt-proc -ct $myPATH/morph_bin/skt_gen.bin";
 $generator = "LTPROCBINDIR/lt-proc -ct $myPATH/morph_bin/wif_gen.bin";

 $ltproc_cmd = "$generator | grep . | pr --columns=3 --across --omit-header --width=300| $myPATH/converters/ri_skt | $myPATH/converters/iscii2utf8.py 1";

# print "encoding = $encoding\n";
 if($encoding ne "WX"){
   $rt_XAwu_gaNa_mng = &convert($encoding,$rt);
   chomp($rt_XAwu_gaNa_mng);
   $prayogaH = &convert($encoding,$prygH);
   chomp($prayogaH);
   $upasarga = &convert($encoding,$upasarga);
   chomp($upasargaH);
 } else { $rt_XAwu_gaNa_mng = $rt; $prayogaH = $prygH; }

   $LTPROC_IN = "";
   $LTPROC_IN1 = "";
   $str = "";
   $str1 = "";

#print "rt = $rt upasarga = $upasarga prayoga = $prayogaH\n";
#Since we are using only first 3 fields, $mean is removed.
    ($rt,$XAwu,$gaNa,$mng) = split(/_/,$rt_XAwu_gaNa_mng);
    if($prayogaH eq "Nickarwari") { $prayogaH = "karwari"; $sanAxi = "<sanAxi:Nic>";} else {$sanAxi = "";}
    if ($upasarga ne "-") { $upasargastr = "<upasarga:$upasarga>";} else { $upasargastr = "";}

  print "<body>\n";
  $rtutf8 = `echo $rt | sed 's/[1-5]//' | $myPATH/converters/wx2utf8.sh`;
  $gaNautf8 = `echo $gaNa | sed 's/[1-5]//' | $myPATH/converters/wx2utf8.sh`;
  if ($upasarga ne "-") {$upasarga = `echo $upasarga | $myPATH/converters/wx2utf8.sh`."_";} else {$upasarga = "";}
  print "<center>\n";
  print "$upasarga<a href=\"javascript:show('$rtutf8')\">$rtutf8 ($gaNautf8)<\/a>\n";
# In javascript:show also upasarga needs to be added. But I do not know how is the dict organised. Hence it is postponed. Amba 9th Nov 2016
  print "<\/center>\n";

 if (($paxI eq "parasmEpaxI") || ($paxI eq "uBayapaxI")) {
  print "<table border=0 width=100%>\n";
  print "<tr><td>\n";
  print "<center>\n";
  print "<font color=\"green\" size=\"6\"><b>परस्मैपदी</b></font>\n";
  print "</center></td></tr>\n";
  print "<tr>\n"; 
  $LTPROC_IN = &get_generator_string($rt,$upasargastr,$prayogaH,$XAwu,$gaNa,"parasmEpaxI");
#$str = $LTPROC_IN;
#$str =~ s/</&lt;/g;
#$str =~ s/>/&gt;/g;
#print "str = $str";
  $str = "echo '".$LTPROC_IN."' | $ltproc_cmd | $myPATH/skt_gen/verb/verb_format_html.pl";
  system($str);
  print "</tr>\n";
  print "</table>\n";
 }
 if (($paxI eq "AwmanepaxI") || ($paxI eq "uBayapaxI")) {
  print "<table border=0 width=100%>\n";
  print "<tr><td>\n";
  print "<center>\n";
  print "<font color=\"green\" size=\"6\"><b>आत्मनेपदी</b></font>\n"; 
  print "</center></td></tr>\n";

  print "<tr>\n"; 
  $LTPROC_IN1 = &get_generator_string($rt,$upasargastr,$prayogaH,$XAwu,$gaNa,"AwmanepaxI");

  $str1 = "echo '".$LTPROC_IN1."' | $ltproc_cmd | $myPATH/skt_gen/verb/verb_format_html.pl";
  system($str1);
  print "</tr>\n";
  print "</table>\n";
 }
  print "</body></html>\n";

sub get_generator_string {
 my($rt,$upasarga,$prayogaH,$XAwu,$gaNa,$paxI) = @_;
 my ($l,$lakAra,$per,$num,$str,$STR);

       for($l=0;$l<10;$l++){
             $lakAra = $lakAra[$l];
             for($per=0;$per<3;$per++){
                $person = $person[$per];
                for($num=0;$num<3;$num++){
                     $vacanam = $vacanam[$num];
                     $str = "${rt}${upasarga}<prayogaH:$prayogaH><lakAraH:$lakAra><puruRaH:$person><vacanam:$vacanam><paxI:$paxI><XAwuH:$XAwu><gaNaH:$gaNa><level:1>";
                   $STR .=  $str."\n";
                } # number
            } #person
         } #lakAra
 $STR;
}
1;
