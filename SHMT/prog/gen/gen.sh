#!/bin/sh
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

$SHMT_PATH/prog/gen/agreement.pl $SHMT_PATH/data  $SHMT_PATH/prog/gen D 2> TFPATH/err |\

$SHMT_PATH/prog/gen/call_gen.pl  $SHMT_PATH/prog/hnd_gen/test 2> /dev/null
