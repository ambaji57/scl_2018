#!PERLPATH -w
package main;
use CGI qw/:standard/;
use CGI::Carp qw(fatalsToBrowser);
#  Copyright (C) 2002-2012 Amba Kulkarni (ambapradeep@gmail.com)
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later
#  version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

#print CGI::header('-charset' => 'UTF-8');

      if (param) {
	$wrd=param('word');
	my $cgi = new CGI;
        print $cgi->header (-charset => 'UTF-8');
	
       &print_entry($wrd);
      }

sub print_entry{
my($wrd) = @_;
my $char=' ';# this is added by me
my $v=index($wrd,$char);
if($v ==2) {
$file_name1=substr($wrd,2,2);
$file_name1=~s/ //g;
$file_name1=$file_name1.".xml";
chomp($file_name1);
$file_name=$file_name1;
}
else {
$wrd =~ /^(.)/;
$f= $1; # this is added by me
$file_name = $f.".xml";
}
open(PARA,">TFPATH/OUT1");
open(TMP,"<SCLINSTALLDIR/dictionaries/Apte-Skt-Hnd/xmlfiles/$file_name") || die "Can't open $file_name";

$/ = "<dentry>";
$wrd1= $wrd; # this is added by me
#print $wrd1;
while($in = <TMP>) {
 if($in =~ /^$wrd1</) {
#    print PARA "$in";
 &format($in);
 }
} 
}

sub format {

$in="<table class=resulttable align=center style=\"border:thick solid gray;width:60%; border-collapse:collapse;cellpadding:4px;cellspacing:4px; color:green;font-size:20px;font-width:bold;\"><tr style=\"border:thin dotted gray;\"><td style=\"border:thin dotted gray;\">dentry</td><td style=\"border:thin dotted gray;\">"."$in";
$in=~s/<\/dentry>/<\/td><\/tr><tr style=\"border:thin dotted gray;\"><td style=\"border:thin dotted gray;\">dentryws<\/td><td style=\"border:thin dotted gray;\">/g;
$in=~s/<\/dentryws>/<\/td><\/tr><tr style=\"border:thin dotted gray;\"><td style=\"border:thin dotted gray;\">Gram<\/td><td style=\"border:thin dotted gray;\">/g;
$in=~s/<\/Gram>/<\/td><\/tr><tr style=\"border:thin dotted gray;\"><td style=\"border:thin dotted gray;\">Hmean<\/td><td style=\"border:thin dotted gray;\">/g;
$in=~s/<\/hmean>/<\/td><\/tr><tr style=\"border:thin dotted gray;\"><td style=\"border:thin dotted gray;\">hgram<\/td><td style=\"border:thin dotted gray;\">/g;
$in=~s/<\/hgram>/<\/td><\/tr><tr style=\"border:thin dotted gray;\"><td style=\"border:thin dotted gray;\">ref<\/td><td style=\"border:thin dotted gray;\">/g;
$in=~s/<\/ref>/<\/td><\/tr><tr style=\"border:thin dotted gray;\"><td style=\"border:thin dotted gray;\">extra<\/td><td style=\"border:thin dotted gray;\">/g;
$in=~s/<\/sanskrit>/<\/td><\/tr>/g;
$in=~s/<\/sence>//g;
$in=~s/<\/def><sence><sanskrit>/<\/td><\/tr><tr style=\"border:thin dotted gray;\"><td style=\"border:thin dotted gray;\">Sanskrit<\/td><td style=\"border:thin dotted gray;\">/g;
$in=~s/<extra>//g;
$in=~s/<ref>//g;
$in=~s/<Gram>//g;
$in=~s/<hmean>//g;
$in=~s/<dentryws>//g;
$in=~s/<def>//g;
$in=$in."</table>";
$in=~s/<\/entry>//g;
$in=~s/<form>//g;
$in=~s/<entry n=\"(.*)\">//g;
$in=~s/\n//g;
print "$in";
print PARA "$in\n";
}









