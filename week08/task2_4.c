#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("marks.csv", "r");

    FILE *f2 = fopen("task2_4.sql", "w");
    fprintf(f2, "USE week08;\n");

    int i = 0;
    while (i < 28008)
    {
        int roll,set1_marks,set2_marks;
        char cid[6];
        char set1[6];
        char set2[6];
        fscanf(f1, "%d,%5[^,],%5[^,],%d,%5[^,],%d\n", &roll,cid,set1,&set1_marks,set2,&set2_marks);
        fprintf(f2, "INSERT INTO marks (roll,cid,set1,set1_marks,set2,set2_marks) VALUES (%d, \"%s\", \"%s\",%d ,\"%s\",%d);\n", roll,cid,set1,set1_marks,set2,set2_marks);     
        i++;
    }    
}
