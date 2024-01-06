/*
    folder2c - creates a .c and a .h file with the contents of
               every binary file in a folder

    sverx\2015

*/

#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <dirent.h>

FILE *fIN;
FILE *fc;
FILE *fh;
DIR *dp;
struct dirent *entry;

#define BUFSIZE     160000
unsigned char buf[BUFSIZE];
#define SUBST_NUM   4
char *subst[SUBST_NUM]={" ",".","(",")"};

char paramshift=0;
bool verbose=false;
bool isDword=false;
bool isComment=false;
bool isSprite = false;

void cleanstr(char *str) {
  int i;
  for (i=0;i<SUBST_NUM;i++)
    while (strstr(str,subst[i]))
      strncpy (strstr(str,subst[i]),"_",1);
}


int main(int argc, char const* *argv) {

  char *cname, *hname, *iname, *clean;
  int i,cnt,size;
  int total_size=0;
  int bank_num=0;
  
  printf("*** sverx's folder2c converter ***\n");
	
  if (argc<3 || argc>5) {
    printf("Usage: folder2c [-v] folder outfilename [bank number]\n");
    printf("creates outfilename.c and outfilename.h with contents of every\nfile found in folder.\n");
    printf("-v : verbose\n");
    return(1);
  }
  
  if (strcmp("-v",argv[1])==0) {
    verbose=true;
    paramshift=1;
    printf("Info: verbose mode; will print file names while converting.\n");
  }  	
 
  if ((argc+paramshift)==4) {
    bank_num=atoi(argv[3+paramshift]);
    if (bank_num<=0) {
      printf("Fatal: invalid bank number\n");
      return(1);
    }
  }
  
  dp = opendir(argv[1+paramshift]);
  if (dp == NULL) {
    printf("Fatal: can't open %s folder\n",argv[1+paramshift]);
    return (1);
  }
  
  cname=malloc(strlen(argv[2+paramshift])+3);
  hname=malloc(strlen(argv[2+paramshift])+3);
  
  sprintf(cname,"%s.c",argv[2+paramshift]);
  sprintf(hname,"%s.h",argv[2+paramshift]);
  
  fc=fopen(cname,"w");
  if (!fc) {
    printf("Fatal: can't open output %s.c file\n",argv[2+paramshift]);
    return(1);
  }
  
  fh=fopen(hname,"w");
  if (!fh) {
    printf("Fatal: can't open output %s.h file\n",argv[2+paramshift]);
    return(1);
  }
  
  while ((entry=readdir(dp))) {
    if (entry->d_type==DT_REG) {
    
      clean=malloc(strlen(entry->d_name)+1);
      strcpy(clean,entry->d_name);
      cleanstr(clean);
      
      iname=malloc(strlen(argv[1+paramshift])+strlen(entry->d_name)+2);
      sprintf(iname,"%s/%s",argv[1+paramshift],entry->d_name);
      
      if (verbose)
        printf("Info: converting %s ...\n",entry->d_name);
      
      fIN=fopen(iname,"rb");
      if (!fc) {
        printf("Fatal: can't open %s\n",entry->d_name);
        return(1);
      }
        size=0;
      while (!feof(fIN)) {
        cnt=fread (buf, 1, BUFSIZE, fIN);
        printf("readed %d\n",  cnt);
        bool isInt = false;
        for (i=0;i<cnt;i++) {
          if(buf[i]== 'w')
            isInt = true;
        }
        if(isInt)
          fprintf (fc,"const unsigned int %s[] = {\n",clean);        
        else
          fprintf (fc,"const unsigned char %s[] = {\n",clean);
      
    
        //if ((size!=0) && (cnt!=0))
        //  fprintf (fc,"\n");
        //size+=cnt;
        for (i=0;i<cnt;i++) {
          if(buf[i] == 'w')
            isDword=true;
          if(buf[i] == 'b')
            isDword=false;
          if(buf[i] == ';')
            isComment = true;
          if(buf[i] == '\n')
            isComment = false;
          if(buf[i] == '$' && !isComment){
            if (size != 0)
              fprintf (fc,",");
            size++;
            if(isDword){
              fprintf (fc,"0x%c%c%c%c",buf[i+1],buf[i+2],buf[i+3],buf[i+4]);
              //fprintf (fc,"0x%c%c",buf[i+1],buf[i+2]);
              //fprintf (fc,",0x%c%c",buf[i+3],buf[i+4]);
              size++;
            }
            else
              fprintf (fc,"0x%c%c",buf[i+1],buf[i+2]);
            if(isInt){
              if(size % 64==0)
                fprintf(fc,"\n");
            }
            else
              if(size % 32==0)
                fprintf(fc,"\n");

          }
        }
      }
      
      fprintf (fc,"};\n\n");
      
      fprintf (fh,"extern const unsigned char\t%s[];\n",clean);
      fprintf (fh,"#define\t\t\t\t%s_size %d\n",clean,size);
      if (bank_num)
        fprintf (fh,"#define\t\t\t\t%s_bank %d\n",clean,bank_num);
      fprintf (fh,"\n");
      if (verbose)
        printf("Info: converted %s ...%d\n",entry->d_name, size);
      fclose (fIN);
      free(clean);
      free(iname);
      
      total_size+=size;
    }
  }
  
  fclose (fc);
  fclose (fh);
  closedir(dp);
  
  free(cname);
  free(hname);

  printf("Info: conversion completed. File \"%s.c\" defines %d total bytes.\n",argv[2+paramshift],total_size);
  return (0);
}
