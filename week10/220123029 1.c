#include <mysql/mysql.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
int strtoint(char st[],int length){
    int j=0;
    for(int i=0;i<length;i++){
        j*=10;
        j+=st[i]-'0';
    }
    return j;
}
//task05
void compute_spi(MYSQL *con,char roll []){
    char q[400];
    
    for(char i=1;i<=8;i++){
        int gradepoint=0;
        int total_credits=0;
        sprintf(q,"SELECT letter_grade,c FROM course18 NATURAL JOIN grade18 WHERE (semester=%c and roll_number=%s)",(char)(i+'0'),roll);
        mysql_query(con,q);
        MYSQL_RES *letter_grade = mysql_store_result(con);
        int num_fields=mysql_num_fields(letter_grade);
        MYSQL_ROW row;
        while((row=mysql_fetch_row(letter_grade))){
            long *lengths=mysql_fetch_lengths(letter_grade);
            // printf("%s,%d\n",row[0],strtoint(row[1],lengths[1]));
            total_credits+=strtoint(row[1],lengths[1]);
            
            if(strcmp(row[0],"AS")==0)gradepoint+=10*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"AA")==0)gradepoint+=10*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"AB")==0)gradepoint+=9*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"BB")==0)gradepoint+=8*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"BC")==0)gradepoint+=7*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"CC")==0)gradepoint+=6*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"CD")==0)gradepoint+=5*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"DD")==0)gradepoint+=4*strtoint(row[1],lengths[1]);
            else gradepoint+=0*strtoint(row[1],lengths[1]);
        }
        float spi = gradepoint/(total_credits*1.0);
        printf("SPI for sem %d is %.2f\n",i,spi);
    }
}
//task06
void compute_cpi(MYSQL *con,char roll []){
    char q[400];
    int gradepoint=0;
    int total_credits=0;
    for(char i=1;i<=8;i++){
        
        sprintf(q,"SELECT letter_grade,c FROM course18 NATURAL JOIN grade18 WHERE (semester=%c and roll_number=%s)",(char)(i+'0'),roll);
        mysql_query(con,q);
        MYSQL_RES *letter_grade = mysql_store_result(con);
        int num_fields=mysql_num_fields(letter_grade);
        MYSQL_ROW row;
        while((row=mysql_fetch_row(letter_grade))){
            long *lengths=mysql_fetch_lengths(letter_grade);
            // printf("%s,%d\n",row[0],strtoint(row[1],lengths[1]));
            total_credits+=strtoint(row[1],lengths[1]);
            
            if(strcmp(row[0],"AS")==0)gradepoint+=10*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"AA")==0)gradepoint+=10*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"AB")==0)gradepoint+=9*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"BB")==0)gradepoint+=8*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"BC")==0)gradepoint+=7*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"CC")==0)gradepoint+=6*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"CD")==0)gradepoint+=5*strtoint(row[1],lengths[1]);
            else if(strcmp(row[0],"DD")==0)gradepoint+=4*strtoint(row[1],lengths[1]);
            else gradepoint+=0*strtoint(row[1],lengths[1]);
        }
    }
    float cpi = gradepoint/(total_credits*1.0);
    printf("CPI is %.2f\n",cpi);
}
///task07
void corecourse(MYSQL *con,char roll[]){
    char q[400];
    sprintf(q,"(select cid from course18 where (semester=1))except(select cid from grade18 natural join course18 where (semester=1 and roll_number=%s));",roll);
    mysql_query(con,q);
    MYSQL_RES *course = mysql_store_result(con);
    int num_fields=mysql_num_rows(course);
    if(num_fields!=0){printf("NOT completed all core courses1");return;}
    
    sprintf(q,"(select cid from course18 where (semester=2))except(select cid from grade18 natural join course18 where (semester=2 and roll_number=%s));",roll);
    mysql_query(con,q);
    course = mysql_store_result(con);
    num_fields=mysql_num_rows(course);
    if(num_fields!=0){printf("NOT completed all core courses2");return;}
    
    sprintf(q,"(select cid from course18 where (semester=3))except(select cid from grade18 natural join course18 where (semester=3 and roll_number=%s));",roll);
    mysql_query(con,q);
    course = mysql_store_result(con);
    num_fields=mysql_num_rows(course);
    if(num_fields!=0){printf("NOT completed all core course3");return;}

    sprintf(q,"(select cid from course18 where (semester=4))except(select cid from grade18 natural join course18 where (semester=4 and roll_number=%s));",roll);
    mysql_query(con,q);
    course = mysql_store_result(con);
    num_fields=mysql_num_rows(course);
    MYSQL_ROW row;
    while((row=mysql_fetch_row(course))){
        long *lengths=mysql_fetch_lengths(course);
        if(row[0][lengths[0]-1]!='M'){printf("NOT completed all core courses4");return;}
    }

    sprintf(q,"(select cid from course18 where (semester=5))except(select cid from grade18 natural join course18 where (semester=5 and roll_number=%s));",roll);
    mysql_query(con,q);
    course = mysql_store_result(con);
    num_fields=mysql_num_rows(course);
    while((row=mysql_fetch_row(course))){
        long *lengths=mysql_fetch_lengths(course);
        if(row[0][lengths[0]-2]!='M'){printf("NOT completed all core course5");return;}
    }

    sprintf(q,"(select cid from course18 where (semester=6))except(select cid from grade18 natural join course18 where (semester=6 and roll_number=%s));",roll);
    mysql_query(con,q);
    course = mysql_store_result(con);
    num_fields=mysql_num_rows(course);
    while((row=mysql_fetch_row(course))){
        long *lengths=mysql_fetch_lengths(course);
        if(row[0][lengths[0]-2]!='M'){printf("NOT completed all core courses6");return;}
    }

    sprintf(q,"select cid from grade18 natural join course18 where (semester=7 and cid=\"CS498\" and roll_number=%s)",roll);
    mysql_query(con,q);
    course = mysql_store_result(con);
    num_fields=mysql_num_rows(course);
    if(num_fields==0){printf("NOT completed all core courses7");return;}
    
    sprintf(q,"select cid from grade18 natural join course18 where (semester=8 and cid=\"CS499\" and roll_number=%s)",roll);
    mysql_query(con,q);
    course = mysql_store_result(con);
    num_fields=mysql_num_rows(course);
    if(num_fields==0){printf("NOT completed all core courses8");return;}
    printf("Completed all core courses\n");
    
}
// task08

int main(int argc, char **argv){
// task01
    MYSQL *con;
    con = mysql_init(NULL);
    mysql_real_connect(con, "localhost", "root", "root@123",NULL, 0, NULL, 0);
    mysql_query(con, "DROP DATABASE IF EXISTS week10");
    mysql_query(con,"CREATE DATABASE week10");
    mysql_query(con,"USE week10");
// task02
    mysql_query(con, "CREATE TABLE student18(name char(100),roll_number char(10) primary key)");
    mysql_query(con, "CREATE TABLE course18(semester int,cid char(7) primary key,name char(100),l int,t int,p int,c int)");
    mysql_query(con, "CREATE TABLE grade18(roll_number char(10),cid char(7), letter_grade char(2),primary key(roll_number,cid))");
    mysql_query(con, "CREATE TABLE curriculum(dept char(3),number int, cid char(7))");
// task03
    FILE *f1 = fopen("./database/student18.csv", "r");
    int i = 0;
    int sem,l,t,p,c,number;
    char roll[15],name[105],cid[15],letter_grade[3],dept[5];
    char q[400];
    while (i < 158)
    {
        fscanf(f1, "%105[^,],%15[^\n]\n", name, roll);
        sprintf(q,"INSERT INTO student18 VALUES (\"%s\",\"%s\")",name,roll);
        mysql_query(con,q);
        i++;
    }
    f1 = fopen("./database/course18.csv", "r");
    i = 0;
    while (i < 63)
    {
        fscanf(f1, "%d,%15[^,],%105[^,],%d,%d,%d,%d\n",&sem,cid,name,&l,&t,&p,&c);
        sprintf(q,"INSERT INTO course18 VALUES (\"%d\",\"%s\",\"%s\",\"%d\",\"%d\",\"%d\",\"%d\")",sem,cid,name,l,t,p,c);
        mysql_query(con,q);
        i++;
    }
    f1 = fopen("./database/grade18.csv", "r");
    i = 0;
    while (i < 9954)
    {
        fscanf(f1, "%15[^,],%15[^,],%15[^\n]\n",roll,cid,letter_grade);
        sprintf(q,"INSERT INTO grade18 VALUES (\"%s\",\"%s\",\"%s\")",roll,cid,letter_grade);       
        mysql_query(con,q);
        i++;
    }
    f1 = fopen("./database/curriculum.csv", "r");
    i = 0;
    while (i < 68)
    {
        fscanf(f1, "%5[^,],%d,%15[^\n]\n",dept,&number,cid);
        sprintf(q,"INSERT INTO curriculum VALUES (\"%s\",\"%d\",\"%s\")",dept,number,cid);       
        mysql_query(con,q);
        i++;
    }
// task04
    MYSQL_RES *student_res_set;
    mysql_query(con,"SELECT * FROM student18");
    student_res_set = mysql_store_result(con);
    MYSQL_ROW row;
    int num_fields=mysql_num_fields(student_res_set);
    while((row=mysql_fetch_row(student_res_set))){
        long *lengths=mysql_fetch_lengths(student_res_set);
        for(int i=0;i<num_fields;i++){
            printf("[%.*s] ",(int) lengths[i],row[i]?row[i]:"NULL");
        }
        printf("\n");
    }
    mysql_free_result(student_res_set);

    MYSQL_RES *course_res_set;
    mysql_query(con,"SELECT * FROM course18");
    course_res_set = mysql_store_result(con);
    num_fields=mysql_num_fields(course_res_set);
    while((row=mysql_fetch_row(course_res_set))){
        long *lengths=mysql_fetch_lengths(course_res_set);
        for(int i=0;i<num_fields;i++){
            printf("[%.*s] ",(int) lengths[i],row[i]?row[i]:"NULL");
        }
        printf("\n");
    }
    mysql_free_result(course_res_set);

    MYSQL_RES *grade_res_set;
    mysql_query(con,"SELECT * FROM grade18");
    grade_res_set = mysql_store_result(con);
    num_fields=mysql_num_fields(grade_res_set);
    while((row=mysql_fetch_row(grade_res_set))){
        long *lengths=mysql_fetch_lengths(grade_res_set);
        for(int i=0;i<num_fields;i++){
            printf("[%.*s] ",(int) lengths[i],row[i]?row[i]:"NULL");
        }
        printf("\n");
    }
    mysql_free_result(grade_res_set);

    MYSQL_RES *curriculum_res_set;
    mysql_query(con,"SELECT * FROM curriculum");
    curriculum_res_set = mysql_store_result(con);
    num_fields=mysql_num_fields(curriculum_res_set);
    while((row=mysql_fetch_row(curriculum_res_set))){
        long *lengths=mysql_fetch_lengths(curriculum_res_set);
        for(int i=0;i<num_fields;i++){
            printf("[%.*s] ",(int) lengths[i],row[i]?row[i]:"NULL");
        }
        printf("\n");
    }
    mysql_free_result(curriculum_res_set);
    mysql_close(con);
    exit(0);
}
