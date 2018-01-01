#!/bin/bash
 
  /usr/bin/mkfifo TFPATH/skt_splitter_to TFPATH/skt_splitter_from
  chmod 777 TFPATH/skt_splitter_to TFPATH/skt_splitter_from
  echo $$ > TFPATH/skt_splitter_daemonid
  #lt-proc -cz all_but_samboXana_morf.bin  <TMPPATHskt_splitter_to  >TMPPATHskt_splitter_from  &  pid=$!
  LTPROCBINDIR/lt-proc -cz SCLINSTALLDIR/morph_bin/nyAya_morf.bin  <TFPATH/skt_splitter_to  >TFPATH/skt_splitter_from  &  pid=$!
  # Open some file descriptors so the fifo's are open for the duration of the lt-proc process:
  exec 3>TFPATH/skt_splitter_to
  exec 4<TFPATH/skt_splitter_from
  echo $pid >> TFPATH/skt_splitter_daemonid
  wait $pid
