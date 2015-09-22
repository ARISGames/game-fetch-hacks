#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv)
{
  int size = 1024*1024;
  char *data = malloc(size); //way oversized- who cares
  char *o = malloc(size); //way oversized- who cares
  int i = 0;
  char c;
  int bdeep = 0;
  int qdeep = 0;
  int kdeep = 0;

  FILE *inf;
  if(!(inf = fopen(argv[1], "r"))) printf("Can't open input file");
  if(!fread(data, sizeof(char), size, inf)) printf("Can't read");

  while((c = data[i]) != '\0' && !bdeep)
  {
    if(c == '{') bdeep++;
    i++;
  }

  while((c = data[i]) != '\0' && bdeep)
  {
         if(c == '}') bdeep--;
    else if(c == '"')
    {
      if(qdeep > 0) qdeep--;
      else qdeep++;
      if(!kdeep) putchar('"');
    }
    else if(!qdeep && c == ':')
    {
      kdeep++;
    }
    else if(!qdeep && (c == ',' || c == ']'))
    {
      kdeep--;
      if(bdeep) putchar(',');
    }
    else
    {
      if(!kdeep) putchar(c);
    }
    i++;
  }
  putchar('\n');

  //read data
  i = 0;
  bdeep = 0;
  qdeep = 0;
  kdeep = 0;
  while((c = data[i]) != '\0')
  {
         if(c == '{') bdeep++;
    else if(c == '}') bdeep--;
    else if(c == '"')
    {
      if(i != 0 && data[i-1] == '\\') putchar('"');
      else if(qdeep > 0) qdeep--;
      else qdeep++;
    }
    else if(!qdeep && c == ':')
    {
      kdeep++;
      putchar('"');
    }
    else if(!qdeep && (c == ',' || c == ']'))
    {
      kdeep--;
      putchar('"');
      if(bdeep) putchar(',');
      else      putchar('\n');
    }
    else
    {
      if(kdeep) putchar(c);
    }
    i++;
  }
  return 0;
}

