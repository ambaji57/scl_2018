#!PERLPATH 

#  Copyright (C) 2002-2017 Amba Kulkarni (ambapradeep@gmail.com)
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


$myPATH="SCLINSTALLDIR";

sub convert{
        my($encoding,$in_word) = @_;

           chomp($in_word);
           $conversion_program = "";
        if($encoding eq "VH") {
           $conversion_program = "$myPATH/converters/velthuis-wx.out";
         }
         if($encoding eq "KH") {
            $conversion_program = "$myPATH/converters/kyoto_ra.out";          
         }
         if($encoding eq "SLP") {
            $conversion_program = "$myPATH/converters/slp2wx.out";
         }
         if($encoding eq "Itrans") {
            $conversion_program = "$myPATH/converters/itrans_ra.out";
         }
         if($encoding eq "Unicode") {
            $conversion_program = "$myPATH/converters/utf82iscii.pl | $myPATH/converters/ir_skt";
         } 

         if($conversion_program ne "") {
            $out_word = `echo $in_word | $conversion_program`;
          } else { $out_word = $in_word;}

chomp($out_word);
return $out_word; 
}
1;
