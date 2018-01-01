#!PERLPATH -I LIB_PERL_PATH/

#  Copyright (C) 2006-2011 Shivaja Nair and (2006-2017) Amba Kulkarni (ambapradeep@gmail.com)
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

my $myPATH = "SCLINSTALLDIR";

my $rel_dbm = $ARGV[0];
my $heading = $ARGV[1];
my $word = $ARGV[2];
my $out_encoding = $ARGV[3];

my(%LEX,%LEX1,%LEX2,%LEX3,$head,$vargaH,$synset,$heading_info,$relata_info,$synset_info);

tie(%LEX,GDBM_File,"$myPATH/amarakosha/DBM/stem2head.gdbm",GDBM_READER,0666) || die "can't open DBM/stem2head.gdbm";
tie(%LEX1,GDBM_File,"$myPATH/amarakosha/DBM/synset_info.gdbm",GDBM_READER,0666) || die "can't open DBM/synsetinfo.gdbm";

if($rel_dbm ne "NULL") {
   tie(%LEX2,GDBM_File,"$myPATH/amarakosha/DBM/$rel_dbm.gdbm",GDBM_READER,0666) || die "can't open DBM/$rel_dbm.gdbm";
}
if($rel_dbm eq "onto") {
   tie(%LEX3,GDBM_File,"$myPATH/amarakosha/DBM/rule_onto.gdbm",GDBM_READER,0666) || die "can't open DBM/rule_onto.gdbm";
}

   $heading_info = "<\@br><\@font \@color=\"\@magenta\">$heading</\@font><\@br>";

  if($rel_dbm eq "NULL") { print "<\@center>$heading_info</\@center>"; }

  if($LEX{$word} eq "") {
     $out = `$myPATH/amarakosha/shw_stem.pl $word | /usr/bin/sort -u`;
     if ($out) {
        ` echo $out | $myPATH/amarakosha/showMsg.pl $rel_dbm $out_encoding`;
     } else {print "\@Could \@not \@find $word \@in \@the \@Amarakosha\n";}
  } else {
    @head = split(/::/,$LEX{$word});
    foreach $head (@head) {
     $synset = $LEX1{$head};
     $synset_info = "";
     if($synset) {
        $synset_info = &synset_info($head,$synset,$word);
     }
     if($rel_dbm ne "NULL") {
       if($rel_dbm eq "onto") {
         $relata_info = "";
         ($jAw,$upA) = split(/#/,$LEX2{$head});
          if ($jAw ne ""){ 
            $str = $jAw;
            $relata_info = "<\@br><\@b>jAwi</\@b><\@br> => $str<\@br>";
            $heading_info = "";
            while($LEX3{$str}){
                $relata_info .= "=> $LEX3{$str}<\@br>";
                $str = $LEX3{$str};
            }
          }
          if ($upA ne ""){ 
            $str = $upA;
            $relata_info .= "<\@br><\@b>upAXi</\@b><\@br> => $str<\@br>";
            $heading_info = "";
            while($LEX3{$str}){
                $relata_info .= "=> $LEX3{$str}<\@br>";
                $str = $LEX3{$str};
            } 
          }
       } elsif(($rel_dbm eq "avayavI") || ($rel_dbm eq "parAjAwi")){
         $relata_info = "";
        while($LEX2{$head}){
           $relata = $LEX2{$head};
           $relata =~ s/::.*//;
           $relata_synset = $LEX1{$relata};
           if($relata_synset) {
              $relata_info .= &synset_info($relata,$relata_synset,$word);
           }
           $head = $relata;
        }
       } else {
        @relata = split(/::/,$LEX2{$head});
        $relata_info = ""; 
        foreach $relata (@relata) { 
           $relata_synset = $LEX1{$relata};
           if($relata_synset) {
              $relata_info .= &synset_info($relata,$relata_synset,$word);
           }
        }
       }
       if($relata_info) {
           print $synset_info,"<\@br>",$heading_info,$relata_info;
       print "<\@br>_____________________<\@br><\@br>";
        }
     } else { print $synset_info; }
   }
 }
untie(%LEX);
untie(%LEX1);
untie(%LEX2);
untie(%LEX3);

sub synset_info{
  my($head,$synset,$word) = @_;
  my($synset_info);

   
    $add_info = "RANGE";  
    $start = ""; # stating sloka number
    $end = ""; # ending sloka number
    @synset = split(/::/,$synset);
	$range_info = &kANda_range1(@synset); #finding range of kANda;
	$range_info =~ /([0-9]+\.[0-9]+\.[0-9]+)\.*/; 
        $s = $1; #/^(.)\.*/; $s = $1;
	$range_info = &get_sloka_info1($range_info);
        $synset_info = "<\@br><\@div \@id=\"\@tool\"><\@font \@color=\"\@green\"><\@a \@title=\"$range_info\">arWaH :: $head</a></\@font> | ";
        $synset_info .= "<\@font \@color=\"\@black\">";
        for ($i=0;$i<=$#synset;$i++) {
           ($wrd,$kANda,$lifgam,$vargaH) = split(/#/,$synset[$i]);
           if($i == 0){
              $synset_info .= "<\@font \@color=\"\@red\">vargaH :: $vargaH</\@font> | ";
           }
           if($wrd eq $word) {
              $synset_info .= ", <\@a \@title=\"kANda,varga,Sloka,pAxa :: $kANda\,lifga :: $lifgam". "\"><\@span \@style=\"\@background:\@yellow;\">".$wrd."<\/\@span></\@a>";
           } else {
              $synset_info .= ", <\@a \@title=\"kANda,varga,Sloka,pAxa :: $kANda\,lifga :: $lifgam". "\">".$wrd."</\@a>";
           }
        }
        $synset_info .= "</\@font></\@div>";
$synset_info;
}
1;


#code for finding range;
sub kANda_range1{
	my @synset = @_;
	my $start = 0 , $end = 0;
	 for ($i=0;$i<=$#synset;$i++) {
  		 my ($wrd,$kANda,$lifgam,$vargaH) = split(/#/,$synset[$i]);
       		 if($i == 0){ $start = $kANda;}
		 else {  $kANda =~ /([0-9]+\.[0-9]+\.[0-9]+)\.*/; $s =$1; 
			if($start =~ /$s/){ }else{ $start .= "-".$kANda;}
		}
	
	}
$start;
}
1;

sub get_sloka_info1{
	$num = $_[0];
	chomp $num;
		my $result = "";
		@nums = split(/-/,$num);
		foreach $nums (@nums){
		$nums =~ /([0-9]+\.[0-9]+\.[0-9]+)\.*/; $s = $1;
		$count = 0;
		die "can't open file for reading $!" unless open(TMP,"$myPATH/amarakosha/amara.wx");
           	 while(my $in = <TMP>){
			chomp $in;
			if($in =~ /<Sloka_$s>/ and $count ==0){  $result .= $in; $count =1; }
			elsif($in !~ /<\/Sloka_$s>/ and $count == 1){ $result .= $in;}
			elsif($in =~ /<\/Sloka_$s/ and $count == 1){ $result .= $in; $count = 0;} 
		}
	}
$result =~ s/<\/Sloka_[0-9]+\.[0-9]+\.[0-9]+>//g;
$result =~ s/<Sloka_[0-9]+\.[0-9]+\.[0-9]+>//g;
$result =~ s/^M//g;
$result =~ s/ //g;
close TMP;
$result;
}
1;
