#!/bin/sh
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


myPATH=SCLINSTALLDIR/
export SHMT_PATH=$myPATH/SHMT
ANU_MT_PATH=$SHMT_PATH/prog
export LC_ALL=POSIX
#temp_files_path=$1
TMP_DIR_PATH=$2
LANG=$3
OUTSCRIPT=$4
SANDHI=$5
MORPH=$6
PARSE=$7
TEXT_TYPE=$8
ECHO=$9
DEBUG=$10

if [ $OUTSCRIPT = "ROMAN" ]; then
 my_converter="$myPATH/converters/wx2utf8roman.out"
 my_converter_wxHindi="$myPATH/converters/wx2utf8roman.out"
fi

if [ $OUTSCRIPT = "DEV" ]; then
  my_converter="$myPATH/converters/wx2utf8.sh"
  my_converter_wxHindi="$myPATH/converters/wxHindi-utf8.sh"
fi

if [ $# -lt 1 ] ; then
  echo "Usage: parser.sh <file> hi [DEV|ROMAN] [NO|YES] [UoHyd|GH] [NO|Partial|Full] [Sloka|Prose] [ECHO|NOECHO] [D]."
fi

cd $TMP_DIR_PATH

fbn=`basename $1` #fbn = file base name
dnm=`dirname $1` #dnm = directory name

temp_files_path=${dnm}/tmp_$fbn

export TMP_FILES_PATH=$temp_files_path

if [ -f "tmp_$fbn"  ] ; then 
  echo "File tmp_$fbn exists. Remove or rename it, and give the command again."
else
    mkdir -p $temp_files_path

    if [ $DEBUG = "D" ] ; then
       mkdir $temp_files_path/DEBUG
    fi
###########
    if [ $MORPH = "UoHyd" ] ; then

    if [ $ECHO = "ECHO" ] ; then
         echo "Formatting"
    fi
    $ANU_MT_PATH/format/format.sh $1 $temp_files_path/$fbn.out
    if [ $DEBUG = "D" ] ; then
       cp $temp_files_path/$fbn.out $temp_files_path/DEBUG/formatting.out
    fi
###########
    if [ $ECHO = "ECHO" ] ; then
         echo "Sandhi Splitting"
    fi
    if [ $SANDHI = "YES" ] ; then
    cp $temp_files_path/$fbn.out $temp_files_path/$fbn.out.orig
    $ANU_MT_PATH/sandhi_splitter/split.sh $temp_files_path/$fbn.out
    fi
    if [ $SANDHI = "NO" ] ; then
       
        cp $temp_files_path/$fbn.out $temp_files_path/$fbn.out.orig
        $ANU_MT_PATH/sandhi_splitter/copy_field.pl < $temp_files_path/$fbn.out.orig > $temp_files_path/$fbn.out
    fi
###########
    if [ $ECHO = "ECHO" ] ; then
       echo "Morph analysis"
    fi
#    /usr/bin/time 
$ANU_MT_PATH/morph/morph.sh $temp_files_path/$fbn.out $temp_files_path/$fbn.mo_all $temp_files_path/$fbn.mo_prune $temp_files_path/$fbn.mo_kqw $temp_files_path/$fbn.unkn
    if [ $DEBUG = "D" ] ; then
       cp $temp_files_path/$fbn.out $temp_files_path/DEBUG/morph.out
    fi

    # $1.unkn contains the unrecognised words
    # $1.mo_all: Monier williams o/p
    # $1.mo_prune: After pruning with Apte's dict
    # $1.mo_kqw: After adding derivational morph analysis
  fi

  GH_Input="NO"
  if [ $MORPH = "GH" ] ; then
     $ANU_MT_PATH/Heritage_morph_interface/Heritage2anusaaraka_morph.sh $TMP_DIR_PATH tmp_$fbn/$fbn.gh tmp_$fbn/$fbn.out
     GH_Input="YES"
  fi

###########
    if [ $ECHO = "ECHO" ]; then
        echo "Morph to clips conversion"
    fi
#     # First argument: Name of the file
#     # Second argument: no of parses
#     # Third argument: Name of the file with kaaraka analysis for annotation
# Fields 9 and 10: morph analysis corresponding to the kaaraka role and kaaraka role in the 10th field
#     /usr/bin/time 
$ANU_MT_PATH/kAraka/clips_rules.sh $GH_Input $temp_files_path $fbn.out $fbn.kAraka $OUTSCRIPT $PARSE $TEXT_TYPE $ECHO $DEBUG
    if [ $DEBUG = "D" ] ; then
       cp $temp_files_path/$fbn.out $temp_files_path/DEBUG/kaaraka.out
    fi
#    /usr/bin/time 
$ANU_MT_PATH/parser_fail_prune/parser_fail_prune.sh $temp_files_path/$fbn.out
    if [ $DEBUG = "D" ] ; then
       cp $temp_files_path/$fbn.out $temp_files_path/DEBUG/shallow_parser.out
    fi
#
###########
# anaphora in the 11th field
     if [ $ECHO = "ECHO" ]; then
         echo "Anaphora resolution"
     fi
         # First argument: Name of the input file
         # Second argument: Name of the output file
#         /usr/bin/time 
$ANU_MT_PATH/anaphora/anaphora.sh $temp_files_path $fbn.out

###########
# wsd in the 12th field
    if [ $ECHO = "ECHO" ] ; then
         echo "WSD "
    fi
#    /usr/bin/time 
$ANU_MT_PATH/wsd/clips_wsd_rules.sh $temp_files_path/$fbn.out $temp_files_path/$fbn.wsd $temp_files_path/$fbn.wsd_upapaxa
    if [ $DEBUG = "D" ] ; then
       cp $temp_files_path/$fbn.out $temp_files_path/DEBUG/wsd.out
    fi
###########
#
    if [ $ECHO = "ECHO" ] ; then
      echo "POS "
    fi
# Color Code in the 13th field
    $ANU_MT_PATH/pos/pos.sh $temp_files_path/$fbn.out $temp_files_path/$fbn.pos
    if [ $DEBUG = "D" ] ; then
       cp $temp_files_path/$fbn.out $temp_files_path/DEBUG/pos.out
    fi

###########
   $ANU_MT_PATH/interface/modify_mo_for_display.pl < $temp_files_path/$fbn.out > $temp_files_path/$fbn.fmt_all
###########
 cp $temp_files_path/$fbn.fmt_all $temp_files_path/$fbn.fmt_all_back
  cut -f1,2 $temp_files_path/$fbn.fmt_all > f1
  cut -f3,4 $temp_files_path/$fbn.fmt_all | $my_converter > f2
  cut -f5 $temp_files_path/$fbn.fmt_all > f3
  cut -f6-7,9,10 $temp_files_path/$fbn.fmt_all | $my_converter > f4
  cut -f11,13 $temp_files_path/$fbn.fmt_all > f5
 
  paste f1 f2 f3 f4 f5 | perl -pe 's/^\t.*//' > $temp_files_path/$fbn.fmt_all
  $ANU_MT_PATH/interface/gen_xml.pl 9 < $temp_files_path/$fbn.fmt_all  > $temp_files_path/${fbn}_main.xml
 rm f1 f2 f3 f4 f5
  $ANU_MT_PATH/interface/change_dir_name_in_xsl.pl $temp_files_path $OUTSCRIPT < $ANU_MT_PATH/interface/xhtml_unicode_sn-hi.xsl > xhtml_unicode_sn-hi.xsl
  xsltproc xhtml_unicode_sn-hi.xsl $temp_files_path/${fbn}_main.xml > tmp.html
  rm xhtml_unicode_sn-hi.xsl
 $ANU_MT_PATH/interface/add_dict_ref.pl $OUTSCRIPT < tmp.html > $1.html
fi
