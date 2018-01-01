#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include "struct.h"

#define myPATH "SCLINSTALLDIR/skt_gen/compounds"
extern void fgetword();

void get_sandhied_word (char *prAwipaxikam1, char *prAwipaxikam2, char *sandhiw)
{
    char cmd[LARGE];
    FILE *fp;
    char fout[MEDIUM];
    char f1out[MEDIUM];

    int pid;

    pid = getpid();
    sprintf(fout,"TFPATH/sandhi%d",pid);
    sprintf(f1out,"TFPATH/1sandhi%d",pid);

    cmd[0]='\0';
    sprintf(cmd,"%s/main_sandhi.pl %s+%s > %s",myPATH,prAwipaxikam1,prAwipaxikam2,fout);
    system(cmd);
    sprintf(cmd,"cut -d, -f1 %s > %s ",fout,f1out);
    system(cmd);
    if((fp=fopen(f1out,"r"))==NULL)
    {
      printf("@Error @in @opening %s\n",f1out);
      exit(0);
    } else {
      fgetword(fp,sandhiw,'\n');
      fclose(fp);
    }
    sprintf(cmd,"rm %s %s",fout,f1out);
    system(cmd);
}
