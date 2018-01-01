#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include "struct.h"

extern void fgetword();

#define myPATH "SCLINSTALLDIR/converters"

void cnvrtwx2utf(char *in, char *out){
  int pid;
  FILE *fp;
  char fin[MEDIUM];
  char fout[MEDIUM];
  char cmd[MEDIUM];

  pid = getpid();
  sprintf(fin,"TFPATH/tmp%d",pid);
  sprintf(fout,"TFPATH/result%d",pid);

  if((fp = fopen(fin,"w"))==NULL) {
     printf("Error in %s opening for writing\n",fin);
     exit (0);
  }

  fprintf(fp,"%s ",in);
  fclose(fp);

  sprintf(cmd,"%s/wx2utf8.sh < %s > %s",myPATH,fin,fout);
  system(cmd);

  if((fp = fopen(fout,"r"))==NULL) {
     printf("Error in %s opening for reading\n",fout);
     exit (0);
  }
  fgetword(fp,out,'\n');
  fclose(fp);
  sprintf(cmd,"rm %s %s",fin,fout);
  system(cmd);
}
