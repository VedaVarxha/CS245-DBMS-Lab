#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("sailors04.csv", "r");

    FILE *f2 = fopen("sailors04.sql", "w");
    fprintf(f2, "USE week12;\n");
     
    char a[21];
    char b[21];
    char c[21];
    char d[21];
    
    fscanf(f1, "%20[^,], %20[^,], %20[^,], %20[^\n]\n", a, b, c, d);
    
    
    int i = 0;
    while (i < 100)
    {
        int sid,rating;
        float age;
        char sname[51];
     
        fscanf(f1, "%d, %50[^,], %d, %f\n", &sid, sname, &rating, &age);
        fprintf(f2, "INSERT INTO sailors (sid, sname, rating, age) VALUES (%d, \"%s\", %d, %0.1f);\n", sid, sname, rating, age);     
        i++;
    }    
}
