#!PERLPATH -I LIB_PERL_PATH/

#  Copyright (C) 1997-2017 Amba Kulkarni (ambapradeep@gmail.com)
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
tie(%LEX,GDBM_File,$ARGV[0],GDBM_READER,0444);
#print $ARGV[0],"\n";
while (($key,$val) = each %LEX) {
                       print $key, ' = ', $val, "\n";
                  }

untie(%LEX);
