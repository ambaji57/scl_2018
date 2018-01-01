#!PERLPATH

$/ = "\n\n";

while($in = <STDIN>){
  $in =~ /sUwra_Num:([0-9\.]+)/;
  $sn = $1;
  if($in !~ /\+/) { 
     print "***";
  }
  print $in;
}
