#!PERLPATH 

# examples1.txt: Contains examples
# OLD: perl run_all.pl < examples1.txt > OUT
# ./run_all.sh > OUT
# perl extract_ex.pl < OUT| sort > tested_examples.txt

# Compounds.txt: Contains sUwra num followed by sUwra str, followed by examples
# This programme reads one entry of compounds.txt, checks if any examps are available in test_examples.txt.
# If yes, add those examples below the entry in Compounds.txt, provided it is not already listed.

#First read the entries in tested_examples.txt into a hash array.

#Usage: perl add_sUwra_examples.pl tested_examples.pl Compound.txt [IA]
#I: Incremental
#A: All (Here al the earlier example from Compound.txt are ignored
#print "Arguments: 0:$ARGV[0] 1:$ARGV[1] 2:$ARGV[2]\n";

if($ARGV[2] eq 'I') { $mode = "incremental";}
elsif($ARGV[2] eq 'A') { $mode = "All";}
else { 
    printf "Wrong argument $ARGV[2]\nUsage: perl add_sUwra_examples.pl tested_examples.pl Compound.txt [IA]\n";
    exit(1);
}
open(TMP,"<$ARGV[0]") || die "Can't open $ARGV[0] for reading";

@in = <TMP>;
close(TMP);

foreach $in (@in) {
chomp($in);
($key,$value) = split(/ /,$in,2);
if($EX{$key} eq "") {$EX{$key} = $value;} else { $EX{$key} .= "#".$value;}
}

#print "tested examples.txt\n";
#foreach $key (keys %EX) {
# print $key," ",$EX{$key},"\n";
#}

$/ = "\n\n";
#Now read the entries from Compound.txt
open(TMP,"<$ARGV[1]") || die "Can't open $ARGV[1] for reading";
 while($in = <TMP>){
   chomp($in);
   ($num,$str,$examples) = split(/\n/,$in,3);
   #print "num = $num str = $str ex = @examples\n"; 
   $num =~ s/sUwra_Num://;
   $str =~ s/sUwra_Str://;
   $examples =~ s/Examples:\n?//;

   print "sUwra_Num:",$num,"\n";
   print "sUwra_Str:",$str,"\n";
   print "Examples:\n";
 
   @examples = split(/\n/,$examples);
if($mode eq "incremental"){
# Copy examples fom Compound.txt removing duplicate examples, if any
   if($examples[0] =~ /[a-zA-Z]/) {
      print $examples[0],"\n";
      for($i=1; $i<=$#examples; $i++) {
         $one = $examples[$i];
         $found = 0;
         for($j=0; $j<$i; $j++) {
            $two = $examples[$j];
            if($one eq $two) { $found = 1;}
         }
         if(!$found) {print $one,"\n";}
       }
   }
}
# Now add new examples
   $new_ex = $EX{$num};
   @new_ex = split(/#/,$new_ex);
   
   foreach $ex (@new_ex) {
     $found = 0;
     $ex_bak = $ex;
if($mode eq "incremental"){
     foreach $example (@examples) {
       $example =~ s/\(/LP/g;
       $example =~ s/\)/RP/g;
       $example =~ s/\+/PLUS/g;
       $ex =~ s/\(/LP/g;
       $ex =~ s/\)/RP/g;
       $ex =~ s/\+/PLUS/g;
       if($example eq $ex) {
          $found = 1;
       }
     }
}
     if(!$found) {
        print $ex_bak,"\n";
     }
   }

   print "\n";
 }
close(TMP);

