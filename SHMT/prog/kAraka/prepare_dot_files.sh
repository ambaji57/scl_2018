#!/bin/sh

myPATH=SCLINSTALLDIR
ANU_MT_PATH=$myPATH/SHMT/prog

OUTSCRIPT=$1
SENT_NO=$2
PROGRAM=$3
MORPHFILE=$4
PARSEFILE=$5
MYPATH=$6
parseno=$7

if [ $OUTSCRIPT = "DEV" ] ; then
 $myPATH/converters/wx2utf8.sh < $MORPHFILE | perl -pe 's/@//g' > $MORPHFILE.out
 kArakaName=$ANU_MT_PATH/kAraka/gdbm_n/kAraka_name_dev.gdbm
fi

if [ $OUTSCRIPT = "ROMAN" ] ; then
 $myPATH/converters/wx2utf8roman.out < $MORPHFILE > $MORPHFILE.out
 kArakaName=$ANU_MT_PATH/kAraka/gdbm_n/kAraka_name_roman.gdbm
fi

$ANU_MT_PATH/kAraka/$PROGRAM $OUTSCRIPT $SENT_NO $MORPHFILE.out $kArakaName $MYPATH $parseno < $PARSEFILE
