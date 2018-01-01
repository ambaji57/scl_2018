 my $mycPATH = "SCLINSTALLDIR/converters";

 sub cnvrt2utf {
  my($in) = @_;
  chomp($in);

  $in = $in." "; #Idiosynchrosy of ir_skt; does not work well if con is at the end. Hence added an extra space

  $out = `echo $in | $mycPATH/wx2utf8.sh`;

$out;
}
1;
