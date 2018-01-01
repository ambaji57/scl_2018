#!PERLPATH

use warnings;
use CGI ':standard';

my $cgi = new CGI;

$cgi->charset('utf-8');

print $cgi->header(-type    => 'text/html',
                   -charset => 'utf-8');

print "<style>
.head_div{background:none repeat scroll 0px 0px #5678AA; color:#fff;}
h3{margin-top:1px !important; font-size:30px;}
.head_div p{font-size:16px !important; }
.text div{padding:5px;}
input[type=\"submit\"]{margin-top:5px; width:87px;}
select{margin-top:10px; width:200px !important; padding:3px !important;}
.listdiv{margin-top:5px;border:1px solid;}
</style>
</head>
<body>
<center>
<div class=\"container-full\">

<header class=\"head_div col-md-12 text-center\">

	<h3>समस्तपदव्युत्पादिका</h3>   
	<h3>A Compound stem generator</h3>
	<h4>Department of Sanskrit Studies, University of Hyderabad.</h4>
<h3><a href=\"SCLURL/index.html\">Samsaadhanii</a></h3>
</center>
<br /> <br />";
if (param) {
  $avigraha = param("vigraha");
  $nextstate = param("nextstate");
  print "choice = $ch<br />";
  
  my $a = `echo "$avigraha" | SCLINSTALLDIR/converters/wx2utf8.sh`;

      print "<br />";
      #print "<div id=\"output2\">";
      print "<center><pre>\n";
      my $cmd = "SCLINSTALLDIR/skt_gen/new_compounds/sanskrit_grammar.out \"$avigraha\" 1 | SCLINSTALLDIR/converters/wx2utf8.sh";
      system($cmd);
      print "</pre></center>\n";

}
