-- task1
create database week13;

use week13;

-- task2
create table employees(
eid int,
ename char(50),
dept char(50),
salary decimal(10,0),
gender char(1) check (gender in ('M','F')),
primary key(eid)
);
-- inserted through c code

create table languages(
ename char(50),
speaks char(50),
primary key(ename,speaks)
);
-- inserted through c code

-- task3
select dept, count(*) as num
from employees
group by dept
having num <= all(select count(*)
                  from employees
                  group by dept);
			
with min_emp as(
select dept,count(*) as num,rank() over (order by (count(*))) as e_rank
from employees
group by dept)
select dept,num
from min_emp
where e_rank=1;

-- task4
select ename, count(*) as num
from languages
group by ename
having num >= all(select count(*)
                  from languages
                  group by ename);
                  
with max_lang as(
select ename,count(*) as num,rank() over (order by (count(*))desc) as l_rank
from languages
group by ename)
select ename, num
from max_lang
where l_rank=1;

-- task5
select gender, avg(salary) as avg_Sal
from employees
group by gender
having avg_Sal >= all(select avg(salary)
                  from employees
                  group by gender);
    
with max_avgsal as(
select gender,avg(salary) as avg_Sal,dense_rank() over (order by (avg(salary))desc) as s_rank
from employees
group by gender)
select gender, avg_Sal
from max_avgsal
where s_rank=1;

-- task6
with max_sal as(
select ename,salary,rank() over (order by (salary) desc) as m_rank
from employees
where dept = 'Marketing')
select ename,salary
from max_sal
where m_rank<=2;

with max_sal as(
select ename,gender,salary,rank() over (partition by gender order by (salary) desc) as m_rank
from employees)
select ename,gender,salary
from max_sal
where m_rank=1;

-- task7
create table students(
sid int,
sname char(50),
marks int,
gender char(6) check(gender in('Male', 'Female')),
department char(11) check(department in ('CSE', 'Mathematics')),
primary key(sid)
);
-- inserted using c code

-- task8
-- 1.
select sid,marks,rank() over (order by (marks) desc) as m_rank
from students;

-- 2.
select sid,department,marks,rank() over (partition by department order by (marks) desc) as m_rank
from students;

-- 3
select sid,gender,marks,rank() over (partition by gender order by (marks) desc) as m_rank
from students;

-- 4
select sid,department,gender,rank() over (partition by department,gender order by (marks) desc) as m_rank
from students;

-- 5
select sid,department,gender,marks,rank() over (order by (marks) desc) as m_rank,dense_rank() over (order by (marks) desc) as d_rank
from students;
 
-- 6
 with max_marks as(
select sname,marks,first_value(marks) over (order by (marks)desc) as fv
from students)
select sname, marks
from max_marks
where marks=fv;

with max_marks as(
select sname,marks,nth_value(marks,200) over (order by (marks)desc) as nv
from students)
select sname, marks
from max_marks
where marks=nv;

with max_marks as(
select sname,marks,last_value(marks) over (order by (marks) desc rows between unbounded preceding and unbounded following ) as lv
from students)
select sname, marks
from max_marks
where marks=lv;

-- 7
select sname,marks,
lag (marks) over (order by (marks) desc) as prev,
lead (marks) over (order by (marks) desc) as next
from students;







