#!PERLPATH

while($in = <STDIN>){

chomp($in);
($freq,$word) = split(/ /,$in);
if($FREQ{$word}){ $FREQ{$word} += $freq;}
else {$FREQ{$word} = $freq;}
}

foreach $key (keys %FREQ){
 print $FREQ{$key}," ",$key,"\n";
}
