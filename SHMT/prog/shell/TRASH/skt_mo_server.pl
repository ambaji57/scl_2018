#!PERLPATH

$daemon_running=1;
#Start Apertium Morph Daemon, if not already started
if (! -p "TFPATH/skt_mo_to") { $daemon_running=0;}
#   printf "1 daemon_running = $daemon_running\n";
if (! -p "TFPATH/skt_mo_from" ) { $daemon_running=0;}
#   printf "2 daemon_running = $daemon_running\n";
if (! -s "TFPATH/skt_morph_daemonid") { $daemon_running=0;}
#   printf "3 daemon_running = $daemon_running\n";
if (-s "TFPATH/skt_morph_daemonid"){
   open(TMP,"<TFPATH/skt_morph_daemonid");
   @dpids = <TMP>;
   close(TMP);
   foreach $dpid (@dpids) {
      $t=`ps h -p $dpid`;
      if ($t eq "") { $daemon_running=0; }
   }
}
# When TMPPATHto TMPPATHfrom and TMPPATHmorph_daemonid exists but the lt-proc is not running, then this programme can not detect such processes, and these are to be killed manually.
#printf "4 daemon_running = $daemon_running\n";
 
if(!$daemon_running){
   if (-p "TFPATH/skt_mo_to") { `rm TFPATH/skt_mo_to`;}
   if (-p "TFPATH/skt_mo_from") { `rm TFPATH/skt_mo_from`;}
   if (-s "TFPATH/skt_morph_daemonid"){
      open(TMP,"<TFPATH/skt_morph_daemonid");
        @dpids = <TMP>;
      close(TMP);
      foreach $dpid (@dpids) {
          $t=`ps h -p $dpid`;
          if ($t ne "") { `sudo kill -9 $dpid`;}
      }
      `rm TFPATH/skt_morph_daemonid`;
    }
    system("nohup SCLINSTALLDIR/SHMT/prog/shell/skt_mo_server.sh &");
    printf("Skt Morph Daemon Successfully started\n");
} else {
  printf("Skt Morph Daemon is already running\n");
}
