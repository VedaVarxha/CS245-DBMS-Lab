#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(){
FILE* f1=fopen("t01.csv","r");
FILE *f2=fopen("task02.sql","w");
fprintf(f2,"USE week06;\n");

int cnt=0;

while(cnt<1000){
int a,b,c,d,e;
fscanf(f1,"%d,%d,%d,%d,%d\n", &a,&b,&c,&d,&e);
fprintf(f2,"INSERT INTO T01 VALUES(%d,%d,%d,%d,%d);\n",a,b,c,d,e);
cnt++;

}

}
