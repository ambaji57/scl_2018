#!PERLPATH

#  Copyright (C) 2010-2016 Amba Kulkarni (ambapradeep@gmail.com)
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




open(TMP,"<$ARGV[0]") || die "Can't open $ARGV[0] for reading";

while($in = <TMP>){
  if($in =~ /rl([0-9]+).clp/) {
     $sent = $1;  
  }  elsif($in =~ /\(([0-9]+) [^ ]+ (.*)\)/) {
       $id = $1;
       $kaaraka_rl = $2;
       $key1 = $sent.".".$id;
       if ($MSG{$key1} eq "") { $MSG{$key1} = $kaaraka_rl;}
#       else {  $MSG{$key1} .= "/". $kaaraka_rl;}
  }
}

$/ = "\n\n";
$sent = 1;
while($in = <STDIN>){
 @in = split(/\n/,$in);
  $id = 1;
 foreach $in (@in) {
   $key = $sent.".".$id;
   if ($MSG{$key}) { print $MSG{$key}; } 
   print "\n";
   $id++;
 }
 print "\n";
 $sent++;
}
