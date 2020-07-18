-- Screen 1: User login
-- 1. Procedure: user_login
-- 2. Input: i_username, i_password
-- a. i_username, i_password: VARCHAR
-- 3. Output: UserLogin (username, status, isCustomer, isAdmin, isManager)
-- a. isCustomer: INT (0: is not customer, 1: is customer)
-- b. isAdmin: INT (0: is not admin, 1: is admin)
-- c. isManager: INT (0: is not manager, 1: is manager)
DROP PROCEDURE IF EXISTS user_login;
DELIMITER $$
CREATE PROCEDURE `user_login`(IN i_username VARCHAR(45), IN i_password VARCHAR(200))
BEGIN
    DROP TABLE IF EXISTS UserLogin;
    CREATE TABLE UserLogin
    SELECT username as username, status as status,
    (
    case
    when username in (select username from customer) then '1' else '0'
    end
    ) as iscustomer,
    (
    case
    when username in (select username from admin) then '1' else '0'
    end
    ) as isadmin,
    (
 case
    when username in (select username from manager) then '1' else '0'
    end
    ) as ismanager
    FROM user
 WHERE user.username = i_username AND password = i_password;

END$$
DELIMITER ;

-- [PROVIDED] Screen 3: User register
-- 1. Procedure: user_register
-- 2. Input: i_username, i_password, i_firstname, i_lastname
-- a. i_username, i_password, i_firstname, i_lastname: VARCHAR
DROP PROCEDURE IF EXISTS user_register;
DELIMITER $$
CREATE PROCEDURE `user_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50))
BEGIN
		INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
END$$
DELIMITER ;

-- Screen 4 - 1: Customer-Only register
-- 1. Procedure: customer_only_register
-- 2. Input: i_username, i_password, i_firstname, i_lastname
-- a. i_username, i_password, i_firstname, i_lastname: VARCHAR
DROP PROCEDURE IF EXISTS customer_only_register;
DELIMITER $$
CREATE PROCEDURE `customer_only_register`(IN i_username VARCHAR(45), IN i_password VARCHAR(200), IN i_firstname VARCHAR(45), IN i_lastname VARCHAR(45))
BEGIN
		INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
        INSERT INTO customer(username) VALUES (i_username);
END$$
DELIMITER ;

-- Screen 4 - 2: Customer add credit card
-- 1. Procedure name: customer_add_creditcard
-- 2. Input: i_username, i_creditCardNum
-- a. i_username: VARCHAR
-- b. i_creditCardNum: CHAR
DROP PROCEDURE IF EXISTS customer_add_creditcard;
DELIMITER $$
CREATE PROCEDURE `customer_add_creditcard`(IN i_username VARCHAR(45), IN i_creditCardNum CHAR(16))
BEGIN
 IF char_length(i_creditCardNum) >= 15 AND ((select count(*) from creditcard as t1 where t1.ownedby=i_username)<5) 
 THEN
  INSERT INTO creditcard (credicardnum,ownedby) VALUES (i_creditCardNum,i_username);
 END IF;
END$$
DELIMITER ;

-- Screen 5: Manager-Only register
-- 1. Procedure name: manager_only_register
-- 2. Input: i_username, i_password, i_firstname, i_lastname, i_comName, i_empStreet, i_empCity, i_empState, i_empZipcode
-- a. i_username, i_password, i_firstname, i_lastname, i_comName, i_empStreet, i_empCity: VARCHAR
-- b. i_empState, i_empZipcode: CHAR
DROP PROCEDURE IF EXISTS manager_only_register;
DELIMITER $$
CREATE PROCEDURE `manager_only_register`(IN i_username VARCHAR(45), IN i_password VARCHAR(200), IN i_firstname VARCHAR(45), IN i_lastname VARCHAR(45)
,i_comName VARCHAR(45),i_empStreet VARCHAR(100),i_empCity VARCHAR(45), i_empState CHAR(2),i_empZipcode CHAR(5))
BEGIN
		INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
        INSERT INTO employee(username) VALUES (i_username);
        INSERT INTO manager(username,work_in,street,city,state,zipcode) VALUES (i_username,i_comName,i_empStreet,i_empCity,i_empState,i_empZipcode);
END$$
DELIMITER ;

-- Screen 6 - 1: Manager-Customer register
-- 1. Procedure: manager_customer_register
-- 2. Input: i_username, i_password, i_firstname, i_lastname, i_comName, i_empStreet, i_empCity, i_empState, i_empZipcode
-- a. i_username, i_password, i_firstname, i_lastname, i_comName, i_empStreet, i_empCity: VARCHAR
-- b. i_empState, i_empZipcode: CHAR
DROP PROCEDURE IF EXISTS manager_customer_register;
DELIMITER $$
CREATE PROCEDURE `manager_customer_register`(IN i_username VARCHAR(45), IN i_password VARCHAR(200), IN i_firstname VARCHAR(45), IN i_lastname VARCHAR(45)
,i_comName VARCHAR(45),i_empStreet VARCHAR(100),i_empCity VARCHAR(45), i_empState CHAR(2),i_empZipcode CHAR(5))
BEGIN
		INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
        INSERT INTO employee(username) VALUES (i_username);
        INSERT INTO customer(username) VALUES (i_username);
        INSERT INTO manager(username,work_in,street,city,state,zipcode) VALUES (i_username,i_comName,i_empStreet,i_empCity,i_empState,i_empZipcode);
END$$
DELIMITER ;

-- Screen 6: Manager-Customer add credit card 
-- 1. Procedure: manager_customer_add_creditcard
-- 2. Input: i_username, i_creditCardNum
-- a. i_username: VARCHAR
-- b. i_creditCardNum: CHAR
-- (creditcard >=15 restrict)
DROP PROCEDURE IF EXISTS manager_customer_add_creditcard;
DELIMITER $$
CREATE PROCEDURE `manager_customer_add_creditcard`(IN i_username VARCHAR(45), IN i_creditCardNum CHAR(16))
BEGIN
	IF char_length(i_creditCardNum) >= 15 
    THEN
		INSERT INTO creditcard (credicardnum,ownedby) VALUES (i_creditCardNum,i_username);
	END IF;
END$$
DELIMITER ;

-- Screen 13 - 1: Admin approve user
-- 1. Procedure: admin_approve_user
-- 2. Input: i_username
-- a. i_username: VARCHAR
DROP PROCEDURE IF EXISTS admin_approve_user;
DELIMITER $$
CREATE PROCEDURE `admin_approve_user`(IN i_username VARCHAR(45))
BEGIN
    UPDATE user
    SET user.status = 'Approved'
    WHERE user.username = i_username;
END$$
DELIMITER ;

-- Screen 13 - 2: Admin decline user
-- 1. Procedure: admin_decline_user
-- 2. Input: i_username
-- a. i_username: VARCHAR
-- (add the constraint Admin cannot decline “approved” the selected users)
DROP PROCEDURE IF EXISTS admin_decline_user;
DELIMITER $$
CREATE PROCEDURE `admin_decline_user`(IN i_username VARCHAR(45))
BEGIN
 
    UPDATE user
    SET user.status = 'Declined'
    WHERE user.username = i_username AND
    user.status != 'Approved';
END$$
DELIMITER ;

-- screen13-3
-- 1. Procedure: admin_filter_user
-- 2. Input: i_username, i_status, i_sortBy, i_sortDirection

-- a. i_sortBy has to be one of the following (EXACT naming): username, creditCardCount, userType, status. Default sort by username
-- b. i_sortDirection is either ASC or DESC. Default is DESC.
-- c. i_username: VARCHAR
-- d. i_status can be one of the following (EXACT naming): Approved, Pending, Declined, ALL
-- 3. Output: AdFilterUser (username, creditCardCount, userType, status)
-- a. userType has the following values: User, Customer, Admin, Manager, CustomerManager, CustomerAdmin
DROP PROCEDURE IF EXISTS admin_filter_user;
DELIMITER $$
CREATE PROCEDURE `admin_filter_user`(in i_username varchar(50), in i_status char(10), 
i_sortBy char(20), in i_sortDirection char(10))
BEGIN
SET SQL_SAFE_UPDATES = 0;

 drop table if exists AdFilterUser;
    if i_sortBy = '' then set i_sortBy = "username"; end if;
    if i_sortDirection = '' then set i_sortDirection = "DESC"; end if;
    
    create table AdFilterUser
    select username, creditCardCount, status
    from (
    select user.username, count(credicardnum) as creditCardCount, status 
    from user
    left join creditcard 
    on user.username = creditcard.ownedby group by user.username) as table1
    where (username = i_username or i_username = '') and (status = i_status or i_status = "ALL");
    alter table AdFilterUser add userType varchar(20);

    update AdFilterUser set userType = "User" 
    where username in (select username from user);
    update AdFilterUser set userType = "Customer" 
    where username in (select username from customer);
    update AdFilterUser set userType = "Admin"
    where username in (select username from admin);
    update AdFilterUser set userType = "Manager" 
    where username in (select username from manager);
    update AdFilterUser set userType = "CustomerManager" 
    where username in (select username from manager where username in (select username from customer));
    update AdFilterUser set userType = "CustomerAdmin"
    where username in (select username from admin where username in (select username from customer));
  
   SET @b = CONCAT('
    ALTER TABLE AdFilterUser
 ORDER BY ', i_sortBy,' ', i_sortDirection);
    
    PREPARE stmt2 FROM @b;
 EXECUTE stmt2;
 DEALLOCATE PREPARE stmt2;

END$$
DELIMITER ;

-- Screen 14: Admin filter company
-- 1. Procedure: admin_filter_company
-- 2. Input: i_comName, i_minCity, i_maxCity, i_minTheater, i_maxTheater, i_minEmployee, i_maxEmployee, i_sortBy, i_sortDirection
-- a. i_sortBy has to be one of the following (EXACT naming): comName, numCityCover, numTheater, numEmployee. Default sort by comName
-- b. i_sortDirection is either ASC or DESC. Default is DESC.
-- c. i_comName: VARCHAR
-- d. i_minCity, i_maxCity, i_minTheater, i_maxTheater, i_minEmployee, i_maxEmployee: INT
-- 3. Output: AdFilterCom (comName, numCityCover, numTheater, numEmployee)
-- NOTE1:(company name is a dropdown list!! maybe enum)
-- NOTE2: any input can be null or ""

DROP PROCEDURE IF EXISTS admin_filter_company;
DELIMITER $$
CREATE PROCEDURE `admin_filter_company`(IN i_comName VARCHAR(50), IN i_minCity INT(10), 
IN i_maxCity INT(10), IN i_minTheater INT(10), IN i_maxTheater INT(10), 
IN i_minEmployee INT(10), IN i_maxEmployee INT(10), IN i_sortBy VARCHAR(20), 
IN i_sortDirection VARCHAR(10))
BEGIN
    DROP TABLE IF EXISTS AdFilterCom;
    
    IF i_comName = '' THEN SET i_comName = 'ALL'; END IF;
    IF i_minCity IS NULL THEN SET i_minCity = 0; END IF;
    IF i_maxCity IS NULL THEN SET i_maxCity = 100000; END IF;
    IF i_minTheater IS NULL THEN SET i_minTheater = 0; END IF;
    IF i_maxTheater IS NULL THEN SET i_maxTheater = 100000; END IF;
    IF i_minEmployee IS NULL THEN SET i_minEmployee = 0; END IF;
    IF i_maxEmployee IS NULL THEN SET i_maxEmployee = 100000; END IF;

    IF i_sortBy = '' THEN SET i_sortBy = 'comName'; END IF;
    IF i_sortDirection = '' THEN SET i_sortDirection = 'DESC'; END IF;
    CREATE TABLE AdFilterCom
    SELECT comName, numCityCover, numTheater, numEmployee
 FROM (
 SELECT theater.compname as comName, count(DISTINCT theater.city) AS numCityCover, 
 count(DISTINCT theater.theaname) as numTheater, count(DISTINCT username) as numEmployee
 FROM theater
 LEFT JOIN manager
 ON theater.compname = manager.work_in
 GROUP BY theater.compname ) AS TABLE1
 WHERE (numCityCover >= i_minCity) AND
  (numCityCover <= i_maxCity) AND
   (numTheater >= i_minTheater) AND
    (numTheater <= i_maxTheater) AND
     (numEmployee >= i_minEmployee) AND
      (numEmployee <= i_maxEmployee) AND 
         (comName = i_comName OR i_comName = "ALL");
    
 SET @a = CONCAT('
    ALTER TABLE AdFilterCom
 ORDER BY ', i_sortBy,' ', i_sortDirection);
    
    PREPARE stmt1 FROM @a;
 EXECUTE stmt1;
 DEALLOCATE PREPARE stmt1;
END$$
DELIMITER ;

-- Screen 15: Admin create theater
-- 1. Procedure: admin_create_theater
-- 2. Input: i_thName, i_comName, i_thStreet, i_thCity, i_thState, i_thZipcode, i_capacity, i_managerUsername
-- a. i_thName:, i_comName, i_thStreet, i_thCity, i_managerUsername: VARCHAR
-- b. i_thState, i_thZipcode: CHAR
-- c. i_capacity: INT

DROP PROCEDURE IF EXISTS admin_create_theater;
DELIMITER $$
CREATE PROCEDURE `admin_create_theater`(IN i_thName VARCHAR(45), 
IN i_comName VARCHAR(45), IN i_thStreet VARCHAR(45),
IN i_thCity VARCHAR(45), IN i_thState CHAR(2),
IN i_thZipcode CHAR(5), IN i_capacity INT(11),
IN i_managerUsername VARCHAR(45))
	BEGIN
		IF i_comName = (select work_in from manager where manager.username = i_managerUsername)
		THEN
		INSERT INTO theater (theaname,compname,street,city,state,
		zipcode,capacity,manageby)
		VALUES (i_thName, i_comName,i_thStreet,i_thCity,i_thState,
		i_thZipcode,i_capacity,i_managerUsername);
		END IF;
END$$
DELIMITER ;

-- Screen 16 - 1: Admin view company detail (Employee)
-- 1. Procedure: admin_view_comDetail_emp
-- 2. Input: i_comName
-- a. i_comName: VARCHAR
-- 3. Output: AdComDetailEmp (empFirstname, empLastname)
DROP PROCEDURE IF EXISTS admin_view_comDetail_emp;
DELIMITER $$
CREATE PROCEDURE `admin_view_comDetail_emp`(IN i_comName VARCHAR(45))
BEGIN
	DROP TABLE IF EXISTS AdComDetailEmp;
    CREATE TABLE AdComDetailEmp
    SELECT user.firstname as empFirstname,user.lastname as empLastname
    FROM manager,user,company
    WHERE manager.work_in=company.compname 
    AND manager.username=user.username
    AND company.compname=i_comName;
END$$
DELIMITER ;

-- Screen 16 - 2: Admin view company detail (Theater)
-- 1. Procedure: admin_view_comDetail_th
-- 2. Input: i_comName
-- a. i_comName: VARCHAR
-- 3. Output: AdComDetailTh (thName, thManagerUsername, thCity, thState, thCapacity)
DROP PROCEDURE IF EXISTS admin_view_comDetail_th;
DELIMITER $$
CREATE PROCEDURE `admin_view_comDetail_th`(IN i_comName VARCHAR(45))
BEGIN
	DROP TABLE IF EXISTS AdComDetailTh;
    CREATE TABLE AdComDetailTh
    SELECT theater.theaname AS thName, theater.manageby AS thManagerUsername,
    theater.city AS thCity, theater.state AS thState, theater.capacity AS thCapacity
    FROM theater
    WHERE theater.compname=i_comName;
END$$
DELIMITER ;

-- Screen 17: Admin create movie
-- 1. Procedure: admin_create_mov
-- 2. Input: i_movName, i_movDuration, i_movReleaseDate
-- a. i_movName: VARCHAR
-- b. i_movDuration: INT
-- c. i_movReleaseDate: DATE
DROP PROCEDURE IF EXISTS admin_create_mov;
DELIMITER $$
CREATE PROCEDURE `admin_create_mov`(IN i_movName VARCHAR(45), 
IN i_movDuration INT(11),
IN i_movReleaseDate DATE)
BEGIN
	INSERT INTO movie (moviename,duration,releaseDate)
	VALUES (i_movName,i_movDuration,i_movReleaseDate);
END$$
DELIMITER ;


-- Screen 18: Manager filter theater
-- 1. Procedure: manager_filter_th
-- 2. Input: i_manUsername, i_movName, i_minMovDuration, i_maxMovDuration, i_minMovReleaseDate, i_maxMovReleaseDate, i_minMovPlayDate, i_maxMovPlayDate, i_includeNotPlayed
-- a. i_manUsername, i_movName: VARCHAR
-- b. i_minMovDuration, i_maxMovDuration: INT
-- c. i_minMovReleaseDate, i_maxMovReleaseDate, i_minMovPlayDate, i_maxMovPlayDate: DATE
-- d. i_includedNotPlay: BOOLEAN (NULL or FALSE: all movies, TRUE: only include not played movies)
-- 3. Output: ManFilterTh (movName, movDuration, movReleaseDate, movPlayDate)

-- Screen 18: Manager filter theater
-- 1. Procedure: manager_filter_th
-- 2. Input: i_manUsername, i_movName, i_minMovDuration, i_maxMovDuration, i_minMovReleaseDate, i_maxMovReleaseDate, i_minMovPlayDate, i_maxMovPlayDate, i_includeNotPlayed
-- a. i_manUsername, i_movName: VARCHAR
-- b. i_minMovDuration, i_maxMovDuration: INT
-- c. i_minMovReleaseDate, i_maxMovReleaseDate, i_minMovPlayDate, i_maxMovPlayDate: DATE
-- d. i_includedNotPlay: BOOLEAN (NULL or FALSE: all movies, TRUE: only include not played movies)
-- 3. Output: ManFilterTh (movName, movDuration, movReleaseDate, movPlayDate)

DROP PROCEDURE IF EXISTS manager_filter_th;
DELIMITER $$
CREATE PROCEDURE `manager_filter_th`(IN i_manUsername VARCHAR(45),IN i_movName VARCHAR(45), 
IN i_minMovDuration INT(11), IN i_maxMovDuration INT(11),
IN i_minReleaseDate Date, IN i_maxReleaseDate Date,
IN i_minMovPlayDate Date, IN i_maxMovPlayDate Date,
IN i_includedNotPlay boolean)
BEGIN
	DROP TABLE IF EXISTS TEMP;
	CREATE TABLE TEMP AS (SELECT * FROM movie,theater);
    DROP TABLE IF EXISTS ManFilterTh;
    CREATE TABLE ManFilterTh
	SELECT TEMP.moviename AS movName, duration AS movDuration, TEMP.releasedate AS movReleaseDate, date AS movPlayDate
	FROM TEMP
	LEFT JOIN movieplay 
		ON movieplay.theatername = temp.theaname and movieplay.compname = temp.compname and movieplay.moviename = temp.moviename
	WHERE
		((i_includedNotPlay IS NULL OR i_includedNotPlay = 0) AND
        (i_manUsername = '' OR i_manUsername = manageby) AND
        (i_movName = '' OR TEMP.moviename LIKE CONCAT("%",i_movName,"%")) AND
		(i_minMovDuration IS NULL OR duration >= i_minMovDuration) AND
		(i_maxMovDuration IS NULL OR duration <= i_maxMovDuration) AND
        (i_minReleaseDate IS NULL OR TEMP.releasedate >= i_minReleaseDate) AND
        (i_maxReleaseDate IS NULL OR TEMP.releasedate <= i_maxReleaseDate) AND
        (i_minMovPlayDate IS NULL OR date >= i_minMovPlayDate OR date IS NULL) AND
        (i_maxMovPlayDate IS NULL OR date <= i_maxMovPlayDate OR date IS NULL) ) OR
        ((i_includedNotPlay = 1) AND
        (i_manUsername = '' OR i_manUsername = manageby) AND
        (i_movName = '' OR TEMP.moviename LIKE CONCAT("%",i_movName,"%")) AND
		(i_minMovDuration IS NULL OR duration >= i_minMovDuration) AND
		(i_maxMovDuration IS NULL OR duration <= i_maxMovDuration) AND
        (i_minReleaseDate IS NULL OR TEMP.releasedate >= i_minReleaseDate) AND
        (i_maxReleaseDate IS NULL OR TEMP.releasedate <= i_maxReleaseDate) AND
        (date IS NULL));
	DROP TABLE TEMP;
END$$
DELIMITER ;

-- Screen 19: Manager schedule movie
-- 1. Procedure: manager_schedule_mov
-- 2. Input: i_manUsername, i_movName, i_movReleaseDate, i_movPlayDate
-- a. i_manUsername, i_movName: VARCHAR
-- b. i_movReleaseDate, i_movPlayDate: Date

-- Screen 19: Manager schedule movie
-- 1. Procedure: manager_schedule_mov
-- 2. Input: i_manUsername, i_movName, i_movReleaseDate, i_movPlayDate
-- a. i_manUsername, i_movName: VARCHAR
-- b. i_movReleaseDate, i_movPlayDate: Date
-- NOTE1: releasedate <= date
DROP PROCEDURE IF EXISTS manager_schedule_mov;
DELIMITER $$
CREATE PROCEDURE `manager_schedule_mov`(IN i_manUsername VARCHAR(45), 
IN i_movName VARCHAR(45), IN i_movReleaseDate DATE, in i_movPlayDate DATE)
BEGIN
	IF i_movReleaseDate <= i_movPlayDate
    THEN
		INSERT INTO movieplay (moviename, releasedate, date, compname, theatername)
		VALUES (i_movName, i_movReleaseDate, i_movPlayDate, 
		(SELECT theater.compname
		FROM theater
		WHERE theater.manageby = i_manUsername),
		(SELECT theater.theaname
		FROM theater
		WHERE theater.manageby = i_manUsername));
	END IF;
END$$

DELIMITER ;

-- Screen 20 - 1: Customer filter movie
-- 1. Procedure: customer_filter_mov
-- 2. Input: i_movName, i_comName, i_city, i_state, i_minMovPlayDate, i_maxMovPlayDate
-- a. i_movName, i_comName, i_city, i_state: VARCHAR
-- b. i_minMovPlayDate, i_maxMovPlayDate: Date
-- 3. Output: CosFilterMovie (movName, thName, thStreet, thCity, thState, thZipcode, comName, movPlayDate, movReleaseDate)
-- NOTE: should consider "" null
DROP PROCEDURE IF EXISTS customer_filter_mov;
DELIMITER $$
CREATE PROCEDURE `customer_filter_mov`(IN i_movName VARCHAR(45), IN i_comName VARCHAR(45),
IN i_city VARCHAR(45), IN i_state CHAR(3), 
IN i_minMovPlayDate Date, IN i_maxMovPlayDate Date)
BEGIN
	DROP TABLE IF EXISTS CosFilterMovie;
    
    CREATE TABLE CosFilterMovie
    SELECT movieplay.moviename as MovName, movieplay.theatername AS thName,
    theater.street AS thStreet, theater.city AS thCity,
    theater.state AS thState, theater.zipcode AS thZipcode,
    theater.compname AS comName,
    movieplay.date AS movPlayDate, movieplay.releasedate AS movReleaseDate
    FROM movieplay,theater
    WHERE movieplay.theatername=theater.theaname AND movieplay.compname=theater.compname
    AND
    (movieplay.date >= i_minMovPlayDate OR i_minMovPlayDate IS NULL)AND 
    (movieplay.date <= i_maxMovPlayDate OR i_maxMovPlayDate IS NULL)
    AND (i_state = theater.state OR i_state = '' OR i_state = 'ALL')
    AND (i_city = theater.city OR i_city = 'ALL' OR i_city = '')
    AND (i_movName = movieplay.moviename OR i_movName = 'ALL'OR i_movName = '')
    AND (i_comName=theater.compname OR i_comName = 'ALL' OR i_comName = '');
END$$
DELIMITER ;

-- Screen 20 - 2: Customer view movie
-- 1. Procedure: customer_view_mov
-- 2. Input: i_creditCardNum, i_movName, i_movReleaseDate, i_thName, i_comName, i_movPlayDate
-- a. i_creditCardNum: CHAR
-- b. i_movName, i_thName, i_comName: VARCHAR
-- c. i_movReleaseDate, i_movPlayDate: Date
DROP PROCEDURE IF EXISTS customer_view_mov;
DELIMITER $$
CREATE PROCEDURE `customer_view_mov`(IN i_creditCardNum CHAR(16),
IN i_movName VARCHAR(45), IN i_movReleaseDate Date,
IN i_thName VARCHAR(45), IN i_comName VARCHAR(45),
IN i_movPlayDate Date)
BEGIN
  IF char_length(i_creditCardNum) >= 15 
 and
    (select count(*)
 from (orderhistory join creditcard on orderhistory.creditcardnum = creditcard.credicardnum)
 where date=i_movPlayDate and ownedby=(select c1.ownedby from creditcard c1 where c1.credicardnum = i_creditCardNum))<=2
  THEN
 INSERT INTO orderhistory (creditcardnum,moviename,releasedate,theaname,compname,date)
 VALUES (i_creditCardNum, i_movName,i_movReleaseDate,i_thName,i_comName,i_movPlayDate);
 END IF;
END$$
DELIMITER ;
DELIMITER ;

-- Screen 21: Customer view history
-- 1. Procedure: customer_view_history
-- 2. Input: i_cusUsername
-- a. i_cusUsername: VARCHAR
-- 3. Output: CosViewHistory (movName, thName, comName, creditCardNum, movPlayDate)
-- screen 1
DROP PROCEDURE IF EXISTS customer_view_history;
DELIMITER $$
CREATE PROCEDURE `customer_view_history`(IN i_cusUsername VARCHAR(45))
BEGIN
    DROP TABLE IF EXISTS CosViewHistory;
    CREATE TABLE CosViewHistory
    SELECT moviename as movName, theaname as thName, compname as comName, creditcardnum as creditCardNum, date as movPlayDate
    FROM creditcard, orderhistory
    WHERE  i_cusUsername = creditcard.ownedby AND creditcard.credicardnum = orderhistory.creditcardnum;
END$$
DELIMITER ;


-- [PROVIDED] Screen 22 - 1: User filter theater
-- 1. Procedure: user_filter_th
-- 2. Input: i_thName, i_comName, i_city, i_state
-- a. i_thName, i_comName, i_city, i_state: VARCHAR
-- 3. Output: UserFilterTh (thName, thStreet, thCity, thState, thZipcode, comName)
DROP PROCEDURE IF EXISTS user_filter_th;
DELIMITER $$
CREATE PROCEDURE `user_filter_th`(IN i_thName VARCHAR(45), IN i_comName VARCHAR(45), IN i_city VARCHAR(45), IN i_state VARCHAR(3))
BEGIN
    DROP TABLE IF EXISTS UserFilterTh;
    IF i_thName = '' THEN SET i_thName = 'ALL'; END IF;
    IF i_comName = '' THEN SET i_comName = 'ALL'; END IF;
    IF i_city = '' THEN SET i_city = 'ALL'; END IF;
    IF i_state = '' THEN SET i_state = 'ALL'; END IF;
    
    CREATE TABLE UserFilterTh
	SELECT theaname as thName, street as thStreet, city as thCity, state as thState, zipcode as thZipcode, compname as comName
    FROM Theater
    WHERE 
		(theaname = i_thName OR i_thName = "ALL") AND
        (compname = i_comName OR i_comName = "ALL") AND
        (city = i_city OR i_city = "ALL") AND
        (state = i_state OR i_state = "ALL");
END$$
DELIMITER ;

-- [PROVIDED] Screen 22 - 2: User visit theater
-- 1. Procedure: user_visit_th
-- 2. Input: i_thName, i_comName, i_visitDate, i_username
-- a. i_thName, i_comName, i_city, i_username: VARCHAR
-- b. i_visitDate: DATE

DROP PROCEDURE IF EXISTS user_visit_th;
DELIMITER $$
CREATE PROCEDURE `user_visit_th`(IN i_thName VARCHAR(50), IN i_comName VARCHAR(50), IN i_visitDate DATE, IN i_username VARCHAR(50))
BEGIN
    INSERT INTO visit(id,visitto_thename,visitto_compname,date, visitedby)
    VALUES ((select max(id)+1 from visit as a1),i_thName, i_comName, i_visitDate, i_username);
END$$
DELIMITER ;

-- [PROVIDED] Screen 23: User filter visit history
-- 1. Procedure: user_filter_visitHistory
-- 2. Input: i_username, i_minVisitDate, i_maxVisitDate
-- a. i_username: VARCHAR
-- b. i_minVisitDate, i_maxVisitDate: DATE
-- 3. Output: UserVisitHistory (thName, thStreet, thCity, thState, thZipcode, comName, visitDate)
DROP PROCEDURE IF EXISTS user_filter_visitHistory;
DELIMITER $$
CREATE PROCEDURE `user_filter_visitHistory`(IN i_username VARCHAR(50), IN i_minVisitDate DATE, IN i_maxVisitDate DATE)
BEGIN
    DROP TABLE IF EXISTS UserVisitHistory;
    CREATE TABLE UserVisitHistory
	SELECT theaname as thName, street as thStreet, city as thCity, state as thState, zipcode as thZipcode, compname as comName, date as visitDate
    FROM visit
		JOIN
        theater
        on (visit.visitto_thename = theater.theaname AND visit.visitto_compname = theater.compname)
	WHERE
		(visitedby = i_username) AND
        (i_minVisitDate IS NULL OR date >= i_minVisitDate) AND
        (i_maxVisitDate IS NULL OR date <= i_maxVisitDate);
END$$
DELIMITER ;