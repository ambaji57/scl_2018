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

use GDBM_File;
tie(%LEX,GDBM_File,$ARGV[0],GDBM_WRCREAT,0644)|| die "Can't open $ARGV[0] for writing";

while($in = <STDIN>) {
chomp($in);
 ($gaNa,$XAwu,$paxI,$Heritage_rt,$SaMsAXanI_rt) = split(/\t/,$in); 
 if($Heritage_rt ne "-") {
  @f = split(/,/,$Heritage_rt);
  foreach $f (@f) {
    $f =~ s/\([0-9]+\)//;
    $key = $f."_".$paxI;
    $value = $SaMsAXanI_rt."_".$XAwu."_".$gaNa;
    if($LEX{$key} eq "") { $LEX{$key} = $value;}
    else { $LEX{$key} .= "#".$value;}
  }
 }
}
untie(%LEX);
