#include <stdio.h>
#include <stdbool.h>
#include <string.h>


void str_replace(char *shot, const char *point, const char *replace)
{
    char buffer[1024] = { 0 };
    char *insert_point = &buffer[0];
    const char *tmp = shot;
    size_t point_len = strlen(point);
    size_t repl_len = strlen(replace);

    while (1) {
        const char *p = strstr(tmp, point);

        if (p == NULL) {
            strcpy(insert_point, tmp);
            break;
        }

        memcpy(insert_point, tmp, p - tmp);
        insert_point += p - tmp;

        memcpy(insert_point, replace, repl_len);
        insert_point += repl_len;

        tmp = p + point_len;
    }

    strcpy(shot, buffer);
}


typedef struct  date{
   int day;
   int month;
   int year;
} date;

void  swap(date *a, date  *b)
{
    date temp = *a;
    *a = *b;
    *b = temp;
    
}

int compareDates(date date1, date date2) {
    

    if (date1.year < date2.year) return -1;
    if (date1.year > date2.year) return 1;

    if (date1.month < date2.month) return -1;
    if (date1.month > date2.month) return 1;

    if (date1.day < date2.day) return -1;
    if (date1.day > date2.day) return 1;


    return 0; 
}

void sortAscendingOrder(date steps[10],int start,int end) {
    int i, j;
    int n = end - start + 1;

    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (compareDates(steps[start + j],steps[start + j + 1])>=0) {
                swap(&steps[start + j], &steps[start + j + 1]);
            }
        }
    }    
}

void sortDescendingOrder(date steps[10],int start,int end) {
    int i, j;
    int n = end - start + 1;

    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (compareDates(steps[start + j],steps[start + j + 1])<=0) {
                swap(&steps[start + j], &steps[start + j + 1]);
            }
        }
    }    
}



typedef struct product{
    char id[100];
    date steps[10];
    char region[10];

}product;

const char *months[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

int main()
{
    FILE* inp,*temp,*out;
    inp=fopen("week02.csv","r");
    temp=fopen("temp.txt","w");

    char str[1000];
    fscanf(inp,"%s",str);
    for(int i=0;i<15933;i++)
    {
        fscanf(inp,"%s",str);
        for(int i=0;i<strlen(str);i++)
        {
            if(str[i]==','||str[i]=='-')
            {
                str[i]=' ';
            }
            str_replace(str,"Jan","1");
            str_replace(str,"Feb","2");
            str_replace(str,"Mar","3");
            str_replace(str,"Apr","4");
            str_replace(str,"May","5");
            str_replace(str,"Jun","6");
            str_replace(str,"Jul","7");
            str_replace(str,"Aug","8");
            str_replace(str,"Sep","9");
            str_replace(str,"Oct","10");
            str_replace(str,"Nov","11");
            str_replace(str,"Dec","12");

        }
       
        fprintf(temp,"%s \n",str);
    }
    fclose(temp);
  


    //FILE* inp,*out;
    inp=fopen("temp.txt","r");
    out=fopen("out.txt","w");
    product list;
   for(int i=0;i<15933;i++)
    {
        fscanf(inp,"%s %d %d %d  %d %d %d  %d %d %d  %d %d %d  %d %d %d  %d %d %d  %d %d %d  %d %d %d  %d %d %d  %d %d %d %s",list.id,
      &list.steps[0].day,&list.steps[0].month,&list.steps[0].year,&list.steps[1].day,&list.steps[1].month,&list.steps[1].year,
       &list.steps[2].day,&list.steps[2].month,&list.steps[2].year,&list.steps[3].day,&list.steps[3].month,&list.steps[3].year,
       &list.steps[4].day,&list.steps[4].month,&list.steps[4].year,&list.steps[5].day,&list.steps[5].month,&list.steps[5].year,
       &list.steps[6].day,&list.steps[6].month,&list.steps[6].year,&list.steps[7].day,&list.steps[7].month,&list.steps[7].year,
       &list.steps[8].day,&list.steps[8].month,&list.steps[8].year,&list.steps[9].day,&list.steps[9].month,&list.steps[9].year,
       list.region
         );
         if (strcmp(list.region, "North") == 0) {
        sortAscendingOrder(list.steps,0,9);
    } else if (strcmp(list.region, "South") == 0) {
        sortDescendingOrder(list.steps,0,9);
    } else if (strcmp(list.region, "East") == 0) {
        //sortAscendingOrder(list.steps,0,5);
        //sortDescendingOrder(list.steps,4,9);
        sortDescendingOrder(list.steps,0,9);
        if(compareDates(list.steps[4], list.steps[5]) != 0){
        sortAscendingOrder(list.steps,0,4);}
        else{
        for(int i=0; i<5; i++){
        if(compareDates(list.steps[4+i], list.steps[5+i]) != 0){
        sortAscendingOrder(list.steps,0,4-i); break;}
        }}
        sortDescendingOrder(list.steps,5,9);
    } else if (strcmp(list.region, "West") == 0) {
        //sortDescendingOrder(list.steps,0,4);
        //sortAscendingOrder(list.steps,4,9);
        sortDescendingOrder(list.steps,0,9);
        //sortAscendingOrder(list.steps,5,9);
        if(compareDates(list.steps[4], list.steps[5]) != 0){
        sortAscendingOrder(list.steps,5,9);}
        else{
        for(int i=0; i<5; i++){
        if(compareDates(list.steps[4+i], list.steps[5+i]) != 0){
        sortAscendingOrder(list.steps,5+i,9); break;}
        }}
    }
         fprintf(out,"%s\n",list.id);
         for(int j=0;j<=9;j++) fprintf(out,"%d-%s-%d\n",list.steps[j].day,months[list.steps[j].month-1],list.steps[j].year);
         fprintf(out,"%s\n",list.region);
    }

    
}















