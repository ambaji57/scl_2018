#!PERLPATH

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

my $myPATH="SCLINSTALLDIR";

require "$myPATH/converters/convert.pl";

$encoding = $ARGV[0];
$word = $ARGV[1];
$sandhi_type = $ARGV[2];
$pid = $ARGV[3];

      $word_wx=&convert($encoding,$word);
      chomp($word_wx);

system("mkdir TFPATH/seg_$pid");

 open(TMP,">TFPATH/seg_$pid/wordwx");
   print TMP $word_wx;
 close(TMP);

system("cd TFPATH/seg_$pid/; $myPATH/SHMT/prog/sandhi_splitter/web_interface/run.sh $sandhi_type TFPATH/seg_$pid/wordwx");
