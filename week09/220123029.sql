-- TASK 1
CREATE DATABASE week09;
USE week09;


-- Task 2
CREATE TABLE sailors(
	sid INT,
    sname CHAR(50),
    rating INT,
    age decimal(3,1),
    PRIMARY KEY(sid)
);

CREATE TABLE boats(
	bid INT,
    bname CHAR(50),
    bcolor CHAR(50),
    PRIMARY KEY(bid)
);

CREATE TABLE reserves(
	sid INT,
	bid INT,
    day CHAR(50),
    PRIMARY KEY(sid, bid, day),
	FOREIGN KEY(sid) REFERENCES week09.sailors(sid),
    FOREIGN KEY(bid) REFERENCES week09.boats(bid)
);


-- Task 3

INSERT INTO sailors VALUE (22, "Dustin", 7, 45);
INSERT INTO sailors VALUE (29, "Brutus", 1, 33);
INSERT INTO sailors VALUE (31, "Lubber", 8, 55.5);
INSERT INTO sailors VALUE (32, "Andy", 8, 25.5);
INSERT INTO sailors VALUE (58, "Rusty", 10, 35);
INSERT INTO sailors VALUE (64, "Horatio", 7, 35);
INSERT INTO sailors VALUE (71, "Zorba", 10, 16);
INSERT INTO sailors VALUE (74, "Horatio", 9, 35);
INSERT INTO sailors VALUE (85, "Art", 3, 25.5);
INSERT INTO sailors VALUE (95, "Bob", 3, 63.5);

INSERT INTO boats VALUE (101, "Interlake", "blue");
INSERT INTO boats VALUE (102, "Interlake", "red");
INSERT INTO boats VALUE (103, "Clipper", "green");
INSERT INTO boats VALUE (104, "Marine", "red");

INSERT INTO reserves VALUE (22, 101, "1998-10-10");
INSERT INTO reserves VALUE (22, 102, "1998-10-10");
INSERT INTO reserves VALUE (22, 103, "1998-10-08");
INSERT INTO reserves VALUE (22, 104, "1998-10-07");
INSERT INTO reserves VALUE (31, 102, "1998-11-10");
INSERT INTO reserves VALUE (31, 103, "1998-11-06");
INSERT INTO reserves VALUE (31, 104, "1998-11-12");
INSERT INTO reserves VALUE (64, 101, "1998-09-05");
INSERT INTO reserves VALUE (64, 102, "1998-09-08");
INSERT INTO reserves VALUE (74, 102, "1998-09-08");



-- Task 4

-- Creating Updatable Views

-- a
create view sail as
select sid, rating from sailors;

INSERT INTO sail VALUE (91, 7);
INSERT INTO sail VALUE (92, 8);
INSERT INTO sail VALUE (93, 9);
INSERT INTO sail VALUE (94, 10);
INSERT INTO sail VALUE (22, 8); -- sid is the primary key so duplicate entry not allowed

UPDATE sail SET rating = 8 WHERE sid = 91;

DELETE FROM sail WHERE sid = 91;

-- b
create view bgreen as 
select * from boats where bcolor = "green";

INSERT INTO bgreen VALUE (205, "River Mania", "green");
INSERT INTO bgreen VALUE (206, "green-bird", "green");
INSERT INTO bgreen VALUE (207, "blue-warriors", "blue");

create view boat_green as 
select * from boats where bcolor = "green"
with check option;

INSERT INTO boat_green VALUE (207, "blue-warriors", "blue"); -- blue color is restricted

-- c
create view cros as
select sid, rating, bid, bname from sailors, boats;

INSERT INTO cros(sid, rating) VALUE (80, 8);
INSERT INTO cros(bid, bname) VALUE (105, "Lucky Lake");
UPDATE cros SET bname = "Jumper" WHERE bid = 101;
UPDATE cros SET bname = "Interlake" WHERE bid = 101;


-- Creating Views that are not updatable

-- a
create view max_rating as 
select sid, sname, rating, bid, bname from reserves natural join sailors natural join boats where rating = (select max(rating) from reserves natural join sailors natural join boats);

INSERT INTO max_rating(sid, sname, rating) VALUE (80, "Best sailor", 10); -- due to the use of max function we can't update or insert in this view

UPDATE max_rating SET sid = -9 Where sid = 74; -- due to the use of max function we can't update or insert in this view
DELETE FROM max_rating WHERE sid = 74; -- due to the use of max function we can't update, delete or insert in this view
UPDATE max_rating SET bname = "Can I get updated?" Where bid = 102; -- due to the use of max function we can't update or insert in this view

-- b 
create view drating as
select distinct rating from sailors;

INSERT INTO drating VALUE (2); -- due to the usage of distict this view is not insertable
UPDATE drating SET rating = -7 WHERE rating = 7; -- due to the usage of distict this view is not updatable
DELETE FROM drating WHERE rating = 7; -- due to the usage of distict this view is not deletable

-- c 
create view samerating as
select * from (sailors,boats) natural join reserves 
where (bid, 1) in (select bid, count(distinct rating) from reserves natural join sailors group by bid);

INSERT INTO samerating(sid, sname, rating, age) VALUE (80, "budding sailor", 10, 25); -- due to the usage of group by this view is not insertable
UPDATE samerating SET rating = 6 WHERE rating = 8; -- due to the usage of group by this view is not updatable
DELETE FROM samerating WHERE rating = 7; -- due to the usage of group by this view is not deletable

-- d 
create view sail_age as
select * from (sailors,boats) natural join reserves 
where (bid, 1) in (select bid, count(distinct rating) from reserves natural join sailors group by bid)
having age > 36;

INSERT INTO sail_age(sid, sname, rating, age) VALUE (80, "budding sailor", 10, 25); -- due to the usage of having clause this view is not insertable
UPDATE sail_age SET rating = 6 WHERE rating = 8; -- due to the usage of having clause this view is not updatable
DELETE FROM sail_age WHERE rating = 7; -- due to the usage of having clause this view is not deletable

-- e 
create view bg as
(select sid, sname, bid, bcolor from reserves natural join sailors natural join boats where bcolor = "green")
union
(select sid, sname, bid, bcolor from reserves natural join sailors natural join boats where bcolor = "blue");

INSERT INTO bg(sid, rating) VALUE (81, 9);
UPDATE bg SET sid = 9 WHERE sid = 22;
DELETE FROM bg WHERE sid = 22;
-- due to the use of union we can't update, delete or insert in this view


-- Creating views using views
create view viewrating as 
select rating from sail;

INSERT INTO viewrating VALUE (7);
INSERT INTO viewrating VALUE (8);
INSERT INTO viewrating VALUE (9);
INSERT INTO viewrating VALUE (10);
INSERT INTO viewrating VALUE (8); 
-- insertion not possible as sail does not have a default value of sid

UPDATE viewrating SET rating = 9 WHERE rating = 8;
DELETE FROM viewrating WHERE rating = 10;

create view sailboat as
select sid, bname, day from bgreen natural join reserves;

-- Effect of altering
alter table sailors
rename column rating to rting;

select * from sail;
select * from cros;
select * from max_rating;
select * from drating;
select * from samerating;
select * from sail_age;
select * from viewrating;
-- same views will be affected in all the tasks

alter table sailors
rename column rting to rating;

select * from sail;
select * from cros;
select * from max_rating;
select * from drating;
select * from samerating;
select * from sail_age;
select * from viewrating;

alter table sailors
drop column rating;

select * from sail;
select * from cros;
select * from max_rating;
select * from drating;
select * from samerating;
select * from sail_age;
select * from viewrating;


-- Type conversion
CREATE TABLE sailors_1(
	sid INT,
    sname CHAR(50),
    rating INT,
    age decimal(3,1),
    PRIMARY KEY(sid)
);

CREATE TABLE boats_1(
	bid INT,
    bname CHAR(50),
    bcolor CHAR(50),
    PRIMARY KEY(bid)
);

CREATE TABLE reserves_1(
	sid INT,
	bid INT,
    day CHAR(50),
    PRIMARY KEY(sid, bid, day),
	FOREIGN KEY(sid) REFERENCES week09.sailors_1(sid),
    FOREIGN KEY(bid) REFERENCES week09.boats_1(bid)
);

INSERT INTO sailors_1 VALUE (22, "Dustin", 7, 45);
INSERT INTO sailors_1 VALUE (29, "Brutus", 1, 33);
INSERT INTO sailors_1 VALUE (31, "Lubber", 8, 55.5);
INSERT INTO sailors_1 VALUE (32, "Andy", 8, 25.5);
INSERT INTO sailors_1 VALUE (58, "Rusty", 10, 35);
INSERT INTO sailors_1 VALUE (64, "Horatio", 7, 35);
INSERT INTO sailors_1 VALUE (71, "Zorba", 10, 16);
INSERT INTO sailors_1 VALUE (74, "Horatio", 9, 35);
INSERT INTO sailors_1 VALUE (85, "Art", 3, 25.5);
INSERT INTO sailors_1 VALUE (95, "Bob", 3, 63.5);

INSERT INTO boats_1 VALUE (101, "Interlake", "blue");
INSERT INTO boats_1 VALUE (102, "Interlake", "red");
INSERT INTO boats_1 VALUE (103, "Clipper", "green");
INSERT INTO boats_1 VALUE (104, "Marine", "red");

INSERT INTO reserves_1 VALUE (22, 101, "1998-10-10");
INSERT INTO reserves_1 VALUE (22, 102, "1998-10-10");
INSERT INTO reserves_1 VALUE (22, 103, "1998-10-08");
INSERT INTO reserves_1 VALUE (22, 104, "1998-10-07");
INSERT INTO reserves_1 VALUE (31, 102, "1998-11-10");
INSERT INTO reserves_1 VALUE (31, 103, "1998-11-06");
INSERT INTO reserves_1 VALUE (31, 104, "1998-11-12");
INSERT INTO reserves_1 VALUE (64, 101, "1998-09-05");
INSERT INTO reserves_1 VALUE (64, 102, "1998-09-08");
INSERT INTO reserves_1 VALUE (74, 102, "1998-09-08");

alter table sailors_1 change sid sid smallint; -- sid is also refrenced in reserves_1 so it can't be changed
alter table boats_1 change bid bid char(3); -- bid is also refrenced in reserves_1 so it can't be changed
alter table boats_1 change bcolor bcolor char(5);

