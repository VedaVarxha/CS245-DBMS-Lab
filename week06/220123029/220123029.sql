create database week06;
use week06;

create table T01(
a int,
b int,
c int unique not NULL,
d int unique not NULL,
e int,
primary key(a,b)
);
-- sources the task02.sql file using my c file and it had some primary key errors

create table T02(
f int,a int,b int,
primary key(f),
foreign key(a,b) references T01(a,b)
);

-- sources the task03.sql file using my c file and it had some foreign key errors

create table T03(
h int,i int, f int,
primary key(h),
foreign key(f) references T02(f)
);
-- sources the task04.sql file using my c file and have some primary key and foreign key errors

create table T04(
k int,h int,
primary key(k),
foreign key(h) references T03(h)
);
-- sources the task05.sql file using my c file  cannot be done because the entries givn are of k,h but the table has h,i as the 
-- task 05 told us to add in T03
delete from T01;
delete from T02;
delete from T03;
delete from T04;
-- we cannot delete in this order because the colums of the table is used in other table so we have to first delete the second table then first table so
--  we have to delete in reverse order
delete from T04;
delete from T03;
delete from T02;
delete from T01;
-- 15:55:42	delete from T04	9 row(s) affected	0.0038 sec
-- 15:55:46	delete from T03	49 row(s) affected	0.0061 sec
-- 15:55:49	delete from T02	295 row(s) affected	0.0081 sec
-- 15:55:51	delete from T01	503 row(s) affected	0.010 sec

-- now we also have to drop table in reverse order same reason as for delete

drop table T04;
drop table T03;
drop table T02;
drop table T01;

create table T01a(
a int,
b int,
c int unique not NULL,
d int unique not NULL,
e int,
primary key(a,b)
);
-- sources the task02.sql file using my c file

create table T02a(
f int,a int,b int,
primary key(f),
foreign key(a,b) references T01a(a,b) on delete cascade
);

delete from T01a
where a=297 and b=77408;
delete from T01a
where a=606 and b=48191;
delete from T01a
where a=1071 and b=47061;
delete from T01a
where a=1080 and b=48533;
delete from T01a
where a=2268 and b=21577;
delete from T01a
where a=3130 and b=79583;
delete from T01a
where a=3613 and b=84692;
delete from T01a
where a=3713 and b=19837;
delete from T01a
where a=3720 and b=49661;
delete from T01a
where a=4036 and b=38648;

select * from T02a
where a=297 and b=77408;
select * from T02a
where a=606 and b=48191;
select * from T02a
where a=1071 and b=47061;
select * from T02a
where a=1080 and b=48533;
select * from T02a
where a=2268 and b=21577;
select * from T02a
where a=3130 and b=79583;
select * from T02a
where a=3613 and b=84692;
select * from T02a
where a=3713 and b=19837;
select * from T02a
where a=3720 and b=49661;
select * from T02a
where a=4036 and b=38648;

create table T01b(
a int,
b int,
c int unique not NULL,
d int unique not NULL,
e int,
primary key(a,b)
);
create table T02b(
f int,a int,b int,
primary key(f),
foreign key(a,b) references T01a(a,b) on update cascade
);

create table T01c(
a int,
b int,
c int unique not NULL,
d int unique not NULL,
e int,
primary key(a,b)
);
create table T02c(
f int,a int,b int,
primary key(f),
foreign key(a,b) references T01a(a,b) on update cascade on delete cascade
);
delete from T02c;
delete from T02b;
delete from T02a;
delete from T01a;
delete from T01b;
delete from T01c;

drop table T02c;
drop table T02b;
drop table T02a;
drop table T01a;
drop table T01b;
drop table T01c;

-- 11 Circular foreign key constraints
create table T01d(
	a int, b int, c int,
    primary key(a)
);

create table T02d(
	d int, e int,
    primary key(e)
);

alter table T01d add foreign key(b) references T02d(e);
alter table T02d add foreign key(d) references T01d(a);
delete from T01d;
delete from T02d;
-- cannot drop the tables in circular foreign key constraint but only delete in any order
-- to drop tables, first drop the foreign key then the tables in order of oldest first
SET foreign_key_checks = 0;
drop table T01d;
drop table T02d;

-- alter table T01d drop constraint <foreign key name>;
-- SELECT name FROM sys.foreign_keys;
-- alter table T01d drop foreign key 'T01d_ibfk_1';
