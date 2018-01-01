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


DEBUG="ON"

myPATH=SCLINSTALLDIR
TYPE=$1

PROG_PATH=$myPATH/SHMT/prog/sandhi_splitter
$myPATH/SHMT/prog/morph/bin/get_std_spelling.out < $2 > $2.1

if [ $TYPE = "S" ]; then
#$PROG_PATH/sandhi_samaasa_splitter.out -t -$1 $PROG_PATH/samAsa_words.txt $PROG_PATH/samAsa_rules.txt $myPATH/morph_bin/skt_samAsanoun_morf.bin $2.1 4 > most_probable_output.txt
$PROG_PATH/sandhi_samaasa_splitter.out -t -$1 $PROG_PATH/samAsa_words.txt $PROG_PATH/samAsa_rules.txt $myPATH/morph_bin/samAsa_splitter.bin $2.1 4 > most_probable_output.txt

else if [ $TYPE = "s" ]; then
#$PROG_PATH/sandhi_samaasa_splitter.out -t -$1 $PROG_PATH/sandhi_words.txt $PROG_PATH/sandhi_rules.txt $myPATH/morph_bin/skt_morf.bin $2.1 4 > most_probable_output.txt
$PROG_PATH/sandhi_samaasa_splitter.out -t -$1 $PROG_PATH/sandhi_words.txt $PROG_PATH/sandhi_rules.txt $myPATH/morph_bin/samAsa_splitter.bin $2.1 4 > most_probable_output.txt

else if [ $TYPE = "b" ]; then
$PROG_PATH/sandhi_samaasa_splitter.out -t -$1 $PROG_PATH/word_freq.txt $PROG_PATH/all_rules.txt $myPATH/morph_bin/samAsa_splitter.bin $2.1 4 > most_probable_output.txt

fi
fi
fi

$PROG_PATH/../interface/modify_mo_for_mo_display.pl < temp_result_mo > mo_display

cut -f1 most_probable_output.txt | $PROG_PATH/web_interface/add_tooltip.pl mo_display| $myPATH/converters/ri_skt | $myPATH/converters/iscii2utf8.py 1 > most_probable_output_utf.txt

tail -n +3 full_output | cut -f1 | $PROG_PATH/web_interface/add_tooltip.pl mo_display | $myPATH/converters/ri_skt | $myPATH/converters/iscii2utf8.py 1 > all_possible_outputs.txt

if [ $DEBUG = "OFF" ] ; then
 rm temp_result_mo expected_output expected_output_notfound words_notdone wordwx wordwx.1 words_notdone temp_result most_probable_output.txt todelete rank_percentages percent_discards mo_display full_output
fi
