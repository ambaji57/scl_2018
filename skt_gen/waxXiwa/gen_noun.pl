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
@vacanam = ("eka","xvi","bahu");

 $rt = $ARGV[0];
 $gen = $ARGV[1];
 $encoding = $ARGV[2];
 $suffix = $ARGV[3];

 $rt_wx=&convert($encoding,$rt);
 $lifga_wx=&convert($encoding,$gen);
 $suffix_wx=&convert($encoding,$suffix);

 chomp($rt_wx);
 chomp($lifga_wx);
 chomp($suffix_wx);

 $rtutf8 = `echo $rt | $myPATH/converters/wx2utf8.sh`;
 
 $generator = "LTPROCBINDIR/lt-proc -ct $myPATH/morph_bin/skt_taddhita_gen.bin";

 $LTPROC_IN = "";
 for($vib=1;$vib<9;$vib++){
    for($num=0;$num<3;$num++){
         $vacanam = $vacanam[$num];
         $str = "$rt_wx<vargaH:nA_$suffix_wx><lifgam:$lifga_wx><viBakwiH:$vib><vacanam:$vacanam><level:3>"; 
         $LTPROC_IN .=  $str."\n";
    } # number
 } #vib
 print $LTPROC_in;

 $str = "echo '".$LTPROC_IN."' | $generator | grep . | pr --columns=3 --across --omit-header | $myPATH/converters/ri_skt | $myPATH/converters/iscii2utf8.py 1| $myPATH/skt_gen/waxXiwa/noun_format_html.pl $rt_wx $lifga_wx";
 system($str);
