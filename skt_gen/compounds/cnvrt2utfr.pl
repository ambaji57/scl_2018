 my $mycPATH = "SCLINSTALLDIR/converters";

 sub cnvrt2utfr {
  my($in) = @_;
  chomp($in);

  $in = $in." "; #Idiosynchrosy of ir_skt; does not work well if con is at the end. Hence added an extra space

  $out = `echo $in | $mycPATH/utfd2r.sh`;

$out;
}
1; 
