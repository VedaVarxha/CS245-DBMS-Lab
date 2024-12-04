#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(){
	FILE* f1=fopen("t02.csv","r");
	FILE *f2=fopen("task03.sql","w");
	fprintf(f2,"USE week07;\n");

	for(int cnt = 0; cnt<500; cnt++){
		int c1,c3;
		char c2[20];
		fscanf(f1,"%d,%19[^,],%d\n", &c1,c2,&c3);
		fprintf(f2,"INSERT INTO T02 VALUES(%d,'%s',%d);\n",c1,c2,c3);
	}
}
