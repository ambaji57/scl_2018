OUTENCODING=$4
if [ $OUTENCODING = "DEV" ] ; then
CMD=wx2utf8.sh
fi
if [ $OUTENCODING = "ROMAN" ] ; then
CMD=wx2utf8roman.out
fi
SCLINSTALLDIR/amarakosha/relations.pl $1 $2 $3 $4 $5 | SCLINSTALLDIR/converters/$CMD
