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


package main;
use CGI qw/:standard/;
#use CGI::Carp qw(fatalsToBrowser);


      if (param) {
      $encoding=param("encoding");
      $sentences=param("text");
      $splitter=param("splitter");
      $out_encoding=param("out_encoding");
      $morph=param("morph");
      $parse=param("parse");

      if ($out_encoding eq "Devanagari") { $script = "DEV";}
      if ($out_encoding eq "Roman-Diacritic") { $script = "ROMAN";}
      if ($out_encoding eq "Velthuis") { $script = "VH";}
      if ($splitter eq "None") { $sandhi = "NO"; $morph = "UoHyd";}
      if ($splitter eq "Heritage Splitter") { $sandhi = "YES"; $morph = "GH";}
      if ($splitter eq "Anusaaraka Splitter") { $sandhi = "YES"; $morph = "UoHyd";}
      if ($parse eq "NO") { $parse = "NO";}
      if ($parse eq "Partial") { $parse = "Partial";}
      if ($parse eq "Full") { $parse = "Full";}

      $pid = $$;

      $sentences =~ s/\r//g;
      $sentences =~ s/\n/#/g;
      $sentences =~ s/ ।/./g;
      $sentences =~ s/[ ]+\|/./g;
      $sentences =~ s/[ ]+([\.!\?])/$1/g;
      $sentences =~ s/:/ः/g;
      $sentences =~ s/\|[ ]+$/./g;
      $sentences =~ s/\.[ ]+$/./g;

      system("mkdir -p TFPATH/tmp_in$pid");
      open(TMP,">TFPATH/tmp_in$pid/wor.$pid") || die "Can't open TFPATH/tmp_in$pid/wor.$pid for writing";
      print TMP $sentences,"\n";
      close(TMP);

      $sentences = '"'. $sentences  . '"';


      my $cgi = new CGI;
      print $cgi->header (-charset => 'UTF-8');
      system("SCLINSTALLDIR/SHMT/prog/shell/callmtshell.pl TFPATH $sentences $encoding $pid $script $sandhi $morph $parse");
      system ("cat TFPATH/tmp_in${pid}/in${pid}_main.xml");
      }
