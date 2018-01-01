#!PERLPATH

#  Copyright (C) 2012-2016 Amba Kulkarni (ambapradeep@gmail.com)
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


$dir_path = $ARGV[0];
$lst = `ls -m $dir_path/1.*.dot`;
@lst = split(/,/,$lst);
foreach $l (@lst) {
   $l =~ s/^ //;
   $out = $l;
   $out =~ s/\.([0-9]+)\.dot/c.$1.dot/;
   open(TMP,"< $l") || die "can't open $l for reading";
   open(TMP1,">$out") || die "can't open $out for reading";
   
   $in = <TMP>;
   $non_rel = 1;
   while(($non_rel == 1) && ($in)){
     if($in =~ /Node([0-9]+).*label[ ]*=[ ]*"([^"]+)"/){
        $key = $1; $val = $2; 
        $val =~ s/{.*}//;
        $NODE{$key} = $val;
        $node_entry{$key} = $in;
     } else { print TMP1 $in;}
#     print TMP1 $in;
     $in = <TMP>;
     if($in =~ /Start of Relations section/){ $non_rel = 0;}
   }
   $cnt = 0;
   while($in = <TMP>){
    if ($in =~ /Node/) {
       $in =~ /Node([0-9]+)[ ]*\->[ ]*Node([0-9]+)[ ]*\[label="([^"]+)"[ ]*(.*)$/;
       $from[$cnt] = $1; $to[$cnt] = $2; $label[$cnt] = $3; $misc[$cnt] = $4;
    } else { $from[$cnt] = $in;$to[$cnt] = ""; $label[$cnt] = ""; $misc[$cnt] = "";}
       $cnt++;
   }
   close(TMP);
   $edge_entry = "";
   $label = "";
   for($i=0;$i<=$cnt;$i++){
    if(($label[$i] !~ /^प्रतियोगी$/) &&  ($label[$i] !~ /^अनुयोगी$/) && ($label[$i] !~ /^सम्बन्धः$/)) {
      if($to[$i] ne "") {
         $edge_entry .=  "Node".$from[$i]." -> Node".$to[$i]." [label=\"".$label[$i]."\" ".$misc[$i]."\n";
      } else { $edge_entry .= $from[$i]."\n";}
    } else {
       if($label[$i] =~ /^प्रतियोगी$/) {
          $from = $from[$i];
          $to = $to[$i];
          $prawiyogi = 1;
          $label = "";
          for($j=0;$j<=$cnt;$j++){
            if(( $label[$j] =~ /^अनुयोगी$/)  &&  ($from[$j] == $to)) {
               if($label) {
                  $edge_entry .= "Node".$from[$i]." -> Node".$to[$j]." [label=\"".$label."\" ".$misc[$j]."\n";
               } else {
                  $edge_entry .= "Node".$from[$i]." -> Node".$to[$j]." [label=\"".$NODE{$to[$i]}."\" ".$misc[$j]."\n";
               }
	 	 $node_entry{$to[$i]} = "";
                 $prawiyogi = 0;
            }
            if(( $label[$j] =~ /^सम्बन्धः$/) && ($from[$j] == $to)) {              
                 $label = $NODE{$to}."-".$NODE{$to[$j]};
	 	 $node_entry{$to[$j]} = "";
                 $to = $to[$j];
            }
          }
       }
       if($label[$i] =~ /^सम्बन्धः$/) {
           if($NODE{$from[$i]} eq "न") { $label = "निषेधः";}
           elsif($NODE{$from[$i]} eq "एव") { $label = "अवधारण";}
           elsif($NODE{$from[$i]} eq "अपि") { $label = "अवधारण";}
#           else {$label = $label[$i];}
           if($label) {
             $edge_entry .= "Node".$from[$i]." -> Node".$to[$i]." [label=\"".$label."\" ".$misc[$i]."\n";
           }
       }
    }
   }
  foreach $key (%NODE) {
    print TMP1 $node_entry{$key},"\n";
  }
  print TMP1 $edge_entry;
  close(TMP1);
}
