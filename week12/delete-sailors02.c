
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("delete-sailors02.csv", "r");

    FILE *f2 = fopen("delete-sailors02.sql", "w");
    fprintf(f2, "USE week12;\n");
    
    
    int i = 0;
    while (i < 30)
    {
        int sid;
     
        fscanf(f1, "%d\n", &sid);
        fprintf(f2, "DELETE FROM sailors WHERE sid = (%d);\n", sid);     
        i++;
    }    
}
