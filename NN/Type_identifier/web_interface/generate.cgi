#!PERLPATH -I /usr/local/lib/perl/5.18.2/

#  Copyright (C) 2013-2017 Amba Kulkarni (ambapradeep@gmail.com)
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
#use CGI::Carp qw(fatalsToBrowser);

my $myPATH="SCLINSTALLDIR";
my $converters_path="$myPATH/converters";
my $NNtype_path="$myPATH/NN/Type_identifier";

require "$myPATH/NN/common/style.pl";
require "$myPATH/NN/Type_identifier/generate_samAsa_const_parse.pl";

my $pid = $$;

      my $cgi = new CGI;
      print $cgi->header (-charset => 'UTF-8');

	print $style_header;
	print $title;

      if (param) {
        my $nne=param("nne");
        my $pid = $$;

        print "<center>";
        my $samAsa = `echo '$nne' | $converters_path/utf82wx.sh | $NNtype_path/typeidentifier.out $type | $converters_path/wx2utf8.sh`;
        my $dot = &get_dot($samAsa);
        print $samAsa,"<br />";
        system ("echo '$dot' | dot -Tsvg;");

        print "</center><br />";
}
	print $style_tail;
