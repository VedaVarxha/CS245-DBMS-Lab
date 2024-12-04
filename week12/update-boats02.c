#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("update-boats02.csv", "r");

    FILE *f2 = fopen("update-boats02.sql", "w");
    fprintf(f2, "USE week12;\n");
    
    char a[21];
    char b[21];
   
    fscanf(f1, "%20[^,], %20[^\n]\n", a, b);
    
    int i = 0;
    while (i < 20)
    {
        int bid;
        char bcolor[51];
     
        fscanf(f1, "%d, %50[^\n]\n", &bid, bcolor);
        fprintf(f2, "UPDATE boats SET bcolor = \"%s\"\n", bcolor);
        fprintf(f2, "WHERE bid = (%d);\n", bid); 
        
        i++;
    }    
}
