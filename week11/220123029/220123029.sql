create database if not exists week11;
use week11;

-- 1
set @sailors_table_sql = 
'create table sailors(
sid int,
sname char(50),
rating int,
age int
);';
prepare sailors_stmt from @sailors_table_sql;
execute sailors_stmt;

-- 2
set @reserves_table = 
'create table reserves(
sid int,
bid int,
day date);' ;
prepare reserves_stmt from @reserves_table;
execute reserves_stmt;


-- 3
set @boats_table =
'create table boats(
bname char(50),
bcolor char(50),
bid int
);' ;
prepare boats_stmt from @boats_table;
execute boats_stmt;



-- 4a
create table sailor_name(
sno int,
sname char(20)
);

-- 4b
create table boat_name(
bno int,
bname char(20)
);

-- 4c
create table boat_color(
bno int,
bcolor char(20)
);


-- 5a
select * from sailor_name;
-- 5b
select * from boat_name;
-- 5c
select * from boat_color;



-- 6
DELIMITER //
create procedure populate_sailors()
BEGIN
declare i int default 0;
while i<500 do
	insert into sailors (sid,sname,age,rating) 
    select i+1 , sname, floor(18 + rand()*(65-18)) , floor(1+rand()*(10-1))
    from sailor_name order by rand() LIMIT 1;
    set i=i+1;
END WHILE;
END//
DELIMITER ;

call populate_sailors();



-- 7
DELIMITER //
create procedure populate_boats()
BEGIN
declare i int default 0;
while i<50 do
	insert into boats (bname,bcolor,bid)
    select bname , bcolor , i+1 
    from boat_name natural join boat_color order by rand() LIMIT 1;
    set i = i+1;
END WHILE;
END//
DELIMITER ;

call populate_boats();


-- 8
DELIMITER //
create procedure populate_reserves()
BEGIN
declare i int default 0;
while i<5000 do
	insert into reserves (sid,bid,day)
    select sid , bid , generate_random_date()
    from sailors natural join boats order by rand() LIMIT 1;
    set i = i+1;
END WHILE;
END//
DELIMITER ;

call populate_reserves();





-- 9
DELIMITER //
create function generate_random_date() returns char(50) deterministic
begin
    declare random_day int;
    declare random_month int;
    set random_month = floor(1 + rand() * 12);
    if random_month in (1, 3, 5, 7, 8, 10, 12) then
        set random_day = floor(1 + rand() * 31);
    elseif random_month in (4, 6, 9, 11) then
        set random_day = floor(1 + rand() * 30);
    else
        set random_day = floor(1 + rand() * 29); 
    end if;
    return concat('2024-', lpad(random_month, 2, '0'), '-', lpad(random_day, 2, '0'));
end//
DELIMITER ;




-- 10
DELIMITER //
create procedure get_boat_color(IN sid int , OUT color char(50))
BEGIN
	select bcolor into color
    from reserves join boats
    on reserves.bid = boats.bid
    where reserves.sid = sid
	LIMIT 1;
END //
DELIMITER ;


-- 11
DELIMITER // 
create procedure get_rating(OUT t_rating INT)
BEGIN
	select sum(rating) into t_rating
    from sailors
    where exists(
			select * from reserves
            where DAYNAME(day) = 'Sunday' and reserves.sid = sailors.sid
            );
END //
DELIMITER ;




-- 12
DELIMITER //
create function get_grade(rating int) returns char(2) deterministic
BEGIN
    declare grade char(2);
    case rating
        when 1 then set grade = 'F';
        when 2 then set grade = 'F';
        when 3 then set grade = 'F';
        when 4 then set grade = 'DD';
        when 5 then set grade = 'CD';
        when 6 then set grade = 'CC';
        when 7 then set grade = 'BC';
        when 8 then set grade = 'BB';
        when 9 then set grade = 'AB';
        when 10 then set grade = 'AA';
        else set grade = 'Unknown';
    end case;
    return grade;
END //
DELIMITER ;



-- 13
select sid , rating ,get_grade(rating) from sailors;

