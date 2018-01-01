#!PERLPATH

$relations = "(niRTa|nirUpiwa|avacCinna|vqwwi|nirUpaka|avacCexaka|ASraya|SAl[iI]|vaw|vawI|vawyaH|vAn|ka)";
$relationalabstracts = "(aXikaraNawA|AXArawA|AXeyawA|prawiyogiwA|anuyogiwA|hewuwA|kAraNawA|karaNawA|kAryawA|viSeRyawA|viSeRaNawA|prakArawA|saMsargawA|saMsargiwA|viRayawA|viRayiwA|avacCexakawA|avacCexyawA|avacCinnawA|lakRyawA|lakRaNawA|nirUpyawA|nirUpakawA|svawA|svAmiwA|vyApyawA|vyApakawA|sAXyawA|sAXakawA|prawibaXyawA|prawibanXakawA|ASrayawA|ASrayiwA|vqwwiwA|sawwA|janyawA|janakawA|aXikaraNawva|AXArawva|AXeyawva|prawiyogiwva|anuyogiwva|hewuwva|kAraNawva|karaNawva|kAryawva|viSeRyawva|viSeRaNawva|prakArawva|saMsargawva|saMsargiwva|viRayawva|viRayiwva|avacCexakawva|avacCexyawva|avacCinnawva|lakRyawva|lakRaNawva|nirUpyawva|nirUpakawva|svawva|svAmiwva|vyApyawva|vyApakawva|sAXyawva|sAXakawva|prawibaXyawva|prawibanXakawva|ASrayawva|ASrayiwva|vqwwiwva|sawwva|janyawva|janakawva)";

$in = <STDIN>;
chomp ($in);
if ($in =~ /$relations\-$relations/) { $in =~ s/($relations)\-($relations)/$1-vaswu-$3/;}
$in = "-".$in; #Add '-' in the beginning to have a null word at 0
# This is to avoid the jugglary with index starting with 0, while the interface needs the index start with 1

@words = split(/-/,$in);

#Algorithm:

 # For each word i do
for($i=1;$i<=$#words;$i++){
 # A) Decide the type of the ith word
 # If it is from the given list of relations, mark it as relation else concept
  if($words[$i] =~ /^$relations$/) { 
     $type[$i] = "@"."relation";
  } else { $type[$i] = "@"."concept";}

 # B) If the type is relation, mark pratiyogi as the previous word
  if($type[$i] eq "\@relation") { 
     $pratiyogi[$i] = $i-1;
  } else {$pratiyogi[$i] = "-";}

 # C) If the type is concept, 
  if($type[$i] eq "\@concept") {
    for($j=$i-1;$j>=0; $j--) {
      if($type[$j] eq "\@relation") {
         if($words[$j] eq "nirUpiwa") {
             if(($words[$pratiyogi[$j]] !~ /^$relationalabstracts$/) 
                 || &compatible($words[$pratiyogi[$j]],$words[$i])) {
                 $anuyogi[$j] .= ",".$i;
                 $anuyogi_of[$i] .= ",".$j;
             }
         }
         else {
           $anuyogi[$j] .= ",".$i;
           $anuyogi_of[$i] .= ",".$j;
           }
      }
    }
 #    if two consecutive concepts, then 
 #    all previous consecutive concepts are possible anuyogis
    if($type[$i-1] eq "\@concept") { 
       $continue = 1;
       for($j=$i-1;$j>=0 & $continue; $j--) {
           if($type[$j] eq "\@relation") { $continue = 0;}
           if ($anuyogi[$j] !~ /,$i/) { 
               $anuyogi[$j] .= ",".$i; 
               $anuyogi_of[$i] .= ",".$j;
           }
       }
 #    and it is the pratiyogi of itself
       $pratiyogi[$i-1] = $i-1;
    }
  }
}

# If any relational abstract can be an anuyogi of a single relation, then assign this anuyogi to that relation, removing all other possible anuyogis of that relation.
# For example in the example ganXa-niRTa-AXeyawA-nirUpiwa-aXikaraNawA
# niRTa can have AXeyawA and aXikaraNawA as anuyogis.
# But AXeyawA can be anuyogi for only niRTa, and hence assign this, removing aXikaraNawA from niRTa
for($i=1;$i<=$#words;$i++){
    $anuyogi_of[$i] =~ s/^,//;
    if($anuyogi_of[$i] =~ /^([0-9]+)/) {
       $anu = $1;
        #print "words = ",$words[$i],"\n";
       if ($words[$i] =~ /^$relationalabstracts$/) {
           $anuyogi[$anu] = $i;
       }
    }
}
for($i=1;$i<=$#words;$i++){
    $anuyogi[$i] =~ s/^,//;
    if($anuyogi[$i] eq "")  { $anuyogi[$i] = "-";}
    print $type[$i],"\t",$words[$i],"\t",$i,"\t",$pratiyogi[$i],"\t",$anuyogi[$i],"\n";
}


sub compatible {
 my ($a, $b) = @_;
 if (($a eq "AXeyawA") && (($b eq "aXikaraNawA") || ($b eq "AXArawA"))) { return 1;} 
 elsif ((($a eq "aXikaraNawA") || ($a eq "AXArawA")) && ($b eq "AXeyawA")) { return 1;}
 elsif (($a eq "prawiyogiwA") && ($b eq "anuyogiwA")) { return 1;}
 elsif (($a eq "anuyogiwA") && ($b eq "prawiyogiwA")) { return 1;}
 elsif (($a eq "viRayawA") && ($b eq "viRayiwA")) { return 1;}
 elsif (($a eq "viRayiwA") && ($b eq "viRayawA")) { return 1;}
 elsif (($a eq "nirUpyawA") && ($b eq "nirUpakawA")) { return 1;}
 elsif (($a eq "nirUpakawA") && ($b eq "nirUpyawA")) { return 1;}
 elsif (($a eq "vyApyawA") && ($b eq "vyApakawA")) { return 1;}
 elsif (($a eq "vyApakawA") && ($b eq "vyApyawA")) { return 1;}
 elsif (($a eq "viSeRyawA") && ($b eq "viSeRaNawA")) { return 1;}
 elsif (($a eq "viSeRaNawA") && ($b eq "viSeRyawA")) { return 1;}
 elsif (($a eq "avacCexyawA") && ($b eq "avacCexakawA")) { return 1;}
 elsif (($a eq "avacCexakawA") && ($b eq "avacCexyawA")) { return 1;}
 elsif (($a eq "kAryawA") && (($b eq "karaNawA") || ($b eq "kAraNawA"))) { return 1;}
 elsif ((($a eq "kAraNawA") || ($a eq "karaNawA")) && ($b eq "kAryawA")) { return 1;}
 elsif (($a eq "kAryawA") && (($b eq "karaNawva") || ($b eq "kAraNawva"))) { return 1;}
 elsif ((($a eq "kAraNawA") || ($a eq "karaNawva")) && ($b eq "kAryawva")) { return 1;}
 elsif (($a eq "XarmawA") && ($b eq "XarmiwA")) { return 1;}
 elsif (($a eq "XarmiwA") && ($b eq "XarmawA")) { return 1;}
 elsif (($a eq "prawibaXyawA") && ($b eq "prawibanXakawA")) { return 1;}
 elsif (($a eq "prawibanXakawA") && ($b eq "prawibaXyawA")) { return 1;}
 elsif (($a eq "lakRyawA") && ($b eq "lakRaNawA")) { return 1;}
 elsif (($a eq "lakRaNawA") && ($b eq "lakRyawA")) { return 1;}
 elsif (($a eq "saMsargawA") && ($b eq "saMsargiwA")) { return 1;}
 elsif (($a eq "saMsargiwA") && ($b eq "saMsargawA")) { return 1;}
 elsif (($a eq "viSeRyawA") && (($b eq "viSeRyiwA") || ($b eq "prakArawA"))) { return 1;}
 elsif (($a eq "viSeRyiwA") && ($b eq "viSeRyawA")) { return 1;}
 elsif (($a eq "prakArawA") && (($b eq "prakAriwA") || ($b eq "viSeRyawA"))) { return 1;}
 elsif (($a eq "prakAriwA") && ($b eq "prakArawA")) { return 1;}
 elsif (($a eq "ASrayawA") && ($b eq "ASrayiwA")) { return 1;}
 elsif (($a eq "ASrayiwA") && ($b eq "ASrayawA")) { return 1;}
 elsif (($a eq "janyawA") && ($b eq "janakawA")) { return 1;}
 elsif (($a eq "janakawA") && ($b eq "janyawA")) { return 1;}
 elsif (($a eq "puwrawva") && ($b eq "piwqwva")) { return 1;}
 elsif (($a eq "piwqwva") && ($b eq "puwrawva")) { return 1;}
 elsif (($a eq "prayojyawA") && ($b eq "prayojakawA")) { return 1;}
 elsif (($a eq "prayojakawA") && ($b eq "prayojyawA")) { return 1;}
 elsif (($a eq "sAXyawA") && ($b eq "sAXakawA")) { return 1;}
 elsif (($a eq "sAXakawA") && ($b eq "sAXyawA")) { return 1;}
 elsif (($a eq "boXyawA") && ($b eq "boXakawA")) { return 1;}
 elsif (($a eq "boXakawA") && ($b eq "boXyawA")) { return 1;}
 elsif (($a eq "sambanXawA") && ($b eq "sambanXiwA")) { return 1;}
 elsif (($a eq "sambanXiwA") && ($b eq "sambanXawA")) { return 1;}
 elsif (($a eq "avayavawA") && ($b eq "avayaviwA")) { return 1;}
 elsif (($a eq "avayaviwA") && ($b eq "avayavawA")) { return 1;}
else {return 0;}
}
