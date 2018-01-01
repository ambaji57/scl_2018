#!PERLPATH -I LIB_PERL_PATH/

#  Copyright (C) 2013-2016 Amba Kulkarni (ambapradeep@gmail.com)
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

use Time::Out qw(timeout);

# Check in kAraka_names.pl; rel_numbers with >= 21 may have more than one candidates. (any aXikaraNa onwards)
$multiple_relations_begin = 21;
$TIMEOUT = 10;

tie(%kAraka_num,GDBM_File,"$ARGV[0]",GDBM_READER,0644) || die "Can't open $ARGV[0] for reading";

#Read the contents of  morph output, and build a graph showing all paths.
#The morph output is in a file with fileds separated by tabs.
#The fields are:
#Word_no opening_tag word closing_tag morph_ana1 morph_ana2 morph_ana3
#opening and closing tags are xml tags for sentence, paragraph markers.
#morph_ana1,2 and 3 correspond to MW_pratipadikas, Apte_pratipadikas and after pruning.


#The output of this function is a graph represented as an hash array with following fields, separated by tab.

#Index is: s_no,w_no,a_no (1st three constitute word_index below, and the last on analysis_index)
#where s_no: sent_no, w_no: word_no, a_no: morph_analysis_no

#word word_index,analysis_index analysis id left_node_id(s) Right_node_id(s)
#If there are more than one left and right node ids, they are separated by ','s.


$no_of_words = 0;
$no_of_nodes = 0;
#$/ = "\n\n";

open(IN, "<$ARGV[1]") || die "Can't open $ARGV[1] for reading";
open(REL, "<$ARGV[2]") || die "Can't open $ARGV[2] for reading";
$in = <REL>; # read 1st line rl1.clp

%ADJACENT = &build_paths_graph();

#Read the contents of graph{num}.txt

#This function builds 
# a) the relation graph stored in %REL, 
# %REL is a hash array. with key as destination, and value as the relation name and source.
# Thus corresponding to each word(destination), all the possible incoming arrows(rel_name and source) are stored.
#b) This function also notes down the positions of samucciwa words, if any.
#c) And it also generates viSeRya_bag for each viSeRaNa.

$samucciwa_wrd_pos = "";
$viSeRaNa_list = "";
%REL = ();

&build_relation_graph();

close(IN);
close(REL);

########### sub routine start #############
#parse is being called in this subroutine.
#However, if there is a separate bar.txt for each sentence, we may call it only once after the build_relation_graph.

sub build_relation_graph{

my($in,$rel,$key,$rel_no,$from,$from_mid,$s_pos);

while ($in = <REL>) {
   $in =~ s/\).*#.*//;
   $in =~ s/^\(//;
   $in =~ /^(([0-9]+ [0-9]+) ([0-9]+) ([0-9]+) ([0-9]+))/;
   $rel = $1;
   $key = $2;
   $rel_no = $3;
   $from = $4;
   $from_mid = $5;
   if(($rel_no >= $kAraka_num{"samucciwam1"}) && 
      ($rel_no <= $kAraka_num{"samucciwamhewu"})
     ) {
        $s_pos = ";".$from.",".$from_mid;
        if ($samucciwa_wrd_pos !~ /$s_pos/) { $samucciwa_wrd_pos .= $s_pos;}
    }
   if(($REL{$key} !~ /^$rel$/) && ($REL{$key} !~ /^#$rel$/) && ($REL{$key} !~ /^$rel#/) && ($REL{$key} !~ /^#$rel#/)) {
         $REL{$key} .= "#".$rel;
   }
}
&parse();
}

sub parse {

 my(@node_stack, @rel_stack, @path_stack, $stack_top);
 my($start,$total_combinations,$key,$count,@flds,@ROW,$current_node);
 my($rel,@rels,$node_id);

#Merge the information of two graphs: paths graph and relations graph into one matrix of ROWS, where each entry in ROWS correspond to each node of the graph.
# Rows has following fields after merging:
# Word s_w_a_id word_ana id left_id right_id rels
#s_w_a_id are seperated by ','s.
#rels are seperated by '#'s.
#left_ids and right_ids are also seperated by ','s.
#Example:
#xaSaraWasya	1,1,1	xaSaraWa<vargaH:nA><lifgam:puM><viBakwiH:6><vacanam:1><level:1>	1	S	3	1 1 52 2 1
#xaSaraWasya	1,1,2	xaSaraWa<vargaH:nA><lifgam:napuM><viBakwiH:6><vacanam:1><level:1>	2	S	3	1 2 52 2 1
#puwraH	1,2,1	puwra<vargaH:nA><lifgam:puM><viBakwiH:1><vacanam:1><level:1>	3	1,2	4,5	2 1 51 3 1#2 1 7 9 1
#rAmaH	1,3,1	rAma<vargaH:nA><lifgam:puM><viBakwiH:1><vacanam:1><level:1>	43	6,7,8	3 1 7 9 1
#rAmaH	1,3,2	rA1<prayogaH:karwari><lakAraH:lat><puruRaH:u><vacanam:3><paxI:parasmEpaxI><XAwuH:rA><gaNaH:axAxiH><level:1>	5	3	6,7,8	
#nagare	1,4,1	nagara<vargaH:nA><lifgam:napuM><viBakwiH:1><vacanam:2><level:1>	6	4,5	9	
#nagare	1,4,2	nagara<vargaH:nA><lifgam:napuM><viBakwiH:2><vacanam:2><level:1>	7	4,5	9	4 2 15 9 1
#nagare	1,4,3	nagara<vargaH:nA><lifgam:napuM><viBakwiH:7><vacanam:1><level:1>	8	4,5	9	4 3 24 9 1
#koSAw	1,5,1	koSa<vargaH:nA><lifgam:puM><viBakwiH:5><vacanam:1><level:1>	96,7,8	10	5 1 20 9 1#5 1 28 9 1
#haswena	1,6,1	haswa<vargaH:nA><lifgam:puM><viBakwiH:3><vacanam:1><level:1>	10	9	11	6 1 18 9 1#6 1 28 9 1
#brAhmaNAya	1,7,1	brAhmaNa<vargaH:nA><lifgam:puM><viBakwiH:4><vacanam:1><level:1>	11	10	12,13	7 1 19 9 1#7 1 43 3 2#7 1 43 9 1
#XanaM	1,8,1	Xana<vargaH:nA><lifgam:napuM><viBakwiH:1><vacanam:1><level:1>	12	11	14	8 1 7 9 1
#XanaM	1,8,2	Xana<vargaH:nA><lifgam:napuM><viBakwiH:2><vacanam:1><level:1>	13	11	14	8 2 15 9 1
#xaxAwi	1,9,1	xA3<prayogaH:karwari><lakAraH:lat><puruRaH:pra><vacanam:1><paxI:parasmEpaxI><XAwuH:duxAF><gaNaH:juhowyAxiH><level:1>	14	12,13	F

   foreach $key (keys %ADJACENT ){
     #print "key = $key\nREL = $REL{$key}\nADJ = $ADJACENT{$key}\n";
#print "key = $key REL = $REL{$key} \n";
#print "count = $count total combinations = $total_combinations\n";
     $ADJACENT{$key} .= "\t". $REL{$key};
     @flds = split(/\t/,$ADJACENT{$key});
     $ROW[$flds[3]] = $ADJACENT{$key};
     $ROW[$flds[3]] =~ s/\t#/\t/;
   } 

   #for ($i=1;$i<= $no_of_nodes; $i++) {
   #print $i," ", $ROW[$i],"\n";
   #}
   $rels = "";
   for ($i=1;$i<= $no_of_nodes; $i++) {
     @flds = split(/\t/,$ROW[$i]);
     $rels .= "#".$flds[6]; 
   }

   $rels =~ s/^#//;
   $rels =~ s/##/#/g;
   $rels =~ s/#$//g;

   @rels = split(/#/,$rels);
   for ($i=0;$i<= $#rels-1 ; $i++) {
     for ($j=$i+1;$j<= $#rels; $j++) {
        $r = $rels[$i]."_".$rels[$j];
        $compatible{$r} = &compatible_r1_r2($rels[$i],$rels[$j]);
        #print "compatibility $rels[$i] with $rels[$j] = $compatible{$r}\n";
        $r1 = $rels[$j]."_".$rels[$i];
        $compatible{$r1} = $compatible{$r};
     }
   }
#   for ($i=1;$i<= $no_of_nodes; $i++) {
#      print "2  ",$i," ", $ROW[$i],"\n";
#   }

#Remove entries corresponding to viSeRaNa and RaRTI sambanXa
# Following is not done, since the next module takes care of this
#, and modify the paths dropping the nodes with only viSeRaNa and/or RaRTI sambanXas.
   $viSeRaNa_list = "";
   $RaRTI_list = "";
   for ($i=1;$i<= $no_of_nodes; $i++) {
      @flds = split(/\t/,$ROW[$i]);
      $rels = $flds[6];
      @r = split(/#/,$rels);
      $new_rels = "";
      foreach $r (@r) {
       if(($r =~ /[0-9]+ [0-9]+ $kAraka_num{"viSeRaNam"} [0-9]+ [0-9]+/)  ||
          ($r =~ /[0-9]+ [0-9]+ $kAraka_num{"RaRTIsambanXaH"} [0-9]+ [0-9]+/)) {
          if($r =~ /([0-9]+ [0-9]+) $kAraka_num{"viSeRaNam"} ([0-9]+ [0-9]+)/) {
             $viSeRaNa = $1; $viSeRya = $2;
#             print "viSeRya = $viSeRya viSeRaNa = $viSeRaNa\n";
             if(($viSeRaNam{$viSeRya} !~ /#$viSeRaNa$/) && 
                   ($viSeRaNam{$viSeRya} !~ /^$viSeRaNa$/) &&
                   ($viSeRaNam{$viSeRya} !~ /^$viSeRaNa#/) &&
                   ($viSeRaNam{$viSeRya} !~ /#$viSeRaNa#/)) {
                       $viSeRaNam{$viSeRya} .= "#".$viSeRaNa;
             }
             if(( $viSeRya{$viSeRaNa} !~ /#$viSeRya$/) &&
                   ( $viSeRya{$viSeRaNa} !~ /^$viSeRya$/) &&
                   ( $viSeRya{$viSeRaNa} !~ /^$viSeRya#/) &&
                   ( $viSeRya{$viSeRaNa} !~ /#$viSeRya#/)){
                       $viSeRya{$viSeRaNa} .= "#".$viSeRya;
#                    print "viSeRya = $viSeRya viSeRaNa = $viSeRaNa\n";
             }
             if(( $viSeRaNa_list !~ /#$viSeRaNa$/) &&
                   ( $viSeRaNa_list !~ /^$viSeRaNa$/) &&
                   ( $viSeRaNa_list !~ /^$viSeRaNa#/) &&
                   ( $viSeRaNa_list !~ /#$viSeRaNa#/)){
                       $viSeRaNa_list .= "#".$viSeRaNa;
             }
             #print "viSeRaNa list = $viSeRaNa_list viSeRana = $viSeRaNa\n";
          }
          if($r =~ /([0-9]+ [0-9]+) $kAraka_num{"RaRTIsambanXaH"} ([0-9]+ [0-9]+)/) {
             $RaRTI_sambanXI = $2; $RaRTI_vAcaka = $1;
#             print STDERR "RaRTI key = $RaRTI_sambanXI val = $RaRTI_vAcaka\n";
             if (($RaRTI{$RaRTI_sambanXI} !~ /^$RaRTI_vAcaka$/) &&
                    ($RaRTI{$RaRTI_sambanXI} !~ /^$RaRTI_vAcaka#/) &&
                    ($RaRTI{$RaRTI_sambanXI} !~ /#$RaRTI_vAcaka#/) &&
                    ($RaRTI{$RaRTI_sambanXI} !~ /#$RaRTI_vAcaka$/)) {
                       $RaRTI{$RaRTI_sambanXI} .= "#".$RaRTI_vAcaka;
             }
             if(( $RaRTIsambanXI{$RaRTI_vAcaka} !~ /^$RaRTI_sambanXI$/) && 
                ( $RaRTIsambanXI{$RaRTI_vAcaka} !~ /^$RaRTI_sambanXI#/) && 
                ( $RaRTIsambanXI{$RaRTI_vAcaka} !~ /#$RaRTI_sambanXI$/) && 
                ( $RaRTIsambanXI{$RaRTI_vAcaka} !~ /#$RaRTI_sambanXI#/)){
                    $RaRTIsambanXI{$RaRTI_vAcaka} .= "#".$RaRTI_sambanXI;
            }
            if (($RaRTI_list !~ /^$RaRTI_vAcaka$/) &&
                ($RaRTI_list !~ /^$RaRTI_vAcaka#/) &&
                ($RaRTI_list !~ /#$RaRTI_vAcaka#/) &&
                ($RaRTI_list !~ /#$RaRTI_vAcaka$/)) {
                   $RaRTI_list .= "#".$RaRTI_vAcaka;
            }
          }
           $left_ids = $flds[4];
           $right_ids = $flds[5];
           @ROW = split(/=/,&modify_right_node_of_left_ids($left_ids, $i, $right_ids,"add",@ROW));
           @ROW = split(/=/,&modify_left_node_of_right_ids($left_ids, $i, $right_ids,"add",@ROW));
          } else { $new_rels .= "#". $r;}
         }
         $new_rels =~ s/^#//;
         $flds[6] = $new_rels;
         $ROW[$i] = join('	',@flds);
      }
#   for ($i=1;$i<= $no_of_nodes; $i++) {
#      print "3  ",$i," ", $ROW[$i],"\n";
#   }
   $viSeRaNa_list =~ s/^#//;
   $RaRTI_list =~ s/^#//;
#   print "viSeRaNa list = $viSeRaNa_list\n";
#print STDERR "RaRTI list = $RaRTI_list\n";

# remove edges marked niwya_sambanXaH
   $niwya_sambanXa = "";
   for ($i=1;$i<= $no_of_nodes; $i++) {
   @flds = split(/\t/,$ROW[$i]);
   $left_ids = $flds[4];
   $right_ids = $flds[5];
   $rels = $flds[6];
   if($rels =~ / $kAraka_num{"niwya_sambanXaH"} /){
         $new_rels = "";
         @r = split(/#/,$rels);
         foreach $r (@r) {
           if($r !~ / $kAraka_num{"niwya_sambanXaH"} /) {
                $new_rels .= "#".$r;
           } else { $niwya_sambanXa .= "#".$r;}
         }
         $new_rels =~ s/^#//;
         $flds[6] = $new_rels;
         $ROW[$i] = join('	',@flds);
    }
    #print "i =$i row = $ROW[$i]\n";
   }
    $niwya_sambanXa =~ s/^#//;
    #print STDERR "niwya_sambanXaH = $niwya_sambanXa\n";

# remove edges from paths_graph with empty relations. -- Bypass nodes with empty relations
   for ($i=1;$i<= $no_of_nodes; $i++) {
   #print "i $ROW[$i]\n";
   @flds = split(/\t/,$ROW[$i]);
   $left_ids = $flds[4];
   $right_ids = $flds[5];
   $rels = $flds[6];
   if(($rels eq "") && ($left_ids ne "") && ($right_ids ne "")){
      #print "Processing i = $i ROW = $ROW[$i]\n";
      #print "Replacing $i of the right id by $right_ids of node=$left_ids\n";
             #print "before entering 3\n";
      @ROW = split(/=/,&modify_right_node_of_left_ids($left_ids, $i,$right_ids,"replace",@ROW));
             #print "before entering 4\n";
      @ROW = split(/=/,&modify_left_node_of_right_ids($left_ids, $i,$right_ids,"replace",@ROW));
      $ROW[$i] = join('	',@flds);
      #print " i =$i row = $ROW[$i]\n";
    }
   }

# Note down the nodes to start the process
#This is equivalent to creating a node with empty values for each field except the right node.
   $start = "";
   for ($i=1;$i<= $no_of_nodes; $i++) {
      @flds = split(/\t/,$ROW[$i]);
      if($flds[4] =~ /S/) { 
        if(($start !~ /,$flds[3]$/) && ($start !~ /^$flds[3],/) && ($flds[3] !~ /^$flds[3],/) && ($start !~ /^$flds[3]$/)) {$start .= ",".$flds[3];}
      }
      #print STDERR "4  ",$i," ", $ROW[$i],"\n";
   }

   #print "start = $start\n";
   $start =~ s/^,//;
   $node_stack[0] = $start;
   $rel_stack[0] = "";
   $path_stack[0] = "";
   $stack_top = 0;
   $parse_count = 0;
   $partial_parse_count = 0;
   $final_parse[0] = "";
   $final_partial_parse[0] = "";

   timeout $TIMEOUT => sub {

   while($node_stack[$stack_top] ne "") {
    #print "0 stack_top = $stack_top node_stack = $node_stack[$stack_top]\n";
    $node_stack[$stack_top] =~ /^([0-9SF]+),?(.*)/;
    $current_node = $1;
    #print "current_node = $current_node\n";
    $node_stack[$stack_top] = $2;
    $path_stack[$stack_top] = $path_stack[$stack_top-1].",".$1;
    @flds = split(/\t/,$ROW[$current_node]);
    #print STDERR "rels = $flds[6]\n";
    @rels = split(/#/,$flds[6]);
    $node_id = $flds[1];
    $node_id =~ s/^([0-9]+),([0-9]+)/$1 $2/;
    #print "node_id = $node_id\n";
    $stack_top++;
    $node_stack[$stack_top] = $flds[5];
#    print "stack_top = $stack_top node_stack = $node_stack[$stack_top]\n";
#    print "row = ",$ROW[$current_node],"\n";
    @rels_so_far = split(/#/,$rel_stack[$stack_top-1]);
    #print STDERR "rels so far = $rel_stack[$stack_top-1]\n";
    if($#rels <0) { $#rels = 0;}
    if($#rels_so_far <0) { $#rels_so_far = 0;}
    $cmptbl = 0;
    $tmp_product="";
    for ($i=0;$i<=$#rels;$i++) {
     #print "i = $i ";
     #print "rels = $rels[$i]\n";
     for ($j=0; $j<=$#rels_so_far;$j++) {
      #print "	j = $j ";
       #print "rels_so_far = $rels_so_far[$j]\n";
       if($rels[$i] eq ""){
         if ($rels_so_far[$j] ne "") {
           if(&compatible_mo($node_id,$rels_so_far[$j]) == 1) {
             $cmptbl = 1; 
             $tmp_product .= "#".$rels_so_far[$j];
             #print STDERR "1 tmp = $tmp_product\n";
           }
         }
       } elsif($rels_so_far[$j] eq "") {
          #print "node_id = $node_id\n";
          #print "rels i = $rels[$i]\n";
          if(&compatible_mo($node_id,$rels[$i]) == 1) { 
             $cmptbl = 1;
             $tmp_product .= "#".$rels[$i];
             #print "2 tmp = $tmp_product\n";
          }
       } elsif(&compatible($rels[$i],$rels_so_far[$j]) && 
               (&compatible_mo($node_id,$rels_so_far[$j]) == 1) && 
               (&compatible_mo($node_id,$rels[$i]) == 1)) { 
               $cmptbl = 1;
                  $t = $rels_so_far[$j].";".$rels[$i];
                  if(($tmp_product !~ /^$t$/) && 
                     ($tmp_product !~ /#$t$/) && 
                     ($tmp_product !~ /#$t#/) && 
                     ($tmp_product !~ /^$t#/)) {
                      $tmp_product .= "#".$t;
                  }
             #print STDERR "3 tmp = $tmp_product\n";
       }
      }
    }
    #print STDERR "3 tmp = $tmp_product\n";
#    print "cmptbl = $cmptbl\n";
    if($cmptbl) { 
        $rel_stack[$stack_top] = $tmp_product;
        $rel_stack[$stack_top] =~ s/^#+//;
    }

    if($cmptbl == 0) {
       $stack_top--;
       while(($node_stack[$stack_top] eq "") && ($stack_top >= 0)) { 
              $stack_top--; 
       }
    }
    
    #print "stack top = $stack_top\n";
    #print "node stack = $node_stack[$stack_top]\n";
    #print "cmptbl = $cmptbl\n";
    if($cmptbl) {
      #print "1 stack_top = $stack_top rel_stack = $rel_stack[$stack_top]\n";
      if($node_stack[$stack_top] =~ /F/) {
      #print "2 stack_top = $stack_top rel_stack = $rel_stack[$stack_top]\n";
      if($rel_stack[$stack_top]) {
       @tmp = split(/#/,$rel_stack[$stack_top]);
         $tmp_viSeRaNa_list = $viSeRaNa_list;
         $tmp_RaRTI_list = $RaRTI_list;
         #print STDERR "total partial parses = $#tmp\n";
         for ($t=0; $t<=$#tmp; $t++) {
               #print STDERR "parse_count = $parse_count\n";
               #print STDERR "tmp $t = $tmp[$t]\n";
#               print "current parse = $p\n";
                     if($niwya_sambanXa ne "") {
                        @r = split(/#/,$niwya_sambanXa);
                        foreach $r (@r) {
                           #print "r = $r\n";
                           $r =~ /^([^ ]+ [^ ]+) [^ ]+ ([^ ]+ [^ ]+)/;
                           $f = $1; $s = $2;
                           #print "tmp = $tmp[$t]\n";
                          if(&compatible_mo($f,$tmp[$t]) && &compatible_mo($s,$tmp[$t])) {
                                #print "compatible mo \n";
                                $tmp[$t] .= ";".$r;
                                &chk_necessary($tmp[$t]);
                          }
                        }
                      } else { &chk_necessary($tmp[$t]);}
               #print "parse_count = $parse_count\n";
               #print "current parse = $p\n";
               #print "parse_count = $parse_count\n";
#               print STDERR "A tmp $t = $tmp[$t]\n";
               $new_tmp = $tmp[$t];
               @t1 = split(/;/,$tmp[$t]);
# For each of the anuyogis of the relation, check whether there are any viSeRaNas and RaRTI sambanXaHs. If yes, add them to the parsed output after checking the compatibility.
#AMBA: 31st Jan 2015: While adding the viSeRaNas and RaRTI relations also we have to take into account the distributivity.
# Example: jagawkarwuH mahimnAM PalaM sarvawra xqSyawe
#Current implementation gives only one soln: 1->3, 2->3; we also need 1->2->3
#Another problem, AwmanaH puwrANAM karmasu kOSalaM praSaMsawi
               foreach $t1 (@t1) {
                  $t1 =~ /^([0-9]+ [0-9]+) [0-9]+ [0-9]+ [0-9]+$/;
                  $key = $1;
                  $v = $viSeRaNam{$key};
#                  print "viSeRaNas for $key = $v\n";
                  $v =~ s/^#//;
                  @v = split(/#/,$v);
#                  print "44 new_tmp = $new_tmp\n";
                if($v) {
                  foreach $v (@v) {
                     @parses_so_far = split(/#/,$new_tmp);
                     $new_parse = "";
                      foreach $p (@parses_so_far) {
#                       print "p = $p\n";
                       $viSeRaNa_num = $kAraka_num{"viSeRaNam"};
                       $r = "$v $viSeRaNa_num $key";
#                       print "r = $r\n";
                       if(($p !~ /^$r$/) &&
                          ($p !~ /^$r;/) &&
                          ($p !~ /;$r;/) &&
                          ($p !~ /;$r$/)){
                       if(&compatible($r,$p)) {
                       if((&compatible_mo($v,$p) == 1) &&
                         (&compatible_mo($key,$p) == 1))
                       {
                         $v =~ /^([0-9]+) [0-9]+/;
                         $wrd_no = $1;
                         $tmp_viSeRaNa_list =~ s/[#;]$wrd_no [^#;]+//g;
                         $tmp_viSeRaNa_list =~ s/^$wrd_no [^#;]+//g;
#                       print "tmp_v_list = $tmp_viSeRaNa_list\n";
                         if($new_parse eq "") { $new_parse = $p.";".$r;}
                         else {$new_parse .= ";". $r;}
#                         print "0 new_parse = $new_parse\n";
                       } else {
                         $new_parse .= "#". $p.";".$r;
                       }
                      }
#                       print "1 new_parse = $new_parse\n";
                     }
                    }
                    $new_parse =~ s/^#//;
                    $new_parse =~ s/^;//;
                    if($new_parse ne "") { $new_tmp = $new_parse;}
                  }
#                    print " 1 new_tmp = $new_tmp\n";
                }
#                print "A new_tmp = $new_tmp\n";
#                print STDERR "key =  $key\n";
                $v = $RaRTI{$key};
                if($v) {
#                  print "RaRTI for $key = $v\n";
                  $v =~ s/^#//;
                  @v = split(/#/,$v);
                  foreach $v (@v) {
                     @parses_so_far = split(/#/,$new_tmp);
                     $new_parse = "";
                     foreach $p (@parses_so_far) {
                        $RaRTI_num = $kAraka_num{"RaRTIsambanXaH"};
                        $r = "$v $RaRTI_num $key";
#                        print "p = $p\n";
#                        print "r = $r\n";
                       if(($p !~ /^$r$/) &&
                          ($p !~ /^$r;/) &&
                          ($p !~ /;$r;/) &&
                          ($p !~ /;$r$/)){
                        if(&compatible($r,$p)){
#                        print "1 compatible\n";
                        if((&compatible_mo($v,$p) == 1) &&
                          (&compatible_mo($key,$p) == 1)){
#                        print "2 compatible\n";
                          $v =~ /^([0-9]+) [0-9]+/;
                          $wrd_no = $1;
                          $tmp_RaRTI_list =~ s/#$wrd_no [^#]+//g;
                          $tmp_RaRTI_list =~ s/^$wrd_no [^#]+//g;
#                         print STDERR "tmp_RaRTI_list = $tmp_RaRTI_list\n";
                          $new_parse .= "#". $p.";".$r;
#                          print "new_parse = $new_parse\n";
                        } else {
                       #   $new_parse .= "#". $p.";".$r;
                        }
                       }
                      }
                   }
                    $new_parse =~ s/^#//;
                    $new_parse =~ s/^;//;
                    if($new_parse ne "") { $new_tmp = $new_parse;}
              }
            }
          } # for each t1
#            print "B new_tmp = $new_tmp\n";

## Now add the viSeRaNas that are not added earlier..
#              if($tmp_viSeRaNa_list) {
#              @tR = split(/#/,$tmp_viSeRaNa_list);
##              print "tmp_viSeRaNa_list = $tmp_viSeRaNa_list\n";
#              foreach $tR (@tR) {
#               $val = $viSeRya{$tR};
#               $val =~ s/^#//;
##               print " tR = $tR val = $val\n";
#               @valR = split(/#/,$val);
#               foreach $valR (@valR) {
#                 $r = $tR." ".$kAraka_num{"viSeRaNam"}." ".$valR;
#                 #print " r = $r new_tmp = $new_tmp\n";
#                 @parses_so_far = split(/#/,$new_tmp);
#                 $new_parse = "";
#                 foreach $p (@parses_so_far) {
##                 print " r = $r p = $p\n";
#                       if(($p !~ /^$r$/) &&
#                          ($p !~ /^$r;/) &&
#                          ($p !~ /;$r;/) &&
#                          ($p !~ /;$r$/)){
#                   if(&compatible($r,$p)){
#                     if((&compatible_mo($tR,$p) == 1) &&
#                       (&compatible_mo($valR,$p) == 1)){
#                          $new_parse .= "#".$p.";". $r;
#                     }
#                   }
#                  }
#                 }
#                 }
#                  $new_parse =~ s/^#//;
#                  $new_parse =~ s/^;//;
#                  if($new_parse ne "") { $new_tmp = $new_parse;}
#             }
#             }
#              print "C new_tmp = $new_tmp\n";
#
## Look at the remaining RaRTI sambanXaHs, and add them.
#
##              print " 2 new_tmp = $new_tmp\n";
#              @tR = split(/#/,$tmp_RaRTI_list);
##              print "tmp_RaRTI_list = $tmp_RaRTI_list\n";
#              if($tmp_RaRTI_list) {
#              foreach $tR (@tR) {
#               $val = $RaRTIsambanXI{$tR};
##               print "tR = $tR val = $val\n";
#               @valR = split(/#/,$val);
#               foreach $valR (@valR) {
#                  $r = $tR." ".$kAraka_num{"RaRTIsambanXaH"}." ".$valR;
##                  print " r = $r new_parse = $new_tmp\n";
#                  @parses_so_far = split(/#/,$new_tmp);
#                  $new_parse = "";
#                  foreach $p (@parses_so_far) {
##                    print " p = $p\n";
#                       if(($p !~ /^$r$/) &&
#                          ($p !~ /^$r;/) &&
#                          ($p !~ /;$r;/) &&
#                          ($p !~ /;$r$/)){
#                    if (&compatible($r,$p)){
#                    if((&compatible_mo($tR,$p) == 1) && 
#                      (&compatible_mo($valR,$p) == 1)) {
#                          $new_parse .= "#".$p.";". $r;
#                     }
#                    }
#                   }
##                       print "3 new_parse = $new_parse\n";
#                  }
#                  $new_parse =~ s/^#//;
#                  $new_parse =~ s/^;//;
#                  if($new_parse ne "") { $new_tmp = $new_parse;}
#               }
#              }
#             }
#              print "D new_tmp = $new_tmp\n";
#
             if($new_tmp ne $tmp[$t]) {
              @parses_so_far = split(/#/,$new_tmp);
              foreach $p (@parses_so_far) {
                    &chk_necessary($p);
#               print "parse_count = $parse_count\n";
#               print "current parse = $p\n";
              }
            }
         } # for $t
       } # if rel_stack
       $node_stack[$stack_top] =~ s/F,//;
       $node_stack[$stack_top] =~ s/,F,/,/;
       $node_stack[$stack_top] =~ s/,F//;
       $node_stack[$stack_top] =~ s/F//;
       if($node_stack[$stack_top] eq "" ){ $stack_top--;}
       #print "3 stack_top = $stack_top rel_stack = $rel_stack[$stack_top]\n";
       while(($node_stack[$stack_top] eq "") && ($stack_top >= 0)) { 
              $stack_top--;
       }
       #print "4 stack_top = $stack_top rel_stack = $rel_stack[$stack_top]\n";
     }
       #print "5 stack_top = $stack_top rel_stack = $rel_stack[$stack_top]\n";
    }
   }
   
   } ; #end timeout
   

   @final_parse_sorted = sort {$a <=> $b} (@final_parse);
   if($parse_count == 0) {
     @final_partial_parse_sorted = sort {$a <=> $b} (@final_partial_parse);
   }
   print "1.minion\n";
   if($parse_count > 0) {
      print "Total Complete Solutions=$parse_count\n";
      &print_solutions($parse_count,@final_parse_sorted);
   } else {
      print "Total Partial Solutions=$partial_parse_count\n";
      &print_solutions($partial_parse_count,@final_partial_parse_sorted);
   }
}
1;

  sub print_solutions{
  my($count, @parse_array) = @_;

  my($i);

   for($i=1;$i<=$count;$i++) {
    @parses = split(/;/,$parse_array[$i-1]);
    print "Solution:$i\n";
    for($j=1; $j<=$#parses; $j++) {
    @flds = split(/ /,$parses[$j]);
    $flds[0]--;
    $flds[1]--;
    $flds[3]--;
    $flds[4]--;
    print "(",$flds[0],",",$flds[1],",",$flds[2],",",$flds[3],",",$flds[4],")\n";
    }
     print "Cost = $parses[0]\n\n";
   }
 }
1;

sub compatible_r1_r2{
my($relation1,$relation2) = @_;

my($wrd_no1,$mid1,$rel1,$from_wrd1,$from_mid1);
my($wrd_no2,$mid2,$rel2,$from_wrd2,$from_mid2);
my($ans);

$ans = 1;

$relation1 =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
$wrd_no1 = $1; $mid1 = $2; $rel1 = $3; $from_wrd1 = $4; $from_mid1 = $5; 
# A word can not be the source word for itself.
# This is taken care of by CLIPS programme. So this is not needed here.

#  if(($wrd_no eq $from_wrd) && ($mid ne $from_mid)) {  # print "cond 1\n"; 
#      return 0; 
#  }

  $relation2 =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
  $wrd_no2 = $1; $mid2 = $2; $rel2 = $3; $from_wrd2 = $4; $from_mid2 = $5;

#If a word with a certain mid is chosen, then all the edges going to or coming from other mids of the same id are to be rejected.
## Amba's comment: Does path not take care of this condition?
  if(($wrd_no1 eq $wrd_no2) && ($mid1 ne $mid2)) {  #  print "cond 2\n"; 
      $ans = 0; 
  }
  if(($wrd_no1 eq $from_wrd2) && ($mid1 ne $from_mid2)) { #   print "cond 3\n"; 
      $ans = 0; 
  }
  if(($from_wrd1 eq $wrd_no2) && ($from_mid1 ne $mid2)) { #   print "cond 4\n"; 
      $ans = 0; 
  }
  if(($from_wrd1 eq $from_wrd2) && ($from_mid1 ne $from_mid2)) { #   print "cond 5\n"; 
      $ans = 0; 
  }
# Only one relation per word
  if(($wrd_no1 eq $wrd_no2) && ($mid1 eq $mid2) && ($rel1 ne $rel2)) { #   print "cond 6\n"; 
      $ans = 0; 
  }
  if(($wrd_no1 eq $wrd_no2) && ($mid1 eq $mid2) && ($rel1 eq $rel2) && ($from_wrd1 ne $from_wrd2)) { #   print "cond 6\n"; 
      $ans = 0; 
  }
# There can not be more than one kaaraka relations per word
  if(($from_wrd1 eq $from_wrd2) && ($from_mid1 eq $from_mid2) && ($rel1 eq $rel2) && ($rel1 < $multiple_relations_begin)) { #   print "cond 7\n"; 
      $ans = 0; 
  }
## If there is an upapaxasambanXaH relation, the other relation with upapaxa should be sambanXaH
#  if(($rel1 == $kAraka_num{"upapaxasambanXaH"}) && ($from_wrd1 == $wrd_no2) && ($from_mid1 == $mid2) && ($rel2 != $kAraka_num{"sambanXaH"})) {   # print "cond 8\n"; 
#      $ans = 0; 
#    }
#  if(($rel1 == $kAraka_num{"sambanXaH"}) && ($wrd_no1 == $from_wrd2) && ($mid1 == $from_mid2) && ($rel2 != $kAraka_num{"upapaxasambanXaH"})) {   # print "cond 9\n"; 
#      $ans = 0; 
#    }
#With upapaxasambanXaH always it is not sambanXa. For example,
#SaTaH nqpasya purawaH asawyaM avaxaw
#Here purawaH has upapaxasambanXa with nqpasya and xeSAXikaraNam with avaxaw.

# If a word has prawiyogI relation, on the other side it should have anuyogI relation, or sambanXaH.
  if(($rel1 == $kAraka_num{"prawiyogI"}) && ($from_wrd1 == $wrd_no2) && ($from_mid1 == $mid2) && ($rel2 != $kAraka_num{"anuyogI"}) && ($rel2 != $kAraka_num{"sambanXaH"})) {   # print "cond 10\n"; 
      $ans = 0; 
    }
  if(($rel1 == $kAraka_num{"anuyogI"}) && ($wrd_no1 == $from_wrd2) && ($mid1 == $from_mid2) && ($rel2 != $kAraka_num{"prawiyogI"}) && ($rel2 != $kAraka_num{"sambanXaH"})) { #   print "cond 11\n"; 
      $ans = 0; 
    }

#If a word is karwqsamAnAXikaraNam, it can not have a viSeRaNam.
#Ex: kiM vakre xehe AwmA vakraH Bavawi?
#Here the following analysis is WRONG:
# vakraH is a karwqsamAnAXikaraNa, AwmA is its viSeRaNa, kiM as kartA
#This is a wrong example. How can kim and AwmA have karwA-karwq-samAnAXikaraNa relation?
#  if(($rel1 == $kAraka_num{"karwqsamAnAXikaraNam"}) && ($from_wrd1 == $wrd_no2) && ($from_mid1 == $mid2) && ($rel2 == $kAraka_num{"viSeRaNam"})) { 
#      $ans = 0;   # print "cond 12\n"; 
#    } 

  if(($wrd_no2 < $wrd_no1) && ($from_wrd2 < $from_wrd1) && ($from_wrd2 > $wrd_no1) && ($rel1 != $kAraka_num{"niwya_sambanXaH"}) && ($rel2 != $kAraka_num{"niwya_sambanXaH"})) { $ans = 0; #print "cond 13\n";
    #    print "no cross linking = $no_cross_linking\n";
       # print "cross linking failed cond1 $rel[$j];  $rel[$k]\n";
      }
       if(($wrd_no2 > $wrd_no1) && ($from_wrd2 > $from_wrd1) && ($wrd_no2 < $from_wrd1) && ($rel1 != $kAraka_num{"niwya_sambanXaH"}) && ($rel2 != $kAraka_num{"niwya_sambanXaH"})) { $ans = 0; #print "cond 14\n";
     #   print "cross linking failed cond2 $rel[$j];  $rel[$k]\n";
      }
     #print "cross links = $no_cross_linking\n";
#}
#print "compatible_r1_r2 = $ans\n";
$ans;
}
1;

sub compatible{
my($entry,$relations) = @_;

my($i,$j,$r,@relations);
my($ans);

$ans = 1;

$entry =~ s/^;//;
@entry = split(/;/,$entry);
$relations =~ s/^;//;
@relations = split(/;/,$relations);
for ($i=0;$i<=$#entry && $ans; $i++){
 for ($j=0;$j<=$#relations && $ans; $j++){
  #print "Checking compatibility of $entry[$i] with $relations[$j]\n";
  $r = $entry[$i]."_".$relations[$j];
  $ans = $compatible{$r};
  #print "compatibility = $ans\n";
 } 
} 

#print "compatible = $ans\n";
$ans;
}
1;

sub compatible_mo{
my($entry,$relations) = @_;
#print "within compatbile_mo entry = $entry\n";
#print "within compatbile_mo relations = $relations\n";

my($wrd_no,$mid,$rel);
my($cwrd_no,$cmid,$crel1,$cfrom_wrd,$cfrom_mid);
my($ans);

$ans = 1;
$entry =~ /^([^ ]+) ([^ ]+)/;
$wrd_no = $1;
$mid = $2;
#print "wrd_no = $wrd_no mid = $mid\n";

$relations =~ s/^;//;
@relations = split(/;/,$relations);

foreach $rel (@relations) {
  $rel =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
  #print "rel = $rel\n";
  $cwrd_no = $1;
  $cmid = $2;
  $cfrom_wrd = $4;
  $cfrom_mid = $5;

  if($wrd_no == $cwrd_no){
   if($mid != $cmid) { $ans = 0;}
  }
  if($wrd_no == $cfrom_wrd){
   if($mid != $cfrom_mid) { $ans =  0;}
  }
#If X and Y are related to each other by niwya sambanXa, and x-X and y-Y are related, then x and y should not be related to each other.
 if($relations =~ / $kAraka_num{"niwya_sambanXaH"} /) {
#    print "Within compatible_mo checking niwya sambanXa\n";
    for($j=0; $j<=$#relations && $ans; $j++){
      $relations[$j] =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
      $wrd_no = $1; $mid = $2; $rel1 = $3; $from_wrd = $4; $from_mid = $5; 
      if($rel1 == $kAraka_num{"niwya_sambanXaH"}) { # If this is a niwya sambanXa between X(wrd_no, mid) and Y(from_wrd,from_mid)
         $x_found = 0; $y_found = 0;
         for($k=0; $k<=$#relations && $ans; $k++){
           if ($relations[$k] =~ /^$wrd_no $mid ([^ ]+) (.*)$/) { #Get the co-ordinates of the word to which X is related (say x)
              if ($1 != $rel1) {
                 $X_hd = $2; $x_found = 1;
                 for($l=0; $l<=$#relations && $ans; $l++){
                   if ($relations[$l] =~ /^$from_wrd $from_mid ([^ ]+) (.*)$/){ #Get the co-ordinates of the word to which Y is related (say y)
                      if($1 != $rel1) {
                         $Y_hd = $2; $y_found = 1;
#                         print "co-ord = $X_hd ;; $Y_hd\n";
                         if (($X_hd == $Y_hd) ||
                             ($relations =~ /^$X_hd [^ ]+ $Y_hd;/) || ($relations =~ /^$Y_hd [^ ]+ $X_hd;/) ||
                             ($relations =~ /^$X_hd [^ ]+ $Y_hd$/) || ($relations =~ /^$Y_hd [^ ]+ $X_hd$/) ||
                             ($relations =~ /;$X_hd [^ ]+ $Y_hd;/) || ($relations =~ /;$Y_hd [^ ]+ $X_hd;/) ||
                             ($relations =~ /;$X_hd [^ ]+ $Y_hd$/) || ($relations =~ /;$Y_hd [^ ]+ $X_hd$/)){ # If x and y are related, reject the analysis
#                               print "incompatible solution in = $relations\n";
                               $ans = 0;
                          }
                       }
                   }
                }
              }
           }
         }
      }
      if(!$x_found || !$y_found) {$ans = 0;}
    }
 }
}
#print "ans = $ans\n";
#print "compatible_mo = $ans\n";
$ans;
}
1;

sub complete_parse{
my($rel, $words) = @_;

my($count);
$count = ($rel =~ s/;/;/g);
#$nc = ($rel =~ s/ ($kAraka_num{"niwya_sambanXaH"}) / $1/g);
#$count = $count - $nc;
#If there are 3 words, 2 relations, and hence only one ';' separator.
#print "count = $count words = $words \n";
if($count == $words-2) { return 1;}
return 0;
}
1;

sub necessary_conditions{
my($in) = @_;
my(@rel,$rel,$j,$k,$found_karwA,$found_karma,$found_samucciwam);
my($found_samucciwa_links,@sam_words);
my($wrd,$wrd_no,$mid,$from,$from_mid,$rel1);
my($wrd_no2,$mid2,$rel2,$from_wrd2,$from_mid2);

my($karwqsamAnAXikaraNa, $karmasamAnAXikaraNa, $found_samucciwam, $found_samucciwa_links, $anuyogI, $prawiyogI, $viSeRaNam, $niwya_sambanXaH, $necessary_condition);

$karwqsamAnAXikaraNa=1;
$karmasamAnAXikaraNa=1;
$found_samucciwam=1;
$found_samucciwa_links = 1;
$anuyogI = 1;
$prawiyogI = 1;
$viSeRaNam = 1;
$niwya_sambanXaH=1;

#print "within necessary condition $in\n";
@rel = split(/;/,$in);
##If X and Y are related to each other by niwya sambanXa, and x-X and y-Y are related, then x and y should not be related to each other.
# if($in =~ / $kAraka_num{"niwya_sambanXaH"} /) {
#    for($j=0; $j<=$#rel && $niwya_sambanXaH; $j++){
#      $rel[$j] =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
#      $wrd_no = $1; $mid = $2; $rel1 = $3; $from_wrd = $4; $from_mid = $5; 
#      if($rel1 == $kAraka_num{"niwya_sambanXaH"}) { # If this is a niwya sambanXa between X(wrd_no, mid) and Y(from_wrd,from_mid)
#         for($k=0; $k<=$#rel && $niwya_sambanXaH; $k++){
#           if ($rel[$k] =~ /^$wrd_no $mid ([^ ]+) (.*)$/) { #Get the co-ordinates of the word to which X is related (say x)
#              if ($1 != $rel1) {
#                 $X_hd = $2;
#                 for($l=0; $l<=$#rel && $niwya_sambanXaH; $l++){
#                   if ($rel[$l] =~ /^$from_wrd $from_mid ([^ ]+) (.*)$/){ #Get the co-ordinates of the word to which Y is related (say y)
#                      if($1 != $rel1) {
#                         $Y_hd = $2;
#                        # print "co-ord = $X_hd ;; $Y_hd\n";
#                         if (($in =~ /^$X_hd [^ ]+ $Y_hd;/) || ($in =~ /^$Y_hd [^ ]+ $X_hd;/) ||
#                             ($in =~ /^$X_hd [^ ]+ $Y_hd$/) || ($in =~ /^$Y_hd [^ ]+ $X_hd$/) ||
#                             ($in =~ /;$X_hd [^ ]+ $Y_hd;/) || ($in =~ /;$Y_hd [^ ]+ $X_hd;/) ||
#                             ($in =~ /;$X_hd [^ ]+ $Y_hd$/) || ($in =~ /;$Y_hd [^ ]+ $X_hd$/)){ # If x and y are related, reject the analysis
#                            #   print "incompatible solution in = $in\n";
#                               $niwya_sambanXaH = 0;
#                          }
#                       }
#                   }
#                }
#              }
#           }
#         }
#      }
#    }
# }

#Earlier we were drawing karwqsamanAXikaraNam from the verb
#Now we draw it from the karwA. Hence the following is changed accordingly.
# We go back to the earlier decision, which is correct. The karwqsamAnAXikaraNa is marked with a verb and not with a karwA.
 if($in =~ / $kAraka_num{"karwqsamAnAXikaraNam"} /) {
  for($j=0; $j<=$#rel && $karwqsamAnAXikaraNa; $j++){
    $rel[$j] =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
    $wrd_no = $1; $mid = $2; $rel1 = $3; $from_wrd = $4; $from_mid = $5; 

    #Check karwqsamAnAXikaraNam, karwA compatibility
    if($rel1 == $kAraka_num{"karwqsamAnAXikaraNam"}) {
       #if (($in !~ / $kAraka_num{"karwA"} $from_wrd $from_mid;/) && 
       #    ($in !~ / $kAraka_num{"karwA"} $from_wrd $from_mid$/))
       if (($in !~ / $kAraka_num{"karwA"} $from_wrd $from_mid$/) && 
           ($in !~ / $kAraka_num{"karwA"} $from_wrd $from_mid;/)) {
           $karwqsamAnAXikaraNa = 0;
           #print "1 $in karwqsamAnAXikaraNa failed\n";
       }
       #if (($in =~ /^$from_wrd $from_mid $kAraka_num{"karwA"} $wrd_no $mid$/) || 
       #    ($in =~ /^$from_wrd $from_mid $kAraka_num{"karwA"} $wrd_no $mid;/) ||
       #    ($in =~ /;$from_wrd $from_mid $kAraka_num{"karwA"} $wrd_no $mid;/) ||
       #    ($in =~ /;$from_wrd $from_mid $kAraka_num{"karwA"} $wrd_no $mid$/)) {
       #    $karwqsamAnAXikaraNa = 0;
       #    #print "1 $in karwqsamAnAXikaraNa failed\n";
       #}
       if (($in =~ /^([^ ]+) ([^ ]+) $kAraka_num{"karwqsamAnAXikaraNam"} $from_wrd $from_mid/) && 
              ($wrd_no != $1) && ($mid != $2)) {
                 $karwqsamAnAXikaraNa = 0;
           #print "2 $in karwqsamAnAXikaraNa failed\n";
       } # Can not be two karwqsamAnAXikaraNas
       if (($in =~ /;([^ ]+) ([^ ]+) $kAraka_num{"karwqsamAnAXikaraNam"} $from_wrd $from_mid/) && 
              ($wrd_no != $1) && ($mid != $2)) {
                 $karwqsamAnAXikaraNa = 0;
           #print "3 $in karwqsamAnAXikaraNa failed\n";
       } # Can not be two karwqsamAnAXikaraNas
       if (($in =~ /^([^ ]+) [^ ]+ $kAraka_num{"karwA"} $from_wrd $from_mid;/) ||
           ($in =~ /^([^ ]+) [^ ]+ $kAraka_num{"karwA"} $from_wrd $from_mid$/) ||
           ($in =~ /;([^ ]+) [^ ]+ $kAraka_num{"karwA"} $from_wrd $from_mid;/) ||
           ($in =~ /;([^ ]+) [^ ]+ $kAraka_num{"karwA"} $from_wrd $from_mid$/))
           {
            $t = $1;
            if($t > $wrd_no) { # karwqsamAnAXikaraNa can not be after karwA
              $karmasamAnAXikaraNa = 0;
            }
       }
       #if (($in =~ / $kAraka_num{"karwqsamAnAXikaraNam"} ([^ ]+) ([^ ]+);/) && 
       #       ($wrd_no == $1) && ($mid == $2)) {
       #          $karwqsamAnAXikaraNa = 0;
       #    #print "4 $in karwqsamAnAXikaraNa failed\n";
       #} # Can not be karwqsamAnAXikaraNa of karwqsamAnAXikaraNa
       #if (($in =~ / $kAraka_num{"karwqsamAnAXikaraNam"} ([^ ]+) ([^ ]+)$/) && 
       #       ($wrd_no == $1) && ($mid == $2)) {
       #          $karwqsamAnAXikaraNa = 0;
       #    #print "5 $in karwqsamAnAXikaraNa failed\n";
       #} # Can not be karwqsamAnAXikaraNa of karwqsamAnAXikaraNa
    }
    #print "karwq = $karwqsamAnAXikaraNa\n";
  }
 }

#Earlier we were drawing karmasamanAXikaraNam from the verb
#Now we draw it from the karma. Hence the following is changed accordingly.
 if($in =~ / $kAraka_num{"karmasamAnAXikaraNam"} /) {
  for($j=0; $j<=$#rel && $karmasamAnAXikaraNa; $j++){
    $rel[$j] =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
    $wrd_no = $1; $mid = $2; $rel1 = $3; $from_wrd = $4; $from_mid = $5; 
    #Check karmasamAnAXikaraNam, karma compatibility
    if($rel1 == $kAraka_num{"karmasamAnAXikaraNam"}) {
       if (($in !~ / $kAraka_num{"karma"} $from_wrd $from_mid;/) && 
           ($in !~ / $kAraka_num{"karma"} $from_wrd $from_mid$/)) {
       #if (($in !~ /^$from_wrd $from_mid $kAraka_num{"karma"}/) && 
       #    ($in !~ /;$from_wrd $from_mid $kAraka_num{"karma"}/)) 
           $karmasamAnAXikaraNa = 0;
           #print "karmasamAnAXikaraNa failed\n";
       } 
       if (($in =~ /^([^ ]+) [^ ]+ $kAraka_num{"karma"} $from_wrd $from_mid;/) ||
           ($in =~ /^([^ ]+) [^ ]+ $kAraka_num{"karma"} $from_wrd $from_mid$/) ||
           ($in =~ /;([^ ]+) [^ ]+ $kAraka_num{"karma"} $from_wrd $from_mid;/) ||
           ($in =~ /;([^ ]+) [^ ]+ $kAraka_num{"karma"} $from_wrd $from_mid$/)) {
            $t = $1;
            if($t > $wrd_no) { # karmasamAnAXikaraNa can not be after karma
              $karmasamAnAXikaraNa = 0;
            }
       }
    }
    #print "karma = $karmasamAnAXikaraNa\n";
  }
 }


 if($in =~ / $kAraka_num{"prawiyogI"} /) {
  for($j=0; $j<=$#rel && $anuyogI; $j++){
    $rel[$j] =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
    $wrd_no = $1; $mid = $2; $rel1 = $3; $from_wrd = $4; $from_mid = $5; 
    #Check anuyogI
    if($rel1 == $kAraka_num{"prawiyogI"}) {
       if (($in !~ /;$from_wrd $from_mid $kAraka_num{"anuyogI"} /) && 
           ($in !~ /^$from_wrd $from_mid $kAraka_num{"anuyogI"} /) &&
           ($in !~ /;$from_wrd $from_mid $kAraka_num{"sambanXaH"} /) &&
           ($in !~ /^$from_wrd $from_mid $kAraka_num{"sambanXaH"} /) 
          ) {
           $anuyogI = 0;
           #print "anuyogi failed\n";
       }
    }
  }
 }

 if($in =~ / $kAraka_num{"anuyogI"} /) {
  for($j=0; $j<=$#rel && $prawiyogI; $j++){
    $rel[$j] =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
    $wrd_no = $1; $mid = $2; $rel1 = $3; $from_wrd = $4; $from_mid = $5; 
    #Check prawiyogI
    if($rel1 == $kAraka_num{"anuyogI"}) {
       if (($in !~ / $kAraka_num{"prawiyogI"} $wrd_no $mid;/) && 
           ($in !~ / $kAraka_num{"prawiyogI"} $wrd_no $mid$/) &&
           ($in !~ / $kAraka_num{"sambanXaH"} $wrd_no $mid;/) &&
           ($in !~ / $kAraka_num{"sambanXaH"} $wrd_no $mid$/) 
          ) {
           $prawiyogI = 0;
          # print "prawiyogi failed\n";
       }
    }
  }
 }
    #print "karwq = $karwqsamAnAXikaraNa\n";
    #Check samucciwam compatibility
# If there is a samucciwa relation, check that the count is > 1
#Also there should be kaaraka link onone side and samucciwam links on the other
    for($k=$kAraka_num{"samucciwam1"}; $k<=$kAraka_num{"samucciwakriyA"} && $found_samucciwam; $k++){
        if($in =~ / $k /) {
           $p = &get_rel_id($k);
           for($j=0; $j<=$#rel && $found_samucciwam; $j++){
               $rel[$j] =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
               $wrd_no = $1; $mid = $2; $rel1 = $3; $from_wrd = $4; $from_mid = $5; 
               #print "rel1 = $rel1\n";
               #print "k = $k\n";
               if($rel1 == $k) {
                  $count = ($in =~ s/ $k $from_wrd $from_mid/ $k $from_wrd $from_mid/g);
                  #print " count = $count\n";
                  #print " p = $p\n";
                  if(($k == $kAraka_num{"samucciwakriyA"}) && ($count < 2)){
                       #print "count = $count\n";
                       $found_samucciwam = 0;
                  }
                  if($k != $kAraka_num{"samucciwakriyA"}){
                    if(($in !~ /$from_wrd $from_mid $p /) || ($count < 2)) {
                       #print "k = $k kAraka_num = ",$kAraka_num{"samucciwamkriyA"},"\n";
                       #print "count = $count\n";
                       $found_samucciwam = 0;
                    }
                  }
                }
                #print "found samucciwam = $found_samucciwam\n";
            }
        }
    }
   
##samucciwa_wrd_pos is a global variable
#If there is any samucciwa word, then there should be samucciwa links on one side, and kaaraka relations on the other.
$samucciwa_wrd_pos =~ s/^;//;
 if($samucciwa_wrd_pos ne ""){
  $found_samucciwa_links = 1;
  @sam_wrds = split(/;/,$samucciwa_wrd_pos);
  #print "samucciwa_wrd_pos = $samucciwa_wrd_pos\n";
  #print "rel = $#rel\n";
  for($j=0; $j<=$#rel && $found_samucciwa_links; $j++){
    $rel[$j] =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
    $wrd_no = $1; $mid = $2; $rel1 = $3; $from_wrd = $4; $from_mid = $5; 
    #print "rel = $rel[$j]\n";
    #Check presence of samucciwa links with samucciwa words
       $wrd = $from_wrd.",".$from_mid;
       #print "wrd = $wrd\n";
       for($k=0;$k<=$#sam_wrds && !$found_samucciwa_links; $k++) {
        #print "sam_wrds = $sam_wrds[$k]\n";
          if($wrd eq $sam_wrds[$k]){ 
             if(($rel1 >= $kAraka_num{"samucciwam1"}) && ($rel1 <= $kAraka_num{"samucciwahewu"})) {
              $found_samucciwa_links = 1;
               #print "samucciwa_link found\n";
             } else { $found_samucciwa_links = 0;}
          }
       }
    }
  }
    #print "samucc_links = $found_samucciwa_links\n";

##Following module is only for viSeRaNas, and not for the RaRTIsambanXaHs.
##Because RaRTIsambanXaH may be due to kaaraka relation to a kqxanwa.
#If X is a viSeRana of Y then all the words in between X and Y are also viSeRaNas of Y. This condition is implemented here.
 if($in =~ / $kAraka_num{"viSeRaNam"} /){
 # print "in = $in\n";
  for($j=0; $j<=$#rel && $viSeRaNam; $j++){
   # print "j = $j\n";
    $rel[$j] =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
#    print "rel = $rel[$j]\n";
    $wrd_no = $1; $mid = $2; $rel1 = $3; $from_wrd = $4; $from_mid = $5; 
    if ($rel1 == $kAraka_num{"viSeRaNam"}) { #||
       #($rel1 == $kAraka_num{"sambanXaH"}) ||
       #($rel1 == $kAraka_num{"upapaxasambanXaH"}) ||
       #($rel1 == $kAraka_num{"RaRTIsambanXaH"}))
       $to = $wrd_no+1;
#      print "to = $to\n";
       $viSeRaNa_found = 1;
         while(($to < $from_wrd) && ($viSeRaNa_found)){
            #print "to = $to\n";
            $not_found = 1;
           for($k=0; $k<=$#rel && $not_found; $k++){
              $rel[$k] =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
              $wrd_no1 = $1; $mid1 = $2; $rel2 = $3; $from_wrd1 = $4; $from_mid1 = $5; 
              if(($wrd_no1 == $to) && 
                 ($from_wrd1 <= $from_wrd) && 
                 (($rel2 == $kAraka_num{"viSeRaNam"})  ||
                  ($rel2 == $kAraka_num{"sambanXaH"})  ||
                  ($rel2 == $kAraka_num{"upapaxasambanXaH"})  ||
                 ($rel2 == $kAraka_num{"RaRTIsambanXaH"}))
                 ) { $not_found = 0;} 
           }
#           print "not found = $not_found\n";
           if(!$not_found) {$to++; $not_found = 1;}
           else { $viSeRaNa_found = 0;}
         }
       if($viSeRaNa_found == 1) {$viSeRaNam = 1;} else { $viSeRaNam = 0;}
    }
  }
#  print "viSeRaNam = $viSeRaNam\n";
 }
#print "ks = $karwqsamAnAXikaraNa\n";
#print "kms = $karmasamAnAXikaraNa\n";
#print "sam = $found_samucciwam\n";
#print "sam1 = $found_samucciwa_links\n";
#print "anu = $anuyogI\n";
#print "prawi = $prawiyogI\n";
#print "vi = $viSeRaNam\n";
     $necessary_condition = $karwqsamAnAXikaraNa * $karmasamAnAXikaraNa * $found_samucciwam * $found_samucciwa_links * $anuyogI * $prawiyogI * $viSeRaNam;
# * $niwya_sambanXaH; 
#print "nece cond = $necessary_condition\n";
$necessary_condition;
}
1;

sub get_rel_id{
my($in) = @_;
 if($in == $kAraka_num{"samucciwam1"}) { return $kAraka_num{"karwA"};}
 if($in == $kAraka_num{"samucciwam2"}) { return $kAraka_num{"karma"};}
 if($in == $kAraka_num{"samucciwam3"}) { return $kAraka_num{"karaNam"};}
 if($in == $kAraka_num{"samucciwam4"}) { return $kAraka_num{"sampraxAnam"};}
 if($in == $kAraka_num{"samucciwam5"}) { return $kAraka_num{"apAxAnam"};}
 if($in == $kAraka_num{"samucciwam6"}) { return $kAraka_num{"RaRTIsambanXaH"};}
 if($in == $kAraka_num{"samucciwam7"}) { return $kAraka_num{"aXikaraNam"};}
 if($in == $kAraka_num{"samucciwaviSeRaNam"}) { return $kAraka_num{"viSeRaNam"};}
 if($in == $kAraka_num{"samucciwaprayojanam"}) { return $kAraka_num{"prayojanam"};}
 if($in == $kAraka_num{"samucciwahewu"}) { return $kAraka_num{"hewuH"};}
 return $in;
}
1;

sub get_cost{
my($in) = @_;
my(@rels,$rel,$cost,$wrd_no,$mid,$rel1,$from_mid,$from_wrd);

$cost = 0;
@rels = split(/;/,$in);
 foreach $rel (@rels) {

   $rel =~ /^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/;
   $wrd_no = $1; $mid = $2; $rel1 = $3; $from_wrd = $4; $from_mid = $5; 
 #  if(($rel1 != $kAraka_num{"viSeRaNam"}) && ($rel1 != $kAraka_num{"RaRTIsambanXaH"})) {
    if (  ($rel1 != $kAraka_num{"niwya_sambanXaH"}) 
       && ($rel1 != $kAraka_num{"sambanXaH"})) { #For niwya sambanXah cost = 0;
      if ($from_wrd > $wrd_no) { $cost += $rel1 * ($from_wrd-$wrd_no);}
      elsif ($rel1 == $kAraka_num{"karwqsamAnAXikaraNam"}) { $cost += $rel1 * ($wrd_no-$from_wrd);}
      else { $cost += $rel1 * ($wrd_no - $from_wrd) * 10;}
    }
 #  }
# If we do not put this condition, then
#AcArya wava XImawA SiRyeNa xrupaxa-puwreNa vyUDAm pANdu-puwrANAm ewAm mahawIm camUm paSya
#In this sentence, SiRyeNa is marked as karwA and xrupaxa-puwreNa as hetu/karaNa of vyUDAm
#And if we use this condition, then examples with karwA, karwqsamanadhikarana 
#fail and the preferred analysis is viSeRaNa , karwA
 }
   return $cost;
}
1;

sub build_paths_graph{

my($id, $wrd_end_id_no, @flds, $w_no, $indx, $wrd_start_id_no,@ana,$i,$ana_indx, @left,@right,%ADJACENT);


$id = 0;
$wrd_end_id_no = -1;

while(($in = <IN>) && ($in ne "\n")){

      @flds = split(/\t/,$in);
      if($flds[0] =~ /^[0-9]+[\.।]([0-9]+)/) { # ignore sentence number
           $w_no = $1;
           if($no_of_words < $w_no) { $no_of_words = $w_no;}
           if($flds[1] =~ /<p>/) {$id = 0;}
           $indx = $w_no;
           $wrd_start_id_no = $wrd_end_id_no+1;
           $wrd_end_id_no = $id;
           $wrd{$indx} = $flds[3];
           @ana = split(/\//,$flds[7]);
           for ($i=0;$i <= $#ana; $i++) {
               $id++;
               $ana_indx = $i+1;
               $key = $w_no." ".$ana_indx;
               $row[$id] = $wrd{$indx}."\t".$indx.",".$ana_indx."\t".$ana[$i]."\t".$id;
               for($j=$wrd_start_id_no; $j<= $wrd_end_id_no; $j++) {
                  if($flds[1] =~ /<[psa]>/) { $left[$id] = "S";} 
                  else { $left[$id] .= ",".$j;}
                  if($flds[4] =~ /<\/[psa]>/) { $right[$id] = "F";} 
                  if ($right[$j] ne "F") {$right[$j] .= ",".$id;}
               }
            }
          }
}

for ($i=0;$i<= $id; $i++) {
 $left[$i] =~ s/^,//;
 $right[$i] =~ s/^,//;
 $row[$i] .= "\t".$left[$i]."\t".$right[$i];

 $row[$i] =~ /^[^\t]+\t([0-9]+),([0-9]+)\t.*/;
 $key = $1." ".$2; # word_no, ana_no
 $ADJACENT{$key} = $row[$i];
}

$no_of_nodes = $id;
%ADJACENT;
}
1;

sub expand {
my($viSeRaNa_list) = @_;

my(@vlist,$vi_parses,$i);

@vlist = split(/;/,$viSeRaNa_list); # different words
#This list is of the form: a;b1#b2#b3;c1#c2;
#where b1#b2#b3 correspond to same word with diff mo ana

#First we expand it by distributing as
#a;b1;c1#a;b1;c2#a;b2;c1#a;b2;c2 etc.

$vi_parses = $vlist[0];
for($i=1;$i<=$#vlist;$i++) {
    $vi_parses = &distribute($vi_parses,$vlist[$i]);
}
$vi_parses =~ s/^#//;
$vi_parses;
}
1;

sub chk_compatibility_and_distribute{
my($str1,$str2) = @_;
my($ans) = "";

#print "str1 = $str1\n";
#print "str2 = $str2\n";

 @str1 = split(/#/,$str1);
 @str2 = split(/#/,$str2);

 foreach $str1 (@str1) {
  if(($ans !~ /^$str1$/) &&
     ($ans !~ /#$str1$/) &&
     ($ans !~ /#$str1#/) &&
     ($ans !~ /^$str1#/)) {
     $ans .= "#".$str1;
   }
 }
 foreach $str2 (@str2) {
  if(($ans !~ /^$str2$/) &&
     ($ans !~ /#$str2$/) &&
     ($ans !~ /#$str2#/) &&
     ($ans !~ /^$str2#/)) {
     $ans .= "#".$str2;
   }
 }
#print "ans = $ans\n";
#$ans = $str1."#".$str2;
 foreach $str1 (@str1) {
   foreach $str2 (@str2) {
#     print "calling compatible\n";
     if(&compatible($str1,$str2)) {
         $str = $str1.";".$str2;
#     print "$str found compatible\n";
         $ans .= "#". $str;
     } 
   }
 }
$ans =~ s/^#//;
$ans;
}
1;

sub distribute{
my($str1,$str2) = @_;
my($ans) = "";

 @str1 = split(/#/,$str1);
 @str2 = split(/#/,$str2);

 foreach $str1 (@str1) {
   foreach $str2 (@str2) {
     $ans .= "#". $str1.";".$str2;
   }
 }
$ans =~ s/^#//;
$ans;
}
1;

sub chk_necessary{
my($in)= @_;
  #print "within chk necessary $in\n";
  if (&necessary_conditions($in)) {
   $cost = &get_cost($in);
#   print "no_of_words = $no_of_words\n";  
#   print "in = $in\n";  
   if(&complete_parse($in, $no_of_words)) {
#   print "complete parse\n";
   $final_parse[$parse_count] = $in;
   $final_parse[$parse_count] = $cost.";".$final_parse[$parse_count];
   $parse_count++; 
  } elsif ($parse_count == 0){ #collect the partial solutions till a complete parse  is found
  $exists_partial_solution = 0;
  for($z=0;$z < $partial_parse_count; $z++) {
    if($final_partial_parse[$z] =~ /;$in/) { 
       $exists_partial_solution = 1;
    }
  }
  if(!$exists_partial_solution) {
     my $nrel = split(/;/,$in);
     $cost = (100-$nrel)*100000+$cost;
     $final_partial_parse[$partial_parse_count] = $cost.";".$in;
     $partial_parse_count++;
  }
  #print "partial parse count = $partial_parse_count\n";
 }
 } else { 
#  print "necessary conditions failed\n";
 }
 
}
1;

sub modify_right_node_of_left_ids{

 my($left_ids, $i, $right_ids,$mode,@ROW) = @_;
 my($l,$r,$exists,@cflds);

   @right_ids = split(/,/,$right_ids);
   @left_ids = split(/,/,$left_ids);

             #print "within right_left \n";
#print "row = @ROW\n";
      foreach $l (@left_ids) {
       if($l ne "S") {
        @cflds = split(/\t/,$ROW[$l]);
        $exists = 1;
        foreach $r (@right_ids) {
         if((($cflds[5] !~ /^$r,/) && ($cflds[5] !~ /,$r,/) && ($cflds[5] !~ /,$r$/) && ($cflds[5] !~ /^$r$/)) || ($l eq "S")){
            if($cflds[5] =~ /^$i,/) { $cflds[5] =~ s/^$i,/$r,$i,/;}
            elsif($cflds[5] =~ /,$i,/) { $cflds[5] =~ s/,$i,/,$r,$i,/;}
            elsif($cflds[5] =~ /,$i$/) { $cflds[5] =~ s/,$i/,$r,$i/;}
            elsif($cflds[5] =~ /^$i$/) { $cflds[5] =~ s/$i/$r,$i/;}
            $exists = 0;
          }
         }
            if($mode eq "replace") {
              if($exists) { 
                 $cflds[5] =~ s/^$i,//;
                 $cflds[5] =~ s/,$i,/,/;
                 $cflds[5] =~ s/,$i$//;
                 $cflds[5] =~ s/^$i$//;
              } else { $cflds[5] =~ s/,$i//;}
            }
            $ROW[$l] = join('	',@cflds);
            $flds[4] =~ s/^$l,?//;
            $ROW[$i] = join('	',@flds);
       }
      }
join('=',@ROW);
#print "a = @a\n";
}
1;

sub modify_left_node_of_right_ids{

 my($left_ids, $i, $right_ids,$mode,@ROW) = @_;
 my($l,$r,$exists,@cflds);

   @right_ids = split(/,/,$right_ids);
   @left_ids = split(/,/,$left_ids);

             #print "within left_right \n";
      #print "row = @ROW\n";
      foreach $r (@right_ids) {
      if($r ne "F") {
        @cflds = split(/\t/,$ROW[$r]);
        $exists = 1;
        foreach $l (@left_ids) {
         if(($cflds[4] !~ /^$l,/) && ($cflds[4] !~ /,$l,/) && ($cflds[4] !~ /,$l$/) && ($cflds[4] !~ /^$l$/)){
           if($cflds[4] =~ /^$i,/) { $cflds[4] =~ s/^$i,/$l,$i,/;}
           elsif($cflds[4] =~ /,$i,/) { $cflds[4] =~ s/,$i,/,$l,$i,/;}
           elsif($cflds[4] =~ /,$i$/) { $cflds[4] =~ s/,$i/,$l,$i/;}
           elsif($cflds[4] =~ /^$i$/) { $cflds[4] =~ s/$i/$l,$i/;}
           $exists = 0;
         } 
        }
           if($mode eq "replace") {
             if($exists) {
               $cflds[4] =~ s/^$i,//;
               $cflds[4] =~ s/,$i,/,/;
               $cflds[4] =~ s/,$i$//;
               $cflds[4] =~ s/^$i$//;
             } else {$cflds[4] =~ s/,$i//;}
           }
           $ROW[$r] = join('	',@cflds);
           $flds[5] =~ s/^$r,?//;
           $ROW[$i] = join('	',@flds);
      }
     }
join('=',@ROW);
#print "a1 = @a\n";
}
1;
