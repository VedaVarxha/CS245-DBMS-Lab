/**************** Task 01 *******************/
create database week5;
use week5;


/***************** Task 02 ******************/
create table T1(
    sname char(20),
    roll int,
    cpi float
);

insert into T1
    values ('student 01',270101001, 9.8);
insert into T1
    values ('student 02', 270101002, 8.9);
insert into T1
    values ('student 03', 270101003, 7.6);
update T1 set cpi = 8.1 where sname = 'student 03';
delete from T1 where sname = 'student 02';
select * from T1;


/************* Task 03 *************************/
create table T2(
    sname char(20),
    roll int,
    cpi float,
    primary key (roll)
);

insert into T2
    values ('student 01',270101001, 9.8);
insert into T2
    values ('student 01', 270101002, 8.9);
insert into T2
    values ('student 02', 270101001, 7.6);
/*gives error because roll number is the same (duplicate entry) */
update T2 set roll = 270101002 where sname = 'student 01';
/*gives error since same roll number which cannot be given to primary key*/
delete from T2 where sname = 'student 02';
/*doesnt effect any row*/
select * from T2;


/***************** Task 04 *********************/
create table T3(
    sname char(20) NOT NULL,
    roll int,
    cpi float,
    unique key (roll)
);

insert into T3 
	values (NULL, 270101001, 9.8);
/* gives error as student name cannot be null */
insert into T3 
	values ('student 02', 270101002, 8.9);
insert into T3 
	values ('student 03', 270101002, 7.6);
/* gives error as roll number has duplicate entry */
update T3 set sname = NULL;
/* throws error as student name cannot be null */
delete from T3 where sname = 'student 02';
select * from T3;
	
	
/***************** Task 05 *********************/
create table T4(
    sname char(20),
    roll int,
    cpi float default 0.0,
    primary key(roll)
);

insert into T4(sname, roll)
	values(NULL, 270101001);
insert into T4
	values(NULL, 270101002, 8.9);
insert into T4
	values('student 03', 270101002, -7.6);
/*error due to duplicate entry*/
insert into T4
	values('student 03', 270101003, 8.2);
insert into T4(sname, roll)
	values('student 03', 270101004);
select * from T4;


/***************** Task 06 *************************/
create table T5(
    sname char(20) NOT NULL,
    roll int,
    cpi float default 0.0,
    primary key(roll)
);

insert into T5(sname, roll)
	values(NULL, 270101001);
/* gives error as student name cannot be null */
insert into T5
	values('student 01', 270101001, 9.6);
insert into T5
	values('student 02', 270101002, 8.2);
insert into T5
	values('student 02', 270101003, 7.6);
insert into T5
	values('student 03', 270101003, 7.2);
/*error due to duplicate entry*/
insert into T5(sname, roll)
	values('student 04', 270101004);
select * from T5;


/************************ Task 07 **********************/
create table T6(
    sname char(20) ,
    roll int,
    cpi float
);

insert into T6
	values('student 01', 270101001, 9.6);
insert into T6
	values('student 02', 270101001, 9.4);
insert into T6
	values('student 03', 270101001, 9.2);
alter table T6 modify roll int primary key;
/*roll number cannot be set as primary key due to presence of duplicate entries*/
alter table T6 add sem int default 1;
insert into T6
	values('student 03', 270101002, 9.2, 3);
insert into T6(sname, roll, cpi)
	values('student 03', 270101001, 9.2);
alter table T6 drop roll;
select * from T6;
