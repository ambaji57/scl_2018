#!PERLPATH -I LIB_PERL_PATH/

my $myPATH = "SCLINSTALLDIR";
package main;
use CGI qw/:standard/;
#use CGI::Carp qw(fatalsToBrowser);
      if (param) {
      $encoding=param("encoding");
      $pra=param("praatipadika");
      $vib=param("vibhakti");
      $lifga=param("linga");
      $vac=param("vacana");

      $pid = $$;
      
      $pra=~ s/\r//g;

      chomp($pra);
      chomp($vib);
      chomp($vac);

      system("$myPATH/ashtadhyayi_simulator/callrun.pl $encoding $pra $vib $lifga $vac $pid");
      }
