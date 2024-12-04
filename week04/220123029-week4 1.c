
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

int NUMBER = 120; //number of students

// Struct to store curriculum
typedef struct Course {
    char courseCode[10];
    int semester;
    int credits;
} Course;

//Struct to store grades
typedef struct CourseGrades {
    Course course;
    char grade[2];
    bool isPassed;
} CourseGrades;

//Struct to store no-dues
typedef struct NoDues
{
    int rollNumber;
    bool hostel;
    bool department;
    bool NCC;
    bool COS;
    bool NSO;
    bool institute;
} NoDues;

//Struct to store DA
typedef struct DisciplinaryAction
{
    int rollNumber;
    bool disciplinary;
} DisciplinaryAction;


// Struct to store student details
typedef struct Student {
    int rollNumber;
    char name[50];
    CourseGrades grades[100];
    int numberOfCourses;
    int numberOfCredits;
} Student;

Course findCourse(char code[], Course courses[]){
    int size = 63;
    for(int i = 0; i<size; i++){
        if(strcmp(code,courses[i].courseCode) == 0){
            return courses[i];
        }
    }
}

int findStudent(int roll, Student students[]){
    int size = NUMBER;
    for(int i = 0; i<size; i++){
        if (students[i].rollNumber == roll) return i;
    }
}

NoDues findDues(int roll, NoDues noDues[]){
    int size = NUMBER;
    for(int i = 0; i<size; i++){
        if (noDues[i].rollNumber == roll) return noDues[i];
    }
}

DisciplinaryAction findDa(int roll, DisciplinaryAction da[]){
    int size = NUMBER;
    for(int i = 0; i<size; i++){
        if (da[i].rollNumber == roll) return da[i];
    }
}

int findGrade(Student student, char coursecode[]){
    for(int i =0; i< student.numberOfCourses; i++){
        if(strcmp(coursecode,student.grades[i].course.courseCode) == 0){
            return i;
        }
    }
    return -1;
}

bool duesCheck(NoDues noDue, bool isEligible, Student student){
    if (noDue.hostel == false){
        if (isEligible){
            isEligible = false;
            printf("%d Not Eligible\n", student.rollNumber);
        }
        printf("\t-No Dues requirement violation (hostel)\n");
    }
    if (noDue.institute == false){
        if (isEligible){
            isEligible = false;
            printf("%d Not Eligible\n", student.rollNumber);
        }
        printf("\t-No Dues requirement violation (institute)\n");
    }
    if (noDue.department == false){
        if (isEligible){
            isEligible = false;
            printf("%d Not Eligible\n", student.rollNumber);
        }
        printf("\t-No Dues requirement violation (department)\n");
    }
    if (noDue.COS == false){
        if (isEligible){
            isEligible = false;
            printf("%d Not Eligible\n", student.rollNumber);
        }
        printf("\t-No Dues requirement violation (COS)\n");
    }
    if (noDue.NSO == false){
        if (isEligible){
            isEligible = false;
            printf("%d Not Eligible\n", student.rollNumber);
        }
        printf("\t-No Dues requirement violation (NSO)\n");
    }
    if (noDue.NCC == false){
        if (isEligible){
            isEligible = false;
            printf("%d Not Eligible\n", student.rollNumber);
        }
        printf("\t-No Dues requirement violation (NCC)\n");
    }
    return isEligible;
}

bool coursesCheck(Student student, bool isEligible){
    for(int i = 0; i < student.numberOfCourses; i++){
        CourseGrades courseGrade = student.grades[i];
        if(courseGrade.isPassed == false){
            if (isEligible){
                isEligible = false;
                printf("%d Not Eligible\n", student.rollNumber);
            }
            Course course = courseGrade.course;
            if(course.courseCode[0] == 'H'){
                printf("\t-HSS Course (%s) requirement violation\n",course.courseCode);
            }
            else if (course.courseCode[0] == 'S'){
                printf("\t-SA Course (%s) requirement violation\n",course.courseCode);
            }
            else if (course.courseCode[0] == 'C' && course.courseCode[2]>='5'){
                printf("\t-Elective Course (%s) requirement violation\n",course.courseCode);
            }
            else if (course.semester <=5 || 
            (course.semester == 6 && course.courseCode[2] < '5') ||
            strcmp(course.courseCode,"CS488") == 0 ||
            strcmp(course.courseCode,"CS489") == 0
            ){
                printf("\t-Core Course (%s) requirement violation\n",course.courseCode);
            }
            
        }

    }
    return isEligible;
}

void eligibilityCheck(Student student, NoDues noDue, DisciplinaryAction da){
    bool isEligible = true;

    if (student.numberOfCredits<315){
        if (isEligible){
            isEligible = false;
            printf("%d Not Eligible\n", student.rollNumber);
        }
        printf("\t-Total mandatory credits requirement violation\n");
    }
    isEligible = duesCheck(noDue,isEligible,student);
    if (da.disciplinary == true){
        if (isEligible){
            isEligible = false;
            printf("%d Not Eligible\n", student.rollNumber);
        }
        printf("\t-Disciplinary requirement violation\n");
    }
    isEligible = coursesCheck(student, isEligible);
    if (isEligible){
        printf("%d Eligible\n", student.rollNumber);
    }
}


int main(int argc, char *argv[]) {

    FILE *filePointer1, *filePointer2, *filePointer3, *filePointer4,  *filePointer5;
    filePointer1 = fopen("students.csv", "r");
    filePointer2 = fopen("curriculum.csv", "r");
    filePointer3 = fopen("grade.csv", "r");
    filePointer4 = fopen("no-dues.csv", "r");
    filePointer5 = fopen("disciplinary.csv", "r");
    Student students[NUMBER];
    NoDues noDues[NUMBER];
    DisciplinaryAction da[NUMBER];
    Course courses[63];
    int i;
    char temp[100];

    // populate students
    fgets(temp, 100, filePointer1);
    for(i = 0; i<NUMBER; i++){
        char c[100];
        fgets(c, 100, filePointer1);
        char *token = strtok(c, ",");
        students[i].rollNumber = atoi(token);
        token = strtok(NULL, ",");
        strcpy(students[i].name, token);
        students[i].numberOfCourses = 0;
        students[i].numberOfCredits = 0;
    }

    fgets(temp, 100, filePointer2);
    for(i = 0; i<63; i++){
        char c[100];
        fgets(c, 100, filePointer2);
        char *token = strtok(c, ",");
        strcpy(courses[i].courseCode,token);
        token = strtok(NULL,",");
        courses[i].credits = atoi(token);
        token = strtok(NULL,",");
        courses[i].semester = atoi(token);
    }
    
    fgets(temp, 100, filePointer3);
    for(i=0; i <7562; i++){
        char c[100];
        fgets(c, 100, filePointer3);
        char *token = strtok(c, ",");
        int rollNumber = atoi(token);
        int studnum = findStudent(rollNumber,students);
        Student student = students[studnum];
        token = strtok(NULL, ",");
        int courseindex = findGrade(student,token);
        Course course = findCourse(token,courses);
        if(courseindex != -1){
            token = strtok(NULL,",");
            if (strcmp(token,"NP") == 0 || strcmp(token,"FA") == 0 || strcmp(token,"FP") == 0){
            students[studnum].grades[courseindex].isPassed = false;
            }
            else{
                students[studnum].grades[courseindex].isPassed = true;
                students[studnum].numberOfCredits+=course.credits;
            }
            continue;
        }
        token = strtok(NULL,",");
        CourseGrades courseGrade;
        courseGrade.course = course;
        strcpy(courseGrade.grade, token);
        if (strcmp(token,"NP") == 0 || strcmp(token,"FA") == 0 || strcmp(token,"FP") == 0){
            courseGrade.isPassed = false;
        }
        else{
            courseGrade.isPassed = true;
        }
        student.grades[student.numberOfCourses++] = courseGrade;
        if(courseGrade.isPassed == true){
            student.numberOfCredits+=course.credits;
        }

        students[studnum] = student;
    }

  
    fgets(temp, 100, filePointer4);
    for(i=0; i <NUMBER; i++){
        char c[100];
        fgets(c, 100, filePointer4);
        char *token = strtok(c, ",");
        noDues[i].rollNumber = atoi(token);
        token = strtok(NULL,",");
        if (strcmp("Yes",token) == 0){
            noDues[i].hostel = true;
        }
        else{
            noDues[i].hostel = false;
        }
        token = strtok(NULL,",");
        if (strcmp("Yes",token) == 0){
            noDues[i].department = true;
        }
        else{
            noDues[i].department = false;
        }
        token = strtok(NULL,",");
        if (strcmp("Yes",token) == 0){
            noDues[i].NCC = true;
        }
        else{
            noDues[i].NCC = false;
        }
        token = strtok(NULL,",");
        if (strcmp("Yes",token) == 0){
            noDues[i].COS = true;
        }
        else{
            noDues[i].COS = false;
        }
        token = strtok(NULL,",");
        if (strcmp("Yes",token) == 0){
            noDues[i].NSO = true;
        }
        else{
            noDues[i].NSO = false;
        }
        token = strtok(NULL,",");
        token[3] = '\0';
        if (strcmp("Yes",token) == 0){
            noDues[i].institute = true;
        }
        else{
            noDues[i].institute = false;
        }
    }


    fgets(temp,100,filePointer5);
    for(int i = 0; i<NUMBER; i++){
        char c[100];
        fgets(c,100,filePointer5);
        char* token = strtok(c,",");
        da[i].rollNumber = atoi(token);
        token = strtok(NULL,",");
        token[3] = '\0';
        if (strcmp("Yes",token) == 0){
            da[i].disciplinary = true;
        }
        else{
            da[i].disciplinary = false;
        }

    }
    
 
    if (argc == 1) {
        // Perform eligibility check for all students
        for(int i = 0; i<NUMBER; i++){
            Student stud = students[i];
            NoDues noDue = findDues(stud.rollNumber, noDues);
            DisciplinaryAction action = findDa(stud.rollNumber, da);
            eligibilityCheck(stud,noDue,action);
        }
        
    }
   
    else if (argc == 2) {
        int rollNumber = atoi(argv[1]);
        // Perform eligibility check for the given roll number
        Student stud = students[findStudent(rollNumber,students)];
        NoDues noDue = findDues(stud.rollNumber, noDues);
        DisciplinaryAction action = findDa(stud.rollNumber, da);
        eligibilityCheck(stud,noDue,action);
        
    }

    else {
        // Perform eligibility check for the given roll numbers
        for (int i = 1; i < argc; i++) {
            int rollNumber = atoi(argv[i]);
            // Perform eligibility check for each roll number
            Student stud = students[findStudent(rollNumber,students)];
            NoDues noDue = findDues(stud.rollNumber, noDues);
            DisciplinaryAction action = findDa(stud.rollNumber, da);
            eligibilityCheck(stud,noDue,action);
            
        }
    }

    return 0;
}

