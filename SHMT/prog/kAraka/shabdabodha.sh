#!/bin/sh
#
##  Copyright (C) 2002-2017 Amba Kulkarni (ambapradeep@gmail.com)
##
##  This program is free software; you can redistribute it and/or
##  modify it under the terms of the GNU General Public License
##  as published by the Free Software Foundation; either
##  version 2 of the License, or (at your option) any later
##  version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program; if not, write to the Free Software
##  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
SHMT_PATH=SCLINSTALLDIR/SHMT
ANU_MT_PATH=$SHMT_PATH/prog

if [ $# -lt 8 ] ; then
  echo "Usage: shabdabodha.sh GH_INPUT TMP_FILES_PATH <file> REL_OUTPUT_FILE [DEV|ROMAN] [NO|Partial|Full] [prose|Sloka] [ECHO|NOECHO]"
  exit
else
   GH_INPUT=$1
   TMP_FILES_PATH=$2
   OUTSCRIPT=$5
   PARSE=$6
   TEXT_TYPE=$7
   ECHO=$8
fi

mkdir -p $TMP_FILES_PATH/parser_files

if [ $PARSE != "NO" ] ; then
 
 if [ $ECHO = "ECHO" ] ; then
      echo "creating arcs"
 fi
 
$ANU_MT_PATH/kAraka/uniform_morph_anal.pl $TMP_FILES_PATH <  $TMP_FILES_PATH/$3
 
cd $TMP_FILES_PATH/parser_files
$ANU_MT_PATH/kAraka/split_multisentence_input.pl morph < ../$3
 
for i in `ls -1 *.clp| sort -n`
do
j=`basename $i .clp`
#echo $i > graph$j.txt
#/usr/bin/time -f "%Uuser %Ssystem %Eelapsed %PCPU (%Xtext+%Ddata %Mmax)k\n%Iinputs+%Ooutputs (%Fmajor+%Rminor)pagefaults %Wswaps %C\n" 
$ANU_MT_PATH/kAraka/Prepare_Graph/build_graph prose < $i  |\
$ANU_MT_PATH/kAraka/kaaraka_sharing_Sawq_kwa.pl morph$j.out $ANU_MT_PATH/kAraka/gdbm_n |\
$ANU_MT_PATH/kAraka/kaaraka_sharing.pl $ANU_MT_PATH/kAraka/gdbm_n/kAraka_name.gdbm  $ANU_MT_PATH/kAraka/gdbm_n/kAraka_num.gdbm > parseop$j.txt

# $ANU_MT_PATH/kAraka/prepare_dot_files.sh $OUTSCRIPT $j mk_graph_help.pl morph$j.out graph$j.txt ..
 
 if [ $ECHO = "ECHO" ] ; then
      echo "calling constraint solver to solve the equations"
 fi
 
#done
#cut -d' ' -f1-5 graph$j.txt | sort -u | sort -n | $ANU_MT_PATH/kAraka/Prepare_Graph/constraint_solver |\
# $ANU_MT_PATH/kAraka/handle_niwya_sambanXa.pl $ANU_MT_PATH/kAraka/gdbm_n/kAraka_name.gdbm  $ANU_MT_PATH/kAraka/gdbm_n/kAraka_num.gdbm > parseop$j.txt.1
#if [ $TEXT_TYPE = "prose" ] ; then
# $ANU_MT_PATH/kAraka/handle_serial_viSeRaNas.pl $ANU_MT_PATH/kAraka/gdbm_n/kAraka_name.gdbm < parseop$j.txt.1 > parseop_compressed$j.txt
#else 
#cp parseop$j.txt.1 parseop_compressed$j.txt
#fi
# echo $pwd 
 $ANU_MT_PATH/kAraka/add_parser_output.pl $ANU_MT_PATH/kAraka/gdbm_n parseop$j.txt 1 $GH_INPUT < morph$j.out |\
  $ANU_MT_PATH/kAraka/add_abhihita_info.pl  |\
  $ANU_MT_PATH/kAraka/disambiguate_hewu_karaNa.pl $SHMT_PATH/data/hi > morph${j}_1.out 
 
$ANU_MT_PATH/kAraka/prepare_dot_files.sh $OUTSCRIPT $j mk_kAraka_help.pl morph$j.out parseop$j.txt .. 1
cat morph${j}_1.out >> ../$3.1
done
  #$ANU_MT_PATH/kAraka/collapse_relations.pl ..
 
# We save this file, so that it can be further used for manual kaaraka tagging or for evaluation.
# This is no more needed. Now we have save excel sheet option, which saves complete analysis including morph analysis
 #$ANU_MT_PATH/kAraka/prepare_kAraka_tagged_file.pl 3 9 < ../$3.1 > ../$4
 mv ../$3.1 ../$3
else
# cp $TMP_FILES_PATH/$3 $TMP_FILES_PATH/$2.bak
 touch $TMP_FILES_PATH/parser_files/parseop.txt
 $ANU_MT_PATH/kAraka/handle_no_parse.pl < $TMP_FILES_PATH/$3 |\
 $ANU_MT_PATH/kAraka/add_parser_output.pl $ANU_MT_PATH/kAraka/gdbm_n $TMP_FILES_PATH/parser_files/parseop.txt 1 $GH_INPUT > $TMP_FILES_PATH/$3
fi
