-- task 1
CREATE DATABASE week12;
USE week12;


-- task 2
CREATE TABLE sailors(
	sid INT,
    sname CHAR(50),
    rating INT,
    age DECIMAL(3,1),
    PRIMARY KEY (sid)
);

CREATE TABLE boats(
	bid INT,
    bname CHAR(50),
    bcolor CHAR(50),
    PRIMARY KEY (bid)
);

CREATE TABLE reserves(
	sid INT,
    bid INT,
    day CHAR(50),
    PRIMARY KEY (sid, bid, day),
    FOREIGN KEY (sid) REFERENCES sailors(sid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (bid) REFERENCES boats(bid) ON UPDATE CASCADE ON DELETE CASCADE
);


-- task 3
CREATE TABLE sailors_log(
	sid INT,
    event_ba CHAR(50) CHECK (event_ba IN ('before', 'after')),
    ops CHAR(50) CHECK (ops IN ('insert', 'update', 'delete')),
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE boats_log(
	bid INT,
    event_ba CHAR(50) CHECK (event_ba IN ('before', 'after')),
    ops CHAR(50) CHECK (ops IN ('insert', 'update', 'delete')),
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reserves_log(
	sid INT,
    bid INT,
    day CHAR(10),
    event_ba CHAR(50) CHECK (event_ba IN ('before', 'after')),
    ops CHAR(50) CHECK (ops IN ('insert', 'update', 'delete')),
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sid) REFERENCES sailors(sid)
);

CREATE TABLE sailors_log_log(
	sid INT,
    event_ba CHAR(50) CHECK (event_ba IN ('before', 'after')),
    ops CHAR(50) CHECK (ops IN ('insert', 'update', 'delete')),
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sailors_log_log_log(
	sid INT,
    event_ba CHAR(50) CHECK (event_ba IN ('before', 'after')),
    ops CHAR(50) CHECK (ops IN ('insert', 'update', 'delete')),
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- task 4
-- populate


-- task 5
-- 1
DELIMITER //
CREATE TRIGGER sailor_t1 BEFORE INSERT ON sailors
FOR EACH ROW
BEGIN
    INSERT INTO sailors_log (sid, event_ba, ops)
    VALUES (NEW.sid, 'before', 'insert');
END//
DELIMITER ;

-- 2
DELIMITER //
CREATE TRIGGER boat_t1 BEFORE INSERT ON boats
FOR EACH ROW
BEGIN
    INSERT INTO boats_log (bid, event_ba, ops)
    VALUES (NEW.bid, 'before', 'insert');
END//
DELIMITER ;

-- 3
DELIMITER //
CREATE TRIGGER reserve_t1 BEFORE INSERT ON reserves
FOR EACH ROW
BEGIN
    INSERT INTO reserves_log (sid, bid, day, event_ba, ops)
    VALUES (NEW.sid, NEW.bid, NEW.day, 'before', 'insert');
END//
DELIMITER ;

-- 4
DELIMITER //
CREATE TRIGGER sailor_t2 AFTER UPDATE ON sailors
FOR EACH ROW
BEGIN
    INSERT INTO sailors_log (sid, event_ba, ops)
    VALUES (NEW.sid, 'before', 'insert');
END//
DELIMITER ;

-- 5
DELIMITER //
CREATE TRIGGER boat_t2 AFTER UPDATE ON boats
FOR EACH ROW
BEGIN
    INSERT INTO boats_log (bid, event_ba, ops)
    VALUES (NEW.bid, 'before', 'insert');
END//
DELIMITER ;

-- 6
DELIMITER //
CREATE TRIGGER reserve_t2 AFTER UPDATE ON reserves
FOR EACH ROW
BEGIN
    INSERT INTO reserves_log (sid, bid, day, event_ba, ops)
    VALUES (NEW.sid, NEW.bid, NEW.day, 'before', 'insert');
END//
DELIMITER ;

-- 7
DELIMITER //
CREATE TRIGGER sailor_t3 AFTER DELETE ON sailors
FOR EACH ROW
BEGIN
    INSERT INTO sailors_log (sid, event_ba, ops)
    VALUES (OLD.sid, 'before', 'insert');
END//
DELIMITER ;

-- 8
DELIMITER //
CREATE TRIGGER boat_t3 AFTER DELETE ON boats
FOR EACH ROW
BEGIN
    INSERT INTO boats_log (bid, event_ba, ops)
    VALUES (OLD.bid, 'before', 'insert');
END//
DELIMITER ;

-- 9
DELIMITER //
CREATE TRIGGER reserve_t3 AFTER DELETE ON reserves
FOR EACH ROW
BEGIN
    INSERT INTO reserves_log (sid, bid, day, event_ba, ops)
    VALUES (OLD.sid, OLD.bid, OLD.day, 'before', 'insert');
END//
DELIMITER ;


-- TASK 5 SECOND

-- 3
DELIMITER $$
CREATE PROCEDURE PopulateReserves()
BEGIN
    DECLARE sid_val INT;
    DECLARE bid_val INT;
    DECLARE day_val DATE;
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT sid FROM sailors;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    reserve_loop: LOOP
        FETCH cur INTO sid_val;
        IF done THEN
            LEAVE reserve_loop;
        END IF;

        SET bid_val = (SELECT bid FROM boats ORDER BY RAND() LIMIT 1);
        SET day_val = DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 365) DAY);

        INSERT INTO reserves (sid, bid, day) VALUES (sid_val, bid_val, day_val);
        INSERT INTO reserves (sid, bid, day) VALUES (sid_val, bid_val, day_val);
    END LOOP;

    CLOSE cur;
END$$
DELIMITER ;
CALL PopulateReserves();





-- 4, 5, 6
SELECT * FROM sailors_log;
SELECT * FROM boats_log;
SELECT * FROM reserves_log;

-- 7,8
-- update

-- 9
UPDATE reserves
SET day = DATE_ADD(day, INTERVAL 1 DAY)
LIMIT 100;

-- 10, 11, 12
SELECT * FROM sailors_log;
SELECT * FROM boats_log;
SELECT * FROM reserves_log;

-- 13, 14
-- delete

-- 15
DELETE FROM reserves
LIMIT 100;

-- 16, 17, 18
SELECT * FROM sailors_log;
SELECT * FROM boats_log;
SELECT * FROM reserves_log;


-- TASK 6
DELIMITER //
CREATE TRIGGER sailor_t02 BEFORE INSERT ON sailors
FOR EACH ROW PRECEDES sailor_t1
BEGIN
    INSERT INTO sailors_log (sid, event_ba, ops)
    VALUES (NEW.sid, 'before', 't2 insert');
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER sailor_t03 BEFORE INSERT ON sailors
FOR EACH ROW FOLLOWS sailor_t02
BEGIN
    INSERT INTO sailors_log (sid, event_ba, ops)
    VALUES (NEW.sid, 'before', 't3 insert');
END//
DELIMITER ;



-- task 7
SELECT * FROM sailors_log;


-- TASK 8
DELIMITER //
CREATE TRIGGER sailor_log_t1 AFTER INSERT ON sailors_log
FOR EACH ROW 
BEGIN
    INSERT INTO sailors_log_log (sid, event_ba, ops)
    VALUES (NEW.sid, 'before', 'insert');
END//
DELIMITER ;


DELIMITER //
CREATE TRIGGER sailor_log_log_t1 AFTER INSERT ON sailors_log_log
FOR EACH ROW 
BEGIN
    INSERT INTO sailors_log_log_log (sid, event_ba, ops)
    VALUES (NEW.sid, 'before', 'insert');
END//
DELIMITER ;



-- task 10  (TASK 9 IS NOT GIVEN NUMBERING MISTAKE)
SELECT * FROM sailors_log;
SELECT * FROM sailors_log_log;
SELECT * FROM sailors_log_log_log;


-- TASK 11
DELIMITER //
CREATE TRIGGER sailor_log_log_log_t1 AFTER INSERT ON sailors_log_log_log
FOR EACH ROW 
BEGIN
    INSERT INTO sailors (sname, rating, age)
    VALUES (CONCAT('Sailor', FLOOR(RAND() * 100)), FLOOR(RAND() * 10), FLOOR(RAND() * 50));
END//
DELIMITER ;

-- task 12
SELECT * FROM sailors_log;
SELECT * FROM sailors_log_log;
SELECT * FROM sailors_log_log_log;


-- task 13
INSERT INTO sailors (sid, sname, rating, age) 
SELECT * FROM sailors LIMIT 10;

INSERT INTO boats (bid, bname, bcolor)
SELECT * FROM boats LIMIT 10;

INSERT INTO reserves (sid, bid, day)
SELECT * FROM reserves LIMIT 10;

SELECT * FROM sailors_log;
SELECT * FROM boats_log;
SELECT * FROM reserves_log;