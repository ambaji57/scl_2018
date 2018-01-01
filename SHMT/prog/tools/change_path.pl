#!PERLPATH

#  Copyright (C) 2008-2017 Amba Kulkarni (ambapradeep@gmail.com)
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


$PATH=$ARGV[0];

@lst = &get_files("software","*.pl");
&change_path($PATH,@lst);

@lst = &get_files("../","*.cgi");
&change_path($PATH,@lst);

@lst = &get_files("prog/interface","*.xsl");
&change_path($PATH,@lst);

@lst = &get_files("prog/interface","*.pl");
&change_path($PATH,@lst);

@lst = &get_files("prog/tools","*.[ps][lh]");
&change_path($PATH,@lst);

@lst = &get_files("prog/shell","*.sh");
&change_path($PATH,@lst);

@lst = &get_all_perl_files("prog","*.pl");
&change_perl_path($PATH,@lst);

@lst = &get_all_perl_files("data","*.pl");
&change_perl_path($PATH,@lst);

$USERNAME= $PATH;
$USERNAME =~ s/.*\///;
@lst = &get_files("prog/interface","*.xsl");
&change_username($USERNAME,@lst);

@lst = &get_files("prog/interface","*.pl");
&change_username($USERNAME,@lst);

@lst = &get_files("software","*.pl");
&change_username($PATH,@lst);

sub get_files{
my($d_nm, $pth_ext) = @_;

$cmd = "find $d_nm -iname \"$pth_ext\" -exec  grep -l ambaji {} \\;";
$lst=`$cmd`;
@lst= split(/\n/,$lst);

@lst;
}
1;

sub get_all_perl_files{
my($d_nm, $pth_ext) = @_;

$cmd = "find $d_nm -iname \"$pth_ext\"";
$lst=`$cmd`;
@lst= split(/\n/,$lst);

@lst;
}
1;
sub change_path{
my($MY_PATH,@lst) = @_;

my($in);

 foreach $lst (@lst){
  open(TMP,"<$lst") || die "Can't open $lst";
  open(TMP1,">tmp") || die "Can't open tmp";
  print "Changing paths in $lst\n";
  while($in = <TMP>){
    $in =~ s#/home/ambaji#$MY_PATH#g;
    if($MY_PATH =~ /huet/) {
       $in =~ s#/public_html#/Sites#g; # For Gerard
    }
    print TMP1 $in;
  }
  close(TMP); 
  close(TMP1); 
  system("mv tmp $lst; chmod +x $lst");
 }
}
1;

sub change_perl_path{
my($MY_PATH,@lst) = @_;

my($in);

 print "Changing perl paths in @lst\n";
 foreach $lst (@lst){
  open(TMP,"<$lst") || die "Can't open $lst";
  open(TMP1,">tmp") || die "Can't open tmp";
  print "Changing perl paths in $lst\n";
  while($in = <TMP>){
    if($MY_PATH =~ /huet/) {
       $in =~ s#PERLPATH#/usr/local/bin/perl#g; #For Gerard
    }
    print TMP1 $in;
  }
  close(TMP); 
  close(TMP1); 
  system("mv tmp $lst; chmod +x $lst");
 }
}
1;
sub change_username{
my($MY_NAME,@lst) = @_;

my($in);

 foreach $lst (@lst){
  open(TMP,"<$lst") || die "Can't open $lst";
  open(TMP1,">tmp") || die "Can't open tmp";
  print "Changing username in $lst\n";
  while($in = <TMP>){
    $in =~ s#~ambaji#~$MY_NAME#g;
    if($MY_PATH =~ /huet/) {
       $in =~ s#/public_html#/Sites#g; # For Gerard
    }
    print TMP1 $in;
  }
  close(TMP); 
  close(TMP1); 
  system("mv tmp $lst; chmod +x $lst");
 }
}
1;
