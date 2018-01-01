#!PERLPATH -I LIB_PERL_PATH/

use GDBM_File;

tie(%LEX,GDBM_File,$ARGV[0],GDBM_READER,0444);
while (($key,$val) = each %LEX) {
                       print $key, ' = ', $val, "\n";
                  }

untie(%LEX);
