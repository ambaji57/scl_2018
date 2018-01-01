#!/bin/bash
 
  mkfifo TFPATH/skt_mo_to TFPATH/skt_mo_from
  chmod 777 TFPATH/skt_mo_to TFPATH/skt_mo_from
  echo $$ > TFPATH/skt_morph_daemonid
  LTPROCBINDIR/lt-proc -cz SCLINSTALLDIR/morph_bin/skt_morf.bin  <TFPATH/skt_mo_to  >TFPATH/skt_mo_from  &  pid=$!
  # Open some file descriptors so the fifo's are open for the duration of the lt-proc process:
  exec 3>TFPATH/skt_mo_to
  exec 4<TFPATH/skt_mo_from
  echo $pid >> TFPATH/skt_morph_daemonid
  wait $pid
