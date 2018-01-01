#!GraphvizDot/perl -I LIB_PERL_PATH/

#  Copyright (C) 2013-2017 Amba Kulkarni (ambapradeep@gmail.com)
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

package main;
use CGI qw/:standard/;
#use CGI::Carp qw(fatalsToBrowser);

my $myPATH="SCLINSTALLDIR/";
my $converters_path="$myPATH/converters";
my $NNCG_path="$myPATH/NN/CG";
require "$myPATH/NN/common/style.pl";

      my $cgi = new CGI;
      print $cgi->header (-charset => 'UTF-8');

      print $style_header;
      print $title;

      if (param) {
        $nne=param("nne");
        $type=param("type");


        print "<center><br>";
        print &clean($nne);
        print "<br><br><br>";

        system("echo '$nne' | $converters_path/utf82wx.sh | $NNCG_path/nne2diagram.out $type | $converters_path/wx2utf8.sh | GraphvizDot/dot -Tsvg ");
        print "<br>";
      }
      print $style_tail;


sub clean{

my($str) = @_;
  $str =~ s/</\&lt;/g;
  $str =~ s/>/\&gt;/g;
  $str =~ s/:[0-9]+//g;
 
$str;
}
1;
