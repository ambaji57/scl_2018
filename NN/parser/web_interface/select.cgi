#!PERLPATH -I LIB_PERL_PATH/

#  Copyright (C) 2014-2017 Amba Kulkarni (ambapradeep@gmail.com)
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

my $myPATH="SCLINSTALLDIR";
require "$myPATH/NN/common/style.pl";
require "$myPATH/NN/parser/functions.pl";

  my $cgi = new CGI;
  print $cgi->header (-charset => 'UTF-8');

  print $style_header;
  print $title;

  if (param) {
      $pid=param("pid");
      $instr=param("instr");

      $filepath="TFPATH/NN/parser/tmp_in$pid";
      $filename=$filepath."/out.txt";

      print "<center>";
      print $instructions;
      print "</center>";

      print "<center><div id=\"tables\">\n";
      ($more_choices,$instr) = split(/#/,&print_table($instr,$pid,$filename));
      print "</div></center>\n";

      if(!$more_choices){
         $ans = &get_parsed_string($instr,$filename);
         &tail($ans);
      } else { print "<div id=\"navigation\"></div>";}

  $ans =~ s/\<([.*])\-\^(wva|wA)\>/([.*])\-$1/g;
  $ans;
      print $style_tail;
   }
