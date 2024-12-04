#include <stdio.h>
#include <stdlib.h>

int main(){

FILE *f1 = fopen("sailor_name.csv" , "r");
FILE *f2 = fopen("q5.sql" , "w");
fprintf(f2," week11; \n");
char b[6];
int c;
int cnt = 0;
char a[50];
fscanf(f1 ,"%s ",a);
while(cnt <700)
{


fscanf(f1 ," %d,%20[^\n] \n",&c,b);
fprintf(f2 , "INSERT INTO sailor_name VALUES (%d,'%s'); \n",c,b);
cnt++;
}

}
