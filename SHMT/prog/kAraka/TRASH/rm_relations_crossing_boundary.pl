#!PERLPATH

#  Copyright (C) 2010-2016 Amba Kulkarni (ambapradeep@gmail.com)
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


$/ = "\n\n";
open(OUT, "<$ARGV[0]") || die "Can't open $ARGV[0] for reading";
$file = 1;
while($in = <OUT>){
      @in = split(/\n/,$in);
      foreach $in (@in) {
          @flds = split(/\t/,$in);
          if(($flds[0] =~ /^([0-9]+)।([0-9]+)।([0-9]+)/) || ( $flds[0] =~ /^([0-9]+).([0-9]+).([0-9]+)/)){
          $s_no = $2; 
          $w_no = $3; 
          }
          if(&from_boundary_words($flds[2])) {
             $boundary[$s_no] .= "#".$w_no; 
          } 
      }
}
close(OUT);

$/ = "\n";
while($in = <STDIN>){
  chomp($in);
  if($in) {
      if($in =~ /rl([0-9]+).clp/){
         $s_no = $1;
         print $in,"\n";
      } elsif($in =~ /\(/){
         if($in =~ /^\(([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+).*\#(.*)/){
            $s_w_no = $1;
            $d_w_no = $4;
            $rel = $3;
            if((!&cross_boundary($s_w_no,$d_w_no,$boundary[$s_no])) || ($rel == 26)){ 
#26: sambanXaH; to allow the cross linking of yaxi,warhi etc.
#yaxi wvam icCasi warhi yaw vaswu BavaxIyam aswi waw mahyam arpaya.
              print $in,"\n";
            }
         } else { print $in,"\n";}
      }
  }
}

sub cross_boundary {
my($left_b,$right_b,$word_postns) = @_;

  $word_postns =~ s/^#//;
  @word_pos = split(/#/,$word_postns);

  for ($j = 0; $j <= $#word_pos; $j++){
    if(($left_b < $word_pos[$j]-1) && ($right_b > $word_pos[$j]-1)) { return 1;}
  }
return 0;
}
1;

sub from_boundary_words {
my($in) = @_;

if($in eq "yaw") { return 1;}
if($in eq "waw") { return 1;}
if($in eq "yaxi") { return 1;}
if($in eq "warhi") { return 1;}
if($in eq "yaxyapi") { return 1;}
if($in eq "waWApi") { return 1;}
if($in eq "yAvaw") { return 1;}
if($in eq "wAvaw") { return 1;}
if($in eq "yasmAw") { return 1;}
if($in eq "wasmAw") { return 1;}
if($in eq "yawaH") { return 1;}
if($in eq "wawaH") { return 1;}
if($in eq "awaH") { return 1;}
if($in eq "yaxA") { return 1;}
if($in eq "waxA") { return 1;}
if($in eq "yawra") { return 1;}
if($in eq "wawra") { return 1;}
if($in eq "yasmAw") { return 1;}
if($in eq "wasmAw") { return 1;}
if($in eq "yeRAm") { return 1;}
if($in eq "weRAm") { return 1;}
if($in eq "yasya") { return 1;}
if($in eq "wasya") { return 1;}
if($in eq "yaH") { return 1;}
if($in eq "saH") { return 1;}
if($in eq "ye") { return 1;}
if($in eq "we") { return 1;}

return 0;
}
