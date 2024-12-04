#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("concept 1.csv", "r");

    FILE *f2 = fopen("task2_3.sql", "w");
    fprintf(f2, "USE week08;\n");

    int i = 0;
    while (i < 96)
    {
        char cid[6];
        char qn[6];
        char descript[100];
        fscanf(f1, "%5[^,],%5[^,],%99[^\n]\n", cid, qn, descript);
        fprintf(f2, "INSERT INTO concept (cid, qn, descript) VALUES (\"%s\", \"%s\", \"%s\");\n",cid, qn, descript);     
        i++;
    }    
}
