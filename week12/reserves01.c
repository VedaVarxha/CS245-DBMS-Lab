#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("reserves01.csv", "r");

    FILE *f2 = fopen("reserves01.sql", "w");
    fprintf(f2, "USE week12;\n");
    
    
    int i = 0;
    while (i < 10)
    {
        int bid, sid;
        char day[51];
     
        fscanf(f1, "%d, %d, %50[^\n]\n", &sid, &bid, day);
        fprintf(f2, "INSERT INTO reserves (sid, bid, day) VALUES (%d, %d, \"%s\");\n", sid, bid, day);     
        i++;
    }    
}
