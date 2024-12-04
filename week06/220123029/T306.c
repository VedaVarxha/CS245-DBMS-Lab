#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(){
FILE* f1=fopen("t03.csv","r");
FILE *f2=fopen("task04.sql","w");
fprintf(f2,"USE week06;\n");

int cnt=0;

while(cnt<500){
int h,i,f;
fscanf(f1,"%d,%d,%d\n", &h,&i,&f);
fprintf(f2,"INSERT INTO T03 VALUES(%d,%d,%d);\n",h,i,f);
cnt++;

}

}
