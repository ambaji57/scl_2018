#!PERLPATH

my $myPATH="SCLINSTALLDIR";
require "$myPATH/converters/convert.pl";
require "$myPATH/sandhi/sandhi.pl";

#  Copyright (C) 2002-2006 Sushama Vempati
#  Copyright (C) 2002-2016 Amba Kulkarni (ambapradeep@gmail.com)
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

$encoding = $ARGV[0];
$sandhi_type = $ARGV[1];
$word1 = $ARGV[2];
$word2 = $ARGV[3];

require "$myPATH/sandhi/apavAxa_${sandhi_type}.pl";
require "$myPATH/sandhi/${sandhi_type}_sandhi.pl";

      $word1_wx=&convert($encoding,$word1);
      chomp($word1_wx);

      $word2_wx=&convert($encoding,$word2);
      chomp($word2_wx);
      
      $ans = &sandhi($word1_wx,$word2_wx);
      @ans=split(/,/,$ans);

       $string = $word1_wx.",".$word2_wx.",".$ans[0].",".$ans[1].",".$ans[2].",".$ans[3].",".$ans[4].",".$ans[5].",".$ans[6].",".$ans[7].",";

      open TMP, " | $myPATH/converters/ri_skt | $myPATH/converters/iscii2utf8.py 1";
      print TMP $string;
      close TMP;
      
