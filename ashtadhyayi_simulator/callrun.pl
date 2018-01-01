#!PERLPATH -I LIB_PERL_PATH/

use CGI qw/:standard/;

my $myPATH="SCLINSTALLDIR";
require "$myPATH/converters/convert.pl";

$praatipadika = &convert($ARGV[0],$ARGV[1]);
$vibhakti = $ARGV[2];
$lifga = $ARGV[3];
$vacana = $ARGV[4];

chomp($praatipadika);
chomp($vibhakti);
chomp($lifga);
chomp($vacana);
      
      my $cgi = new CGI;
      print $cgi->header ( -charset => 'UTF-8');
      system("cd $myPATH/ashtadhyayi_simulator/june12; ./run.sh $praatipadika $vibhakti $lifga $vacana");
	
print "</BODY></HTML>";
