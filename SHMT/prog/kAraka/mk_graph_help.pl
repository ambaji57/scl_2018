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

# ARGV[0]: Script : DEV / ROMAN (Not used in this programme)
# Devanagari / Roman transliteration 

# ARGV[1]: sentence number

#ARGV[2]: morph input file
# Relevant fields:
# First field: paragraph/line/word_no
# Second field: word

#ARGV[3]: file name containing names of the kaaraka tags

#ARGV[4]: File path for temporary files (Not used in this program)

#$ARGV[5]: parseno, unnecessary input, but required for mk_kAraka.pl
use GDBM_File;

tie(%kAraka_name,GDBM_File,"$ARGV[3]",GDBM_READER,0644) || die "Can't open $ARGV[3] for reading";

$/ = "\n\n";
open(OUT, "<$ARGV[2]") || die "Can't open $ARGV[2] for reading";
while($in = <OUT>){
      @in = split(/\n/,$in);
      open(TMP1,">../$ARGV[1].dot") || die "Can't open $ARGV[1].dot for writing";
      print TMP1 "digraph G\{\nrankdir=BT\n";
#fontpath=\"/home/ambaji/.fonts\";\n";
      print TMP1 "node [shape=record ]\n";
      foreach $in (@in) {
          @flds = split(/\t/,$in);
          if(($flds[0] =~ /^([0-9]+)।([0-9]+)/) || ( $flds[0] =~ /^([0-9]+).([0-9]+)/)){
          $s_no = $1; 
          $w_no = $2; 
          }
          print TMP1 "struct$w_no [shape=record, color=\"blue\"";
          $word = $flds[2];
          $mo = ($flds[7] =~ s/\//\//g);
          $mo++;
          print TMP1 "label = \"";
          for ($j=1;$j<=$mo;$j++){
           print TMP1 "<Node${w_no}$j> $word [$w_no,$j]";
           if($j <$mo) { print TMP1 "\|\|";}
          } 
          print TMP1 "\"]\n";
      }
}
close(OUT);

$/ = "\n";
while($in = <STDIN>){
  chomp($in);
  if($in) {
         if($in =~ /^([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+).*\#(.*)/){
            $rel_found = 1;
            $s_w_no = $1;
            $s_a_no = $2;
            $d_w_no = $4;
            $d_a_no = $5;
            $k_rel_nm = $6;
            #$k_rel_nm = $kAraka_name{$rel_nm};
            print TMP1 "struct${s_w_no}:Node${s_w_no}$s_a_no -> struct${d_w_no}:Node${d_w_no}$d_a_no \[label=\"".$k_rel_nm."\"  dir=back \]\n";
         }
      }
}
# if($rel_found) {print TMP1 "}\n";}
 print TMP1 "}\n";
 close(TMP1);
 system("GraphvizDot/dot -Tsvg -o../$ARGV[1].svg ../$ARGV[1].dot");
