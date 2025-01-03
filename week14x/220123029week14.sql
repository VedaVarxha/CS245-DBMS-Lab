-- Task 01
CREATE DATABASE week13;
USE week13;

-- Task 02 a
CREATE TABLE location(
    location_id INT,
    city CHAR(10),
    state CHAR(2),
    country CHAR(20),
    PRIMARY KEY(location_id)
);

-- Task 02 b
CREATE TABLE product(
    product_id INT,
    product_name CHAR(10),
    category char(20),
    price INT,
    PRIMARY KEY(product_id)
);

-- Task 02 c
CREATE TABLE sale(
    product_id INT,
    time_id INT,
    location_id INT,
    sales INT,
    PRIMARY KEY(product_id, time_id, location_id)
);

 -- Task 03 a
INSERT INTO location(location_id,city,state,country) VALUES (1,'Madison','WI','USA');
INSERT INTO location(location_id,city,state,country) VALUES (2,'Fresno','CA','USA');
INSERT INTO location(location_id,city,state,country) VALUES (5,'Chennai','TN','India');

 -- Task 03 b
 INSERT INTO product(product_id,product_name,category,price) VALUES (11,'Lee Jeans','Apparel',25);
 INSERT INTO product(product_id,product_name,category,price) VALUES (12,'Zord','Toys',18);
 INSERT INTO product(product_id,product_name,category,price) VALUES (13,'Biro Pen','Stationery',2);
 
 -- Task 03 c
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (11,1995,1,25);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (11,1996,1,8);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (11,1997,1,15);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (12,1995,1,30);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (12,1996,1,20);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (12,1997,1,50);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (13,1995,1,8);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (13,1996,1,10);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (13,1997,1,10);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (11,1995,2,35);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (11,1996,2,22);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (11,1997,2,10);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (12,1995,2,26);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (12,1996,2,45);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (12,1997,2,20);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (13,1995,2,20);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (13,1996,2,40);
 INSERT INTO sale(product_id,time_id,location_id,sales) VALUES (13,1997,2,5);
 
-- Task 04 a
CREATE TABLE year_state_01(
    YEAR CHAR(10),
    WI INT,
    CA INT,
    TOTAL INT
);
 
-- Task 04 a i
INSERT INTO year_state_01(YEAR) VALUES('1995');
UPDATE year_state_01
set WI = (SELECT sum(sales)
            FROM sale JOIN location on location.location_id = sale.location_id
            WHERE sale.time_id = 1995 and location.state = 'WI')
WHERE YEAR = '1995';

 -- Task 04 a ii
 UPDATE year_state_01
 set CA = (SELECT sum(sales)
		     FROM sale JOIN location on location.location_id = sale.location_id
             WHERE sale.time_id = 1995 and location.state = 'CA')
 WHERE YEAR = '1995';
 
-- Task 04 a iii
UPDATE year_state_01
set TOTAL = WI + CA
WHERE YEAR = '1995';

-- Task 04 a iv
INSERT INTO year_state_01(YEAR) VALUES('1996');
UPDATE year_state_01
set WI = (SELECT sum(sales)
            FROM sale JOIN location on location.location_id = sale.location_id
            WHERE sale.time_id = 1996 and location.state = 'WI')
WHERE YEAR = '1996';

 -- Task 04 a v
 UPDATE year_state_01
 set CA = (SELECT sum(sales)
		     FROM sale JOIN location on location.location_id = sale.location_id
             WHERE sale.time_id = 1996 and location.state = 'CA')
 WHERE YEAR = '1996';
 
-- Task 04 a vi
UPDATE year_state_01
set TOTAL = WI + CA
WHERE YEAR = '1996';

-- Task 04 a vii
INSERT INTO year_state_01(YEAR) VALUES('1997');
UPDATE year_state_01
set WI = (SELECT sum(sales)
            FROM sale JOIN location on location.location_id = sale.location_id
            WHERE sale.time_id = 1997 and location.state = 'WI')
WHERE YEAR = '1997';

 -- Task 04 a viii
 UPDATE year_state_01
 set CA = (SELECT sum(sales)
		     FROM sale JOIN location on location.location_id = sale.location_id
             WHERE sale.time_id = 1997 and location.state = 'CA')
 WHERE YEAR = '1997';
 
-- Task 04 a ix
UPDATE year_state_01
set TOTAL = WI + CA
WHERE YEAR = '1997';

-- Task 04 a x
INSERT INTO year_state_01(YEAR) VALUES('Total');
UPDATE year_state_01
set WI = (SELECT sum(sales)
            FROM sale
            JOIN location on location.location_id = sale.location_id
            WHERE location.state = 'WI')
WHERE YEAR = 'Total';

-- Task 04 a xi
UPDATE year_state_01
set CA = (SELECT sum(sales)
            FROM sale
            JOIN location on location.location_id = sale.location_id
            WHERE location.state = 'CA')
WHERE YEAR = 'Total';

-- Task 04 a xii
UPDATE year_state_01
set TOTAL = WI + CA
WHERE YEAR = 'Total';

-- Task 04 a xiii
SELECT * FROM year_state_01;

-- Task 04 b i
 CREATE TABLE year_state_02_01 AS SELECT sale.time_id as YEAR,
        SUM(CASE when location.state = "WI" THEN sales ELSE 0 END) AS WI,
        SUM(CASE when location.state = "CA" THEN sales ELSE 0 END) AS CA
FROM sale
JOIN location ON location.location_id = sale.location_id
GROUP BY sale.time_id;

-- Check
SELECT * FROM year_state_02_01;

-- Task 04 b ii
CREATE TABLE year_state_02_02 
SELECT (WI + CA) AS Total
FROM year_state_02_01;

-- Check
SELECT * FROM year_state_02_02;

-- Task 04 b iii
CREATE TABLE year_state_02_03 
SELECT 'Total',sum(WI) as 'WI', sum(CA) AS 'CA' 
FROM year_state_02_01;

-- Check
SELECT * FROM year_state_02_03;

-- Task 04 b iv
CREATE TABLE year_state_02_04
SELECT sum(Total) as 'TOTAL'
FROM year_state_02_02;

-- Check
SELECT * FROM year_state_02_04;

-- Task 04 c
CREATE TABLE year_state_03
SELECT sale.time_id as 'YEAR',
    sum(case when location.state = 'WI' THEN sale.sales else 0 end) AS 'WI',
    sum(case when location.state = 'CA' THEN sale.sales else 0 end) AS 'CA',
    SUM(sales) as 'Total'
FROM sale
JOIN location ON location.location_id = sale.location_id
group by sale.time_id
UNION
SELECT 'TOTAL',
    sum(case when location.state = 'WI' THEN sale.sales else 0 end) AS 'WI',
    sum(case when location.state = 'CA' THEN sale.sales else 0 end) AS 'CA',
    SUM(sales) as 'Total'
FROM sale
JOIN location ON location.location_id = sale.location_id;

-- Check
SELECT * FROM year_state_03;

-- Task 04 d
CREATE TABLE year_state_04
SELECT 
        IF(GROUPING(time_id),'TOTAL', time_id) AS YEAR,
        sum(case when location.state = 'WI' THEN sale.sales else 0 end) AS 'WI',
        sum(case when location.state = 'CA' THEN sale.sales else 0 end) AS 'CA',
        SUM(sales) as 'Total'
FROM sale
JOIN location ON location.location_id = sale.location_id
group by sale.time_id WITH ROLLUP;

-- Check
SELECT * FROM year_state_04;




