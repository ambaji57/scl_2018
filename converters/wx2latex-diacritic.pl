#!PERLPATH

$/ = " ";

while ($in = <STDIN>){
if($in !~ /^[^a-zA-Z]*@/) {
   $in =~ s/K/kh/g;
   $in =~ s/G/gh/g;
   $in =~ s/f/\\\.\{n\}/g;
   $in =~ s/C/ch/g;
   $in =~ s/J/jh/g;
   $in =~ s/d/\\d\{d\}/g;
   $in =~ s/F/\\\~\{n\}/g;
   $in =~ s/t/\\d\{t\}/g;
   $in =~ s/T/\\d\{t\}h/g;
   $in =~ s/D/\\d\{d\}h/g;
   $in =~ s/N/\\d\{n\}/g;
   $in =~ s/w/t/g;
   $in =~ s/W/th/g;
   $in =~ s/x/d/g;
   $in =~ s/X/dh/g;
   $in =~ s/P/ph/g;
   $in =~ s/B/bh/g;
   $in =~ s/S/\\\'\{s\}/g;
   $in =~ s/R/\\d\{s\}/g;
   $in =~ s/A/\\\=\{a\}/g;
   $in =~ s/I/\\\=\{\\i\}/g;
   $in =~ s/E/ai/g;
   $in =~ s/U/\\\=\{u\}/g;
   $in =~ s/q/\\d\{r\}/g;
   $in =~ s/L/\\d\{l\}/g;
   $in =~ s/Q/\\d\{\\\=\{r\}\}/g;
   $in =~ s/O/au/g;
   $in =~ s/M/\\d\{m\}/g;
   $in =~ s/z/\\\.\{m\}/g;
   $in =~ s/H/\\d\{h\}/g;
}
print $in;
}
