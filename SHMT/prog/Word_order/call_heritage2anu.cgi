#!PERLPATH

#  Copyright (C) 2017-2017 Amba Kulkarni (ambapradeep@gmail.com)
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

use strict;
use warnings;

 my $myPATH = "SCLINSTALLDIR";
 require "$myPATH/converters/convert.pl";

 use CGI qw( :standard );
 
 my $cgi = new CGI;
 print $cgi->header (-charset => 'UTF-8');
 
 my $buffer = "";
 my $display = "";

 if (param()){
   foreach my $p (param()){
    if($p eq "DISPLAY") { $display = param($p);}
    else {$buffer .= param($p);}
   }

 my $pid = $$;
 system("mkdir -p TFPATH/tmp_in$pid");

 system("echo '$buffer' | SCLINSTALLDIR/SHMT/prog/Heritage_morph_interface/Heritage2anusaaraka_morph.sh > TFPATH/tmp_in$pid/in$pid.out");

# system("cp TFPATH/tmp_in$pid/in$pid.out TFPATH/tmp_in$pid/in$pid.out.bak");

if($display eq "") { $display = "DEV";}

open (TMP,">TMPPATH111");
print TMP $buffer,"\n";
print TMP $display,"\n";
close TMP;
 
 system("SCLINSTALLDIR/SHMT/prog/shell/Heritage_anu_skt_hnd.sh in$pid TFPATH $display Full Prose NOECHO ND 2> TFPATH/tmp_in$pid/err$pid");

 system("SCLINSTALLDIR/SHMT/prog/interface/display_anu_out.pl $pid");

 }
