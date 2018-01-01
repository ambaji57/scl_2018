#!PERLPATH

#  Copyright (C) 2010-2017 Amba Kulkarni (ambapradeep@gmail.com)
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


@kqw_prawyayaH = ("तृच्","तव्यत्","यक्","शतृ","शानच्","घञ्","ण्वुल्","ण्यत्","ल्युट्","यत्","क्त","क्तवतु","अनीयर्");
$line_no = 0;
while($in = <STDIN>){
 chomp($in);
 $in =~ s/\t[\t]*/\t/g;
  @in = split(/\t/,$in);
  $in =~s/\\\// \/ /g;
  chomp($in);
  ($m,$f,$n)=split(/\t/,$in);
  if($in){
   if($line_no == 0) {
     print "<center>\n";
     print "<table border=0 width=50%>\n"; 
print "<tr><td colspan=4 align=\"center\"><font color=\"brown\" size=\"5\"><b>कृदन्तप्रातिपदिकम्</b></font></td></tr>\n";
     print "<tr  bgcolor='tan'><td align=\"center\"><font color=\"white\" size=\"4\">कृत् प्रत्ययः</font></td><td align=\"center\"><font color=\"white\" size=\"4\">पुंलिङ्गम्</font></td><td align=\"center\"><font color=\"white\" size=\"4\">स्त्रीलिङ्गम्</font></td><td align=\"center\"><font color=\"white\" size=\"4\">नपुंसकलिङ्गम्</font><//td></tr>\n";
   }
 
print "<tr><td width=20% bgcolor='#461B7E'  align='middle'><font color=\"white\" size=\"4\">$kqw_prawyayaH[$line_no]</font></td><td width=20% align=\"center\" bgcolor='#E6CCFF'><font color=\"black\" size=\"4\">";

if($m =~ /\?/) { print "-";} 
else {
#  print "<a href=\"javascript:generate_noun_forms('Unicode','$m','पुं','nA','2')\">$m</a></td>";
  print $m,"</td>";
}
print "</td><td width=20% align=\"center\" bgcolor='#E6CCFF'><font color=\"black\" size=\"4\">\n";
if($f =~ /\?/) { print "-";} 
else {
  #print "<a href=\"javascript:generate_noun_forms('Unicode','$f','स्त्री',''nA',2')\">$f</a>";
  print $f,"</td>";
}
print "<td width=20% align=\"center\" bgcolor='#E6CCFF'><font color=\"black\" size=\"4\">\n";
if($n =~ /\?/) { print "-";} 
else {
  #print "<a href=\"javascript:generate_noun_forms('Unicode','$n','नपुं','nA','2')\">$n</a></td></tr>\n";
  print $n,"</td>";
}
#}else{
#$unknown="$unknown $kqw_prawyayaH[$line_no] ,";
#}
	if($line_no == 13) {
     print "</table>\n";
	print "</center>\n";
  }
$line_no++;
  if($line_no == 13) { $line_no = 0;}
}
}
print "<center>\n";
     print "<table border=0 width=50%>\n";
print "</table>\n";
	print "</center>\n";
#$unknown="";
print "</body></html>\n";
