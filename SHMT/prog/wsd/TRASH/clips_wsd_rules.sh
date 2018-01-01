#!/bin/sh
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


ANU_MT_PATH=$SHMT_PATH/prog

rm -rf $TMP_FILES_PATH/clips_wsd_files
mkdir $TMP_FILES_PATH/clips_wsd_files

#cut -f4,9,10 $1 | $ANU_MT_PATH/wsd/add_kaaraka_info.pl | $ANU_MT_PATH/wsd/wsd_with_kaaraka_relations.pl $ANU_MT_PATH/wsd/ > $2 2> $TMP_FILES_PATH/wsd
#$ANU_MT_PATH/wsd/cnvrtkaaraka2clips.pl $ANU_MT_PATH/wsd/wsd.clp $TMP_FILES_PATH < $2
#
#cd $TMP_FILES_PATH/clips_wsd_files
#cp $ANU_MT_PATH/kAraka/gdbm_n/*.gdbm .
#
#rm -f bar.txt
#for i in `ls *.clp`
# do
# echo $i >> bar.txt
# $SHMT_PATH/software/CLIPS/myclips -f $i  > /dev/null 2> /dev/null
# done

cut -f4,9,10 $1 | $ANU_MT_PATH/wsd/add_kaaraka_info.pl > $2
$ANU_MT_PATH/wsd/cnvrtkaaraka2clips.pl $TMP_FILES_PATH < $2
touch $TMP_FILES_PATH/clips_wsd_files/bar.txt
$ANU_MT_PATH/wsd/wsd $ANU_MT_PATH/wsd/ < $TMP_FILES_PATH/clips_wsd_files/rl1.clp 2> $TMP_FILES_PATH/wsd

cat $2 | $ANU_MT_PATH/wsd/create_wsd.pl $TMP_FILES_PATH/clips_wsd_files/bar.txt > $3

paste $1 $3 | perl -p -e 's/^\t//'  > $TMP_FILES_PATH/tmp
mv $TMP_FILES_PATH/tmp $1
rm $TMP_FILES_PATH/wsd
