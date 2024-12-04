#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(){
FILE* f1=fopen("t04.csv","r");
FILE *f2=fopen("task05.sql","w");
fprintf(f2,"USE week06;\n");

int cnt=0;

while(cnt<200){
int k,h;
fscanf(f1,"%d,%d\n", &k,&h);
fprintf(f2,"INSERT INTO T03(h,i) VALUES(%d,%d);\n",k,h);
cnt++;

}

}
