#!PERLPATH
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


my $myPATH="SCLINSTALLDIR";
require "$myPATH/converters/convert.pl";

  $tmp_file_path = $ARGV[0];
  $sentences = $ARGV[1];
  $encoding = $ARGV[2];
  $pid = $ARGV[3];
  $script = $ARGV[4];
  $sandhi = $ARGV[5];
  $morph = $ARGV[6];
  $parse = $ARGV[7];
  $text_type = $ARGV[8];

  system("mkdir -p $tmp_file_path");
  open(TMP1,">$tmp_file_path/in$pid");
  $sentences1=&convert($encoding,$sentences);
  chomp($sentences1);
  @sentences=split(/\./,$sentences);
  foreach $sent (@sentences) {
     $sent =~ s/^\n/ /;
     $sent =~ s/^ [ \t]*//;
     #if($morph eq "GH") {
     if($morph eq "GH"){
       print TMP1 $sent,"\n";
     } else {
       print TMP1 "<s>",$sent,".</s>\n";
     }
  }
  close(TMP1);
     `date > $tmp_file_path/tmp_in$pid/err$pid`;
     $cmd = "$myPATH/SHMT/prog/shell/anu_skt_hnd.sh in$pid $tmp_file_path hi $script $sandhi $morph $parse $text_type NOECHO D 2>> $tmp_file_path/tmp_in$pid/err$pid;";
  system($cmd);
     `date >> $tmp_file_path/tmp_in$pid/err$pid`;
