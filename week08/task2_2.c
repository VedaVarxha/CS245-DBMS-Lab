#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("course.csv", "r");

    FILE *f2 = fopen("task2_2.sql", "w");
    fprintf(f2, "USE week08;\n");

    int i = 0;
    while (i < 4)
    {
        char cid[6];
        char cname[100];
        fscanf(f1, "%5[^,],%99[^\n]\n", cid,cname);
        fprintf(f2, "INSERT INTO course (cid, cname) VALUES (\"%s\", \"%s\");\n", cid, cname);     
        i++;
    }    
}
