create database week08;
use week08;

create table student(
	roll int,
    nam varchar(20) not null,
    program varchar(20),
    primary key(roll),
    check(program in ("Certificate","Diploma","Degree","Honors"))
);

create table course(
	cid char(5),
    cname varchar(100),
    primary key(cid)
);


create table concept(
	cid char(5),
    qn char(5),
    descript varchar(100),
    primary key(cid,qn),
    foreign key(cid) references week08.course(cid)
);

create table marks(
	roll int,
    cid char(5),
    set1 char(5),
    set1_marks int,
    set2 char(5),
    set2_marks int,
    primary key(roll,cid,set1),
    foreign key(roll) references week08.student(roll),
    foreign key(cid) references week08.course(cid)
);

-- 1
select nam,cid,set1,set1_marks,set2,set2_marks
from student natural join marks;


-- 2
select roll,cname,set1,set1_marks,set2,set2_marks
from marks natural join course;

-- 3
select nam,cname,set1,set1_marks,set2,set2_marks
from marks natural join course natural join student;


-- 4
select nam,marks.cid,set1,A.descript,set1_marks,set2,B.descript,set2_marks
from student natural join marks,concept as A,concept as B
where set1=A.qn and set2=B.qn;

-- 5
select roll,cname,set1,A.descript,set1_marks,set2,B.descript,set2_marks
from marks natural join course,concept as A,concept as B
where set1=A.qn and set2=B.qn;

-- 6
select distinct nam
from student natural join course natural join marks
where cname = "Introduction to Data Science" and nam in (select nam from student natural join course natural join marks where cname = "Computer System Tools");

-- 7
select distinct nam
from student natural join course natural join marks
where cname = "Introduction to Data Science" and nam not in (select nam from student natural join course natural join marks where cname = "Python Programming");

-- 8
select distinct roll
from student natural join course natural join marks
where cname = "Linear Algebra" and roll in (select roll from student natural join course natural join marks where cname = "Python Programming" and roll in (select roll from student natural join course natural join marks where cname = "Computer System Tools"));

-- 9
select distinct roll
from student natural join course natural join marks
where cname = "Linear Algebra" and roll not in (select roll from student natural join course natural join marks where cname = "Python Programming" or roll in (select roll from student natural join course natural join marks where cname = "Computer System Tools"));
                           
-- 10
select distinct roll
from student natural join course natural join marks
where cname = "Linear Algebra" and roll in (select roll from student natural join course natural join marks where cname = "Python Programming" and roll in (select roll from student natural join course natural join marks where cname = "Computer System Tools" and roll in (select roll from student natural join course natural join marks where cname = "Introduction to Data Science")));

-- 11
select distinct roll
from student natural join course natural join marks
where roll not in (select distinct roll from student natural join course natural join marks where cname = "Linear Algebra" and roll in (select roll from student natural join course natural join marks where cname = "Python Programming" and roll in (select roll from student natural join course natural join marks where cname = "Computer System Tools" and roll in (select roll from student natural join course natural join marks where cname = "Introduction to Data Science"))));

-- 12
select avg(set1_marks) from marks natural join concept where cid="DA105" and qn="q01s1";
-- 13
select avg(set2_marks) from marks natural join concept where cid="DA106" and qn="q01s2";
-- 14
select avg(set1_marks) from marks natural join concept where cid="DA107" and qn="q01s1";
-- 15
select avg(set2_marks) from marks natural join concept where cid="DA108" and qn="q01s2";
-- 16
select count(distinct roll) from marks natural join concept where cid="DA107" and qn="q01s1" and set1_marks between 0 and 5;

-- 17
select distinct nam 
from student natural join marks
where set1_marks = (select max(set1_marks) from marks where cid="DA107" and set1="q07s1");

-- 18
select distinct roll 
from marks
where set2_marks = (select max(set2_marks) from marks natural join student where cid="DA107" and set2="q02s2" and program="Diploma");

-- 19
select distinct roll 
from marks
where set1_marks+set2_marks = (select max(set1_marks+set2_marks) from marks natural join student where cid="DA107" and program="Honors");

-- 20
select distinct roll 
from marks
where set1_marks+set2_marks = (select max(set1_marks+set2_marks) from marks natural join student natural join concept where cid="DA107" and descript="OS" and program="Honors");

-- 21
select roll_number,name,cid,cname,sum(set1_marks),sum(set2_marks)
from student natural join marks natural join course
group by roll_number,cid,cname;

-- 22
select roll_number,name,cid,cname,sum(set1_marks),sum(set2_marks)
from student natural join marks natural join course
where Program="Degree"
group by roll_number,cid,cname;

-- 23
select count(distinct(roll_number))
from student
group by Program; 

-- 24
select avg(set1_marks) from marks natural join student natural join concept where cid="DA105" and qn="q01s1" and program="Certificate";

-- 25
select avg(set1_marks) from marks natural join student natural join concept where cid="DA108" and qn="q12s1" and program="Certificate";

-- 26
select sum(set1_marks),sum(set2_marks),sum(set1_marks)+sum(set2_marks)
from marks
where cid="DA105" and roll="270101636";

-- 27
select sum(set1_marks),sum(set2_marks),sum(set1_marks)+sum(set2_marks)
from marks
where cid="DA106" and roll="270101636";

-- 28
select sum(set1_marks),sum(set2_marks),sum(set1_marks)+sum(set2_marks)
from marks
where cid="DA107" and roll="270101636";

-- 29
select sum(set1_marks),sum(set2_marks),sum(set1_marks)+sum(set2_marks)
from marks
where cid="DA108" and roll="270101636";

