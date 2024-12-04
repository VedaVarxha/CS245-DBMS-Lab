
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("delete-boats02.csv", "r");

    FILE *f2 = fopen("delete-boats02.sql", "w");
    fprintf(f2, "USE week12;\n");
    
    
    int i = 0;
    while (i < 10)
    {
        int bid;
     
        fscanf(f1, "%d\n", &bid);
        fprintf(f2, "DELETE FROM boats WHERE bid = (%d);\n", bid);     
        i++;
    }    
}
