#!PERLPATH -w

$daemon_running=1;
#Start Apertium Morph Daemon, if not already started
if (! -p "TFPATH/skt_splitter_to") { $daemon_running=0;}
if (-e "TFPATH/skt_splitter_to") { $daemon_running=0;}
#   print "1 daemon_running = $daemon_running\n";
if (! -p "TFPATH/skt_splitter_from" ) { $daemon_running=0;}
#   print "2 daemon_running = $daemon_running\n";
if (! -s "TFPATH/skt_splitter_daemonid") { $daemon_running=0;}
#   print "3 daemon_running = $daemon_running\n";
if (-s "TFPATH/skt_splitter_daemonid"){
   open(TMP,"<TFPATH/skt_splitter_daemonid") || die "Can't open TFPATH/skt_splitter_daemonid for reading\n";
   @dpids = <TMP>;
   close(TMP);
   foreach $dpid (@dpids) {
      $t=`ps h -p $dpid`;
      if ($t eq "") { $daemon_running=0; }
   }
}
# When TMPPATHto TMPPATHfrom and TMPPATHmorph_daemonid exists but the lt-proc is not running, then this programme can not detect such processes, and these are to be killed manually.
#print "4 daemon_running = $daemon_running\n";
 
if(!$daemon_running){
   if (-p "TFPATH/skt_splitter_to") { `rm TFPATH/skt_splitter_to`;}
   if (-e "TFPATH/skt_splitter_to") { `rm TFPATH/skt_splitter_to`;}
   if (-p "TFPATH/skt_splitter_from") { `rm TFPATH/skt_splitter_from`;}
   if (-s "TFPATH/skt_splitter_daemonid"){
      open(TMP,"<TFPATH/skt_splitter_daemonid");
        @dpids = <TMP>;
      close(TMP);
      foreach $dpid (@dpids) {
          $t=`ps h -p $dpid`;
          if ($t ne "") { `sudo kill -9 $dpid`;}
      }
      `rm TFPATH/skt_splitter_daemonid`;
    }
    system("nohup SCLINSTALLDIR/NN/segmenter/skt_splitter_server.sh > /dev/null &");
    #print "Skt Morph Daemon Successfully started\n";
} else {
  #print "Skt Morph Daemon is already running\n";
}
