#!PERLPATH -w

while($in = <STDIN>){
  if ($in =~ /\)$/) {
      $in =~ s/.*Input = //;
      $ex = $in;
  }
  if ($in =~ /([0-9]+\.[0-9]+\.[0-9]+)/) {
      $sutra = $1;
      print $sutra," ",$ex;
  }
}
      
   
