#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int main()
{
    FILE *f1 = fopen("course.csv", "r");

    FILE *f2 = fopen("task2.sql", "w");
    fprintf(f2, "USE week08;\n");

    int i = 0;
    while (i < 700)
    {
        int roll;
        char nam[20];
        char program[20];
        fscanf(f1, "%d,%19[^,],%19[^\n]\n", &roll, nam, program);
        fprintf(f2, "INSERT INTO student (roll, nam, program) VALUES (%d, \"%s\", \"%s\");\n", roll, nam, program);     
        i++;
    }    
}
