-- Task01
CREATE DATABASE week07;
USE week07;

-- Task 02
create table T01(
	a int primary key,
    b int unique not null,
    c int unique not null,
    d int unique not null,
    e char(20) unique not null
);
-- sources the task02.sql file using insert-test2.c file and it had some primary key errors and duplicate entries for unique elements

-- Task 03
create table T02(
	c1 int primary key,
    c2 char(20) not null,
    c3 int not null
);
-- sources the task03.sql file using insert-test3.c file and it had some primary key errors

-- Task 04
select a,b,c,d,e from T01;
-- columns a,b,c,d,e of T01 shown in order
select a,b,c,d from T01;
-- first 4 columns of T01 shown in order
select c,d,e from T01;
-- last 3 columns of T01 shown in order
select a,c,e from T01;
-- columns a,c,e of T01 shown in order
select e,d,c,b,a from T01;
-- columns of T01 shown in reverse
select a,a+10,b,b-20,c,c*30,d,d/40,e from T01;
-- columns of T01 shown before and after performing arithmetic operations on columns 
select * from T01;
-- all columns listed without naming a,b,c,d,e 
select a,b,c,d,e from T01 order by e asc;
-- all rows of T01 listed after sorting e in ascending order
select a,b,c,d,e from T01 order by e desc;
-- all rows of T01 listed after sorting e in descending order

-- Task 05
select * from T01 where a = 82941;
-- retrieves the rows and all columns of table T01 such that column a is equal to 82941
select a,b,c,d from T01 where a <> 82941;
-- retrieves first 4 rows columns that a != 82941
select c,d,e from T01 where a > 84921;
-- last 3 columns of T01 such that a>82941
select a,c,e from T01 where a >= 84921;
-- columns a,c,e of T01 where  column a is greater than or equal to 84921
select e,d,c,b,a from T01 where a < 84921;
-- columns of T01 shown in reverse and column a is less than 84921
select e,d,c,b,a from T01 where a <= 84921;
-- columns of T01 shown in reverse and column a is less than or equal to 84921
select e,d,c,b,a from T01 where a between 80000 and 84921;
-- columns of T01 shown in reverse and column a is between 80000 and 84921
select a,a+10,b,b-20,c,c*30,d,d/40,e from T01
	where a+10 between 80000 and 84921 
    and b-20<>84921 
    and c*30>40000 
    and d/40<65000;
select * from T01 
	where a between 0 and 50000
    and b>50000;
select * from T01 
	where a between 0 and 50000
    and b>50000
    order by e asc;
select * from T01 
	where a between 0 and 50000
    and b>50000
    order by e asc, b desc;

-- Task 06
select e from T01 where e like 'lo%';
-- retrieves the rows and column e of table T01 such that column e starts with lo
select e from T01 where e like '%ing';
-- retrieves the rows and column e of table T01 such that column e ends with ing
select e from T01 where e like '____';
-- retrieves the rows and column e of table T01 such that column e contains exactly four characters
select e from T01 where e like '__i_';
-- retrieves the rows and column e of table T01 such that column e contains exactly four characters of which third character is i
select e from T01 where e like '_i_h' or e like  '_i_l';
-- retrieves the rows and column e of table T01 such that column e contains exactly four characters of which second character is i and fourth character is h or l
select e from T01 
	where e not like '__i_' and
    e like '____' ;
-- retrieves the rows and column e of table T01 such that column e contains exactly four characters of which third character is not i
select e from T01 where e like '%_______%';
-- retrieves the rows and column e of table T01 such that column e more than six characters

-- Task 07
select a,b from T01 where a>50000 
	union
select c1,c3 from T02 where c2 like 'e%';
-- 134 rows

select c1,c2,c3 from T02 where 
	c1 in (select a from T01)
    and c2 in (select e from T01)
    and c3 in (select c from T01);
-- 75 rows
    
select c1,c2,c3 from T02 where 
	c1 not in (select a from T01)
    or c2 not in (select e from T01)
    or c3 not in (select c from T01);
-- 389 rows

