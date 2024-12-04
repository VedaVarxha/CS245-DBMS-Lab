#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("boats01.csv", "r");

    FILE *f2 = fopen("boats01.sql", "w");
    fprintf(f2, "USE week12;\n");
    
    
    int i = 0;
    while (i < 4)
    {
        int bid;
        char bname[51], bcolor[51];
     
        fscanf(f1, "%d, %50[^,], %50[^\n]\n", &bid, bname, bcolor);
        fprintf(f2, "INSERT INTO boats (bid, bname, bcolor) VALUES (%d, \"%s\", \"%s\");\n", bid, bname, bcolor);     
        i++;
    }    
}
