#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("update-sailors02.csv", "r");

    FILE *f2 = fopen("update-sailors02.sql", "w");
    fprintf(f2, "USE week12;\n");
    
    
    int i = 0;
    while (i < 100)
    {
        int sid,rating;
        
     
        fscanf(f1, "%d, %d\n", &sid, &rating);
        fprintf(f2, "UPDATE sailors SET rating = (%d)\n", rating);
        fprintf(f2, "WHERE sid = (%d);\n", sid);     
        i++;
    }    
}
