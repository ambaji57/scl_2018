#This program marks multiple entries in a file by ?

cut -d, -f1,2 $1 | sort > w
sort -u w > ws
#diff w ws | grep '<' | sed '1,$s/< //' > mt
diff w ws | grep '<' | perl -p -e 's/< //' > mt
#sed '1,$s/\(.*\)/1,\$s\/^\1\/?\1\//' < mt > mt1
perl -p -e 's/\(.*\)/1,\$s\/^\1\/?\1\//' < mt > mt1
