CREATE TABLE department(
	depname varchar(25) PRIMARY KEY,
	location varchar(25),
	budget numeric(10,2)
)


CREATE TABLE Instructor(
	id numeric(5) PRIMARY KEY,
	iname varchar(25),
	designation varchar(25),
	salary numeric(9,2),
	depname varchar(25) REFERENCES department(depname)
)

CREATE TABLE Course(
	CCode varchar(15) PRIMARY KEY,
	ctitle varchar(25), 
	credits numeric(3),
	depname varchar(25) REFERENCES department(depname)
)

CREATE TABLE section(
	section_id numeric(5),
	CCode varchar(15) REFERENCES course(CCode),
	sem varchar(5),
	year date,
	room_no numeric(3),
	PRIMARY KEY (section_id, CCode, sem, year)
)

CREATE TABLE Teach(
	id numeric(5) REFERENCES Instructor(id),
	section_id numeric(5),
	CCode varchar(15),
	sem varchar(5),
	year date,
	FOREIGN KEY(section_id, CCode, sem, year) REFERENCES section(section_id, CCode, sem, year),
	PRIMARY KEY (id,section_id, CCode, sem, year)
)

CREATE TABLE student(
	Sid numeric(10) PRIMARY KEY,
	sname varchar(15),
	date_of_birth date,
	depname varchar(25) REFERENCES department(depname)
)

CREATE TABLE Take(
	Sid numeric(10),
	section_id numeric(5),
	CCode varchar(15),
	sem varchar(5),
	year date,
	grade varchar(3),
	FOREIGN KEY(section_id, CCode, sem, year) REFERENCES section(section_id, CCode, sem, year),
	PRIMARY KEY(Sid, section_id, CCode, SEM, year)
)

﻿INSERT INTO Department 
VALUES
('CSE','BLOCK A',250000),
('ECE','BLOCK B',250000),
('ME','BLOCK C',250000),
('EEE','BLOCK D',250000)

INSERT INTO Instructor
VALUES
(1,'AAA','Professor',25000,'CSE'),
(2,'BBB','Professor',25000,'ECE'),
(3,'CCC','Professor',25000,'ME'),
(4,'DDD','Professor',25000,'EEE')

INSERT INTO Instructor
VALUES
(5,'EEE','Professor',100000,'CSE'),
(6,'FFF','Professor',100000,'CSE'),
(7,'GGG','Professor',100000,'CSE'),
(8,'HHH','Professor',100000,'CSE')

INSERT INTO Instructor
VALUES
(10,'EDE','Professor',130000,'CSE')

INSERT INTO Course
VALUES
('15CSE301','DBMS',3,'CSE'),
('15ECE301','ECE Course 1',3,'ECE'),
('15EEE301','EEE Course 1',3,'EEE'),
('15ME301','ME Course 1',3,'ME')

INSERT INTO Section
VALUES
(1,'15CSE301','S5','01/01/2017',301),
(2,'15ECE301','S5','01/01/2017',302),
(3,'15ME301','S5','01/01/2017',303),
(4,'15EEE301','S5','01/01/2017',304)

INSERT INTO Teach 
VALUES
(1,1,'15CSE301','S5','01/01/2017'),
(2,2,'15ECE301','S5','01/01/2017'),
(3,3,'15ME301','S5','01/01/2017'),
(4,4,'15EEE301','S5','01/01/2017')

INSERT INTO Teach 
VALUES (1,2,'15ECE301','S5','01/01/2017')

INSERT INTO 
Student 
VALUES
(1,'ABC','01/01/1999','CSE'),
(2,'DEF','02/02/1999','ECE'),
(3,'GHI','03/03/1999','ME'),
(4,'JKL','04/04/1999','EEE')

INSERT INTO 
Student 
VALUES
(5,'MNO','05/05/1999','CSE')

INSERT INTO Take
VALUES
(1,1,'15CSE301','S5','01/01/2017','A'),
(2,2,'15ECE301','S5','01/01/2017','A+'),
(3,3,'15ME301','S5','01/01/2017','O'),
(4,4,'15EEE301','S5','01/01/2017','A+')

SELECT iname FROM instructor WHERE salary > SOME (SELECT salary FROM instructor WHERE depname = "BIOLOGY")

SELECT iname FROM instructor WHERE salary > ALL (SELECT salary FROM instructor WHERE depname = "BIOLOGY")

SELECT AVG(Salary) FROM instructor i1 GROUP BY i1.depname HAVING (SELECT AVG(Salary) FROM instructor i2 WHERE i1.depname = i2.depname) > 4200

SELECT iname, (SELECT AVG(Salary) FROM instructor i2 GROUP BY depname HAVING i1.depname = i2.depname) FROM instructor i1
 
WITH avg_salary as (SELECT depname, AVG(Salary) sal FROM instructor GROUP BY depname) SELECT a.depname, b.sal FROM department a, avg_salary b WHERE a.depname = b.depname

SELECT iname, salary FROM instructor WHERE salary = (SELECT MAX(Salary) FROM instructor)

WITH dept_avg_sal AS (SELECT depname, AVG(salary) d_avg FROM instructor GROUP BY depname), uni_avg_sal AS (SELECT AVG(salary) u_avg FROM instructor) SELECT depname FROM uni_avg_sal, dept_avg_sal WHERE u_avg < d_avg

SELECT depname, (SELECT COUNT(*) FROM instructor i WHERE i.depname = d.depname) FROM department d

SELECT iname from instructor i1 WHERE Salary > 2 * (SELECT AVG(Salary) FROM instructor i2 GROUP BY depname HAVING i2.depname = i1.depname) 