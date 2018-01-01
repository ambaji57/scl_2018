#!PERLPATH -I LIB_PERL_PATH/

#  Copyright (C) 2002-2017 Amba Kulkarni (ambapradeep@gmail.com)
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

my $myPATH = "SCLINSTALLDIR";
package main;
use CGI qw/:standard/;

my $version = "DEVELOP";

    if (! (-e "TFPATH")){
        mkdir "TFPATH" or die "Error creating directory TFPATH";
    }
  if($version eq "DEVELOP") {
    open(TMP1,">>TFPATH/shmt.log") || die "Can't open TFPATH/shmt.log for writing";
  }

require "$myPATH/converters/convert.pl";

      if (param) {
      $encoding=param("encoding");
      $sentences=param("text");
      $splitter=param("splitter");
      $out_encoding=param("out_encoding");
      #$morph=param("morph");
      $parse=param("parse");
      $text_type=param("text_type");


  if($version eq "DEVELOP") {
      print TMP1 $ENV{'REMOTE_ADDR'}."\t".$ENV{'HTTP_USER_AGENT'}."\n"."encoding:$encoding\t"."sentences:$sentences\t"."splitter:$splitter\t"."out_encoding:$out_encoding\t"."parse:$parse\n#####################\n\n";
  }

      if ($out_encoding eq "Devanagari") { $script = "DEV";}
      if ($out_encoding eq "Roman-Diacritic") { $script = "ROMAN";}
      if ($splitter eq "None") { $sandhi = "NO"; $morph = "UoHyd";}
      #if ($splitter eq "Heritage Splitter") { $sandhi = "YES"; $morph = "GH";}
      if ($splitter eq "Heritage Splitter") { $sandhi = "YES"; $morph = "GH-interactive";}
      if ($splitter eq "Anusaaraka Splitter") { $sandhi = "YES"; $morph = "UoHyd";}

      $pid = $$;

      $sentences =~ s/\r//g;
      $sentences =~ s/\n/#/g;
      $sentences =~ s/ ।/./g;
      $sentences =~ s/[ ]+\|/./g;
      $sentences =~ s/[ ]+([\.!\?])/$1/g;
      $sentences =~ s/:/ः/g;
      $sentences =~ s/\|[ ]+$/./g;
      $sentences =~ s/\.[ ]+$/./g;


      $sentences=&convert($encoding,$sentences);
      chomp($sentences);

      my $cgi = new CGI;
      if($morph eq "GH-interactive") {
         $sentences =~ s/\.//;
         $cmd = "HERITAGE_CGIURL?lex=SH\&cache=t\&st=t\&us=f\&cp=t\&text=$sentences\&t=WX\&topic=\&mode=g";
         print CGI-> redirect($cmd);
      } else {
         system("mkdir -p TFPATH/tmp_in$pid");
         open(TMP,">TFPATH/tmp_in$pid/wor.$pid") || die "Can't open TFPATH/tmp_in$pid/wor.$pid for writing";
         print TMP $sentences,"\n";
         close(TMP);

         print $cgi->header (-charset => 'UTF-8');
           $sentences = '"'. $sentences  . '"';
           system("$myPATH/SHMT/prog/shell/callmtshell.pl TFPATH $sentences $encoding $pid $script $sandhi $morph $parse $text_type");
           system("$myPATH/SHMT/prog/interface/display_output.pl $encoding $script $pid");
      }
    }
  if($version eq "DEVELOP") {
    close(TMP1);
  }
