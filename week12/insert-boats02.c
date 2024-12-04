#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("insert-boats02.csv", "r");

    FILE *f2 = fopen("insert-boats02.sql", "w");
    fprintf(f2, "USE week12;\n");
    
    char a[21];
    char b[21];
    char c[21];
    
    fscanf(f1, "%20[^,], %20[^,], %20[^\n]\n", a, b, c);
    
    int i = 0;
    while (i < 50)
    {
        int bid;
        char bname[51], bcolor[51];
     
        fscanf(f1, "%d, %50[^,], %50[^\n]\n", &bid, bname, bcolor);
        fprintf(f2, "INSERT INTO boats (bid, bname, bcolor) VALUES (%d, \"%s\", \"%s\");\n", bid, bname, bcolor);     
        i++;
    }    
}
