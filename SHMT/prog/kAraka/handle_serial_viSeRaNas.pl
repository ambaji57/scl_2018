#!PERLPATH -I LIB_PERL_PATH/

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

# In case of serial viSeRaNas, connect the viSeRaNa to the ViSeRya directly.

use GDBM_File;
tie(%kAraka_name,GDBM_File,"$ARGV[0]",GDBM_READER,0644) || die "Can't open $ARGV[0] for reading";

$ans = "";
$i=0;

while($in = <STDIN>){
  chomp($in);
  if($in =~ /./) {
      if($in =~ /Cost/){
         &print_rels($rels);
         print $in ,"\n";
	 $rels = "";
      }elsif($in !~ /^\(/){
         print $in ,"\n";
	 $rels = "";
      } elsif($in =~ /\(/){
         $in =~ /([0-9]+),([0-9]+),([0-9]+),([0-9]+),([0-9]+)/;

          $rels .= ";".$in;
      }
  } else {
         &print_rels($rels);
	 print "\n";
  }
}
         &print_rels($rels);


sub print_rels{
  my($rels) = @_;

  $rels =~ s/^;//;
  @rels = split(/;/,$rels);
  for ($i=0;$i<=$#rels;$i++){
     if($rels[$i] =~ /([0-9]+,[0-9]+),51,([0-9]+,[0-9]+)/){
# 51: viSeRanam; refer prog/kAraka/list_n/kAraka_names.txt
        $current = $1;
        $next = $2;
        $tmp = $rels[$i];
        $found = 1;
        while($found) {
	      $found = 0;
              for ($j=0;$j<=$#rels;$j++){
	        if($rels[$j] =~ /$next,51,([0-9]+,[0-9]+)/){
	           $new_next = $1;
		   $tmp =~ s/51,$next/51,$new_next/;
		   $next = $new_next;
		   $found = 1;
                }
	        if($rels[$j] =~ /$next,8,([0-9]+,[0-9]+)/){
		   $found = 0;
		}
# 8: karwqsamAnAXikaraNa; refer prog/kAraka/list_n/kAraka_names.txt
	      }
	      if($found) { $rels[$i] = $tmp;}
        }
        print $rels[$i],"\n";
     } elsif($rels[$i]) { print $rels[$i],"\n";}
  }
}
1;
