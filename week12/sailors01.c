#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("sailors01.csv", "r");

    FILE *f2 = fopen("sailors01.sql", "w");
    fprintf(f2, "USE week12;\n");
    
    
    int i = 0;
    while (i < 10)
    {
        int sid,rating;
        float age;
        char sname[51];
     
        fscanf(f1, "%d, %50[^,], %d, %f\n", &sid, sname, &rating, &age);
        fprintf(f2, "INSERT INTO sailors (sid, sname, rating, age) VALUES (%d, \"%s\", %d, %f);\n", sid, sname, rating, age);     
        i++;
    }    
}
