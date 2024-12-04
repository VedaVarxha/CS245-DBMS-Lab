#include <stdio.h>
#include <stdlib.h>

int main(){

FILE *f1 = fopen("boat_name.csv" , "r");
FILE *f2 = fopen("q52.sql" , "w");
fprintf(f2," week11; \n");
char b[6];
int c;
int cnt = 0;
char a[50];
fscanf(f1 ,"%s ",a);
while(cnt <100)
{


fscanf(f1 ," %d,%s \n",&c,b);
fprintf(f2 , "INSERT INTO boat_name VALUES (%d,'%s'); \n",c,b);
cnt++;
}

}
