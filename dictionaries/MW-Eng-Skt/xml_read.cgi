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


      if (param) {
	$wrd=param('word');
	my $cgi = new CGI;
        print $cgi->header (-charset => 'UTF-8');
        &print_entry($wrd);
      }

sub print_entry{
my($wrd) = @_;
$wrd =~ /^(.)/;
$f= lc($1); #Since all the filenames are in small case
$file_name = $f.".xml";

open(TMP,"< HTDOCSDIR/dictionaries/MW-Eng-Skt/xmlfiles/$file_name") || die "Can't open $file_name";

$/ = "<form>";
while($in = <TMP>) {
  if(($in =~ / $wrd</i) || ($in =~ /^$wrd</i)) {
     &format($in);
  }
}
}

sub format {
$in="<table border=1 class=resulttable align=center style=\"width:60%;\"><tr><td>Word</td><td>"."$in";
$in=~s/<\/form>/<\/td><\/tr><tr><td>Category<\/td><td>/g;
$in=~s/<\/cat>/<\/td><\/tr><tr><td>Definition<\/td><td>/g;
$in=~s/<\/sanskrit>/<\/td><\/tr>/g;
$in=~s/<\/sence>//g;
$in=~s/<\/def><sence><sanskrit>/<\/td><\/tr><tr><td>Sanskrit<\/td><td>/g;
$in=~s/<cat>//g;
$in=~s/<def>//g;
$in=$in."</table>";
print "$in";
}
