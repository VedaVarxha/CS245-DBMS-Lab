#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(){
	FILE* f1=fopen("t01.csv","r");
	FILE *f2=fopen("task02.sql","w");
	fprintf(f2,"USE week07;\n");

	for(int cnt = 0; cnt<500; cnt++){
		int a,b,c,d;
		char e[20];
		fscanf(f1,"%d,%d,%d,%d,%s\n", &a,&b,&c,&d,e);
		fprintf(f2,"INSERT INTO T01 VALUES(%d,%d,%d,%d,'%s');\n",a,b,c,d,e);
	}
}
