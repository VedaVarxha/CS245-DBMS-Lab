#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(){
FILE* f1=fopen("t02.csv","r");
FILE *f2=fopen("task03.sql","w");
fprintf(f2,"USE week06;\n");

int cnt=0;

while(cnt<500){
int a,b,f;
fscanf(f1,"%d,%d,%d\n", &f,&a,&b);
fprintf(f2,"INSERT INTO T02 VALUES(%d,%d,%d);\n",f,a,b);
cnt++;

}

}
