#!PERLPATH

#  Copyright (C) 2009-2016 Amba Kulkarni (ambapradeep@gmail.com)
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


my $myPATH="SCLINSTALLDIR";
require "$myPATH/converters/convert.pl";

$word = $ARGV[0];
$encoding = $ARGV[1];
$mode = $ARGV[2];

$word_wx=&convert($encoding,$word);
chomp($word_wx);

#The input text is converted from wx to utf8 and stored in wordutf$$
#The output of the morph is stored in wordout$$

system("$myPATH/SHMT/prog/morph/webrun_morph.sh $word_wx $mode");
