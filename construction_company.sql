CREATE TABLE Qualification(
type TEXT PRIMARY KEY,
description TEXT);

CREATE TABLE Has_qualification(
SSID INT NOT NULL,
type TEXT,
CONSTRAINT fk_employee
    FOREIGN KEY (SSID)
    REFERENCES Employee(SSID)
CONSTRAINT fk_qualification
    FOREIGN KEY (type)
    REFERENCES Qualification(type)
PRIMARY KEY (SSID, type));

CREATE TABLE Company(
company_ID INT NOT NULL PRIMARY KEY,
address TEXT,
name TEXT);

CREATE TABLE Employee(
SSID INT NOT NULL PRIMARY KEY,
position TEXT,
name TEXT,
company_ID INT,
CONSTRAINT fk_company
    FOREIGN KEY (company_ID)
    REFERENCES Company(company_ID)
);

CREATE TABLE Project(
project_ID INT NOT NULL PRIMARY KEY,
main_project INT,
company_ID INT,
description TEXT,
customer TEXT,
location TEXT,
startdate DATE,
enddate DATE,
CONSTRAINT fk_company
    FOREIGN KEY (company_ID)
    REFERENCES Company(company_ID)
);

CREATE TABLE Absent(
SSID INT NOT NULL,
project_ID INT NOT NULL,
startdate DATE,
enddate DATE,
sub_ID INT,
CONSTRAINT fk_employee
    FOREIGN KEY (SSID)
    REFERENCES Employee(SSID)
CONSTRAINT fk_project
    FOREIGN KEY (project_ID)
    REFERENCES Project(project_ID)
PRIMARY KEY(SSID, startdate));

CREATE TABLE Machine(
model TEXT PRIMARY KEY,
company_ID INT,
description TEXT,
manufacturer TEXT,
size TEXT,
fuel_consumption TEXT,
CONSTRAINT fk_company
    FOREIGN KEY (company_ID)
    REFERENCES Company(company_ID)
);

CREATE TABLE Machine_number(
serialNumber INT NOT NULL,
model TEXT,
CONSTRAINT fk_machine
    FOREIGN KEY (model)
    REFERENCES Machine(model)
PRIMARY KEY(serialNumber, model));

CREATE TABLE Reservation(
reservation_ID INT NOT NULL PRIMARY KEY,
project INT,
serial_number INT,
model TEXT,
startdate DATE,
enddate DATE,
CONSTRAINT fk_project
    FOREIGN KEY (project)
    REFERENCES Project(project_ID)
CONSTRAINT fk_machine_number
    FOREIGN KEY (serial_number, model)
    REFERENCES Machine_number(serialNumber, model)
);

CREATE TABLE Out_of_use(
serial_number INT,
model TEXT,
startdate DATE,
enddate DATE,
CONSTRAINT fk_machine_number
    FOREIGN KEY (serial_number, model)
    REFERENCES Machine_number(serialNumber, model)
PRIMARY KEY(serial_number, model, startdate)
);

CREATE TABLE Assignment(
project_ID INT NOT NULL,
SSID INT NOT NULL,
CONSTRAINT fk_project
    FOREIGN KEY (project_ID)
    REFERENCES Project(project_ID)
CONSTRAINT fk_employee
    FOREIGN KEY (SSID)
    REFERENCES Employee(SSID)
PRIMARY KEY (project_ID, SSID));

CREATE TABLE Required(
project_ID INT,
type TEXT,
amount INT,
CONSTRAINT fk_project
    FOREIGN KEY (project_ID)
    REFERENCES Project(project_ID)
CONSTRAINT fk_qualification
    FOREIGN KEY (type)
    REFERENCES Qualification(type)
PRIMARY KEY(project_ID, type));

CREATE TABLE Required_Machines(
project_ID INT NOT NULL,
model TEXT,
amount INT,
CONSTRAINT fk_project
    FOREIGN KEY (project_ID)
    REFERENCES Project(project_ID)
CONSTRAINT fk_machine
    FOREIGN KEY (model)
    REFERENCES Machine(model)
PRIMARY KEY (project_ID, model));

-- Set up company
INSERT INTO Company
Values(123, "Moonlight avenue 14", "Work bois");

-- Add four employees
INSERT INTO Employee
Values(400, "Main work man", "Joe Jobs", 123);

INSERT INTO Employee
Values(401, "CEO", "Boris Bronco", 123);

INSERT INTO Employee
Values(402, "Plumber specialist", "Mark Lumber", 123);

INSERT INTO Employee
Values(403, "Secretary", "Julia Matthews", 123);

-- Add 4 qualifications
INSERT INTO Qualification
Values("Electical installation", "Worker can safely install wiring and do other electronical installation.");

INSERT INTO Qualification
Values("Excel skills", "Worker can do basic operations in microsoft excel.");

INSERT INTO Qualification
Values("Machine operation", "Worker can operate heavy machinery such as excavator.");

INSERT INTO Qualification
Values("Plumbing skills", "Worker can install pipes and do other general plumbing work.");

-- Set employees to have qualifications
INSERT INTO Has_qualification
Values(400, "Excel skills");

INSERT INTO Has_qualification
Values(400, "Machine operation");

INSERT INTO Has_qualification
Values(401, "Machine operation");

INSERT INTO Has_qualification
Values(401, "Electical installation");

INSERT INTO Has_qualification
Values(402, "Plumbing skills");

INSERT INTO Has_qualification
Values(403, "Excel skills");

-- Add three different machine types
INSERT INTO Machine
Values("E-001", 123, "Large excavator, useful for moving large amounts of land", "Hitachi", "L", 15);

INSERT INTO Machine
Values("H-001", 123, "Construction site machine hammer", "Fiskars", "M", 2);

INSERT INTO Machine
Values("P-15", 123, "General pipe connector", "Pied Piper", "M", 8);

-- Two copies of the same machine
INSERT INTO Machine_number
VALUES(1, "E-001");

INSERT INTO Machine_number
VALUES(2, "E-001");

INSERT INTO Machine_number
VALUES(1, "H-001");

INSERT INTO Machine_number
VALUES(1, "P-15");

-- Create a project with three subprojects:
INSERT INTO Project
VALUES(700, 700, 123, "Rewiring of electrics and water pipe installation of a summer cottage.", "Mr. Virtanen", "Kirkkotie 12, Pälkäne", "2020-06-01", "2020-07-01");

INSERT INTO Project
VALUES(701, 700, 123, "Wiring part of project 700", "Mr. Virtanen", "Kirkkotie 12, Pälkäne", "2020-06-01", "2020-06-08");

INSERT INTO Project
VALUES(702, 700, 123, "Digging the ground for pipe installation", "Mr. Virtanen", "Kirkkotie 12, Pälkäne", "2020-06-09", "2020-06-20");

INSERT INTO Project
VALUES(703, 700, 123, "Installing water pipes", "Mr. Virtanen", "Kirkkotie 12, Pälkäne", "2020-06-21", "2020-07-01");

-- Set required machines:
-- Excavator for digging and pipe connector for installing pipes
INSERT INTO Required_Machines
VALUES(702, "E-001", 1);

INSERT INTO Required_Machines
VALUES(703, "P-15", 1);

-- Set required employees
-- Electrician for wiring, machine operator for digging and plumber for pipe installation
INSERT INTO Required
VALUES(701, "Electical installation", 1);

INSERT INTO Required
VALUES(702, "Machine operation", 1);

INSERT INTO Required
VALUES(703, "Plumbing skills", 1);

-- Assign employees with needed skills
INSERT INTO Assignment
VALUES(701, 401);

INSERT INTO Assignment
VALUES(702, 401);

INSERT INTO Assignment
VALUES(703, 402);

-- Reserve machines for project duration

-- One of the excavators
INSERT INTO Reservation
VALUES(800, 702, 1, "E-001", "2020-06-09", "2020-06-20");
-- Pipe connecter
INSERT INTO Reservation
VALUES(801, 703, 1, "P-15", "2020-06-21", "2020-07-01");

-- Let's say that one of the machines breaks down during the project
-- Let's add an out-of-use case and a new reservation
INSERT INTO Out_of_use
VALUES(1, "E-001", "2020-06-12", "2020-06-20");

INSERT INTO Reservation
VALUES(802, 702, 2, "E-001", "2020-06-12", "2020-06-20");

-- Now we have used every other table in out system except Absent
-- Everything is working well so far

-- Let's add a second project with an absense
INSERT INTO Project
VALUES(704, 704, 123, "Demolition of an old storage building.", "John Johnson", "Klarinettipolku 3, Helsinki", "2020-08-10", "2020-08-25");

INSERT INTO Project
VALUES(705, 704, 123, "Paperwork for demolition.", "John Johnson", "Moonlight avenue 14", "2020-08-10", "2020-08-12");

INSERT INTO Project
VALUES(706, 704, 123, "Actual demolition process.", "John Johnson", "Klarinettipolku 3, Helsinki", "2020-08-13", "2020-08-25");

-- Reserve Excavator and hammer for demolition
INSERT INTO Required_Machines
VALUES(706, "E-001", 1);
INSERT INTO Required_Machines
VALUES(706, "H-001", 1);

-- Requirements for someone to know excel for paperwork and machine operation for demolition
INSERT INTO Required
VALUES(705, "Excel skills", 1);
INSERT INTO Required
VALUES(706, "Machine operation", 1);

-- Assign employees with proper qualifiations
INSERT INTO Assignment
VALUES(705, 401);
INSERT INTO Assignment
VALUES(706, 400);

-- Reserve excavator for a week
INSERT INTO Reservation
VALUES(804, 706, 1, "E-001", "2020-08-13", "2020-08-20");
-- Reserve hammer for the whole duration
INSERT INTO Reservation
VALUES(805, 706, 1, "H-001", "2020-08-13", "2020-08-25");

-- Absense of Joe
INSERT INTO Absent
VALUES(400, 706, "2020-08-18", "2020-08-25", 401);

-- Assign Boris to his position
INSERT INTO Assignment
VALUES(706, 401);


-- Now let's test our key constraints.

-- Obviously we can't add employees to a non-existing company
INSERT INTO Employee
Values(404, "Tester", "E. Rror", 111);
-- FOREIGN key constraint failed

-- Moving on to select queries

--Query to find the description to the given qualification
SELECT *
FROM Qualification
WHERE type='Machine operation';

--Check the qualifications of an employee "400"
SELECT type
FROM has_qualification
WHERE SSID=400;

--Checks all the projects contracted to a company
SELECT project_ID, Project.description
FROM Company, Project
WHERE Company.name='Work bois' AND Project.company_ID=Company.Company_ID;

--Query to search all the company's machines
SELECT model
FROM Machine, Company
WHERE Machine.company_ID=Company.company_ID AND Company.name='Work bois';

--Finds all machines which are manufactured by pied piper
SELECT *
FROM Machine
WHERE manufacturer='Pied Piper'
--Query to find all the employees assigned to project 666
SELECT Employee.name
FROM Employee, Assignment
WHERE Employee.SSID=Assignment.SSID AND project.id=666;
-- This fails due to the fact that there is no project with given id

--Finds all the companies with 0 employees
SELECT company_ID, name
FROM Company
WHERE company_ID NOT IN (SELECT company_ID FROM Employee);

--Finds all projects with the location Espoo
SELECT project_ID, description
FROM Project
WHERE location='Espoo';

--Query to search all the employees not in an assignment
SELECT Employee.name
FROM Employee
WHERE Employee.SSID NOT IN (SELECT SSID FROM Assignment);

--Counts the amount of employees who are employed by the company 123
SELECT COUNT(SSID)
FROM  Employee
WHERE company_ID=123;

--Query to get the free employees for a certain day.
SELECT DISTINCT Employee.SSID
FROM Assignment, Project, Employee
WHERE Employee.SSID = Assignment.SSID AND Assignment.project_ID = Project.project_ID AND (startdate > '2020-06-21' OR enddate < '2020-06-21');

--Query to get the combined amount of qualificated employees needed to complete a project and its sub project.
SELECT SUM(amount)
FROM Project, Required
WHERE Project.project_ID = 700 or Project.main_project = 700;

--Find all machines that are out of use on a certain day
SELECT serial_number, model
FROM Out_of_use
WHERE startdate < '2020-06-15' or enddate < '2020-06-15';

--Find all reservations for a company
SELECT reservation_ID
FROM Company, Machine, Machine_number, Reservation
WHERE Company.company_ID = Machine.company_ID and Machine.model = Machine_number.model
and Machine_number.model = Reservation.model and Machine_number.serialNumber = Reservation.serial_number;

-- Query to calculate average fuel consumption for machines needed for subproject with ID 706
SELECT AVG(amount*fuel_consumption) 
FROM Machine
JOIN (
SELECT *
FROM Required_machines
WHERE project_ID = 706
) AS R 
ON Machine.model = R.model;

-- Create index for when out of use machines are again usable
CREATE INDEX Out_of_use_INDEX ON Out_of_use(serial_number, enddate);
             
-- Create index for employee information
CREATE INDEX Employee_INDEX ON Employee(SSID, position, name);
             
-- A view that collects all employees which have Excel skills qualification
CREATE VIEW [EXCEL_PROS] AS
SELECT SSID, name
FROM Employee, Has_qualification
WHERE Employee.SSID=Employee.SSID AND type='Excel skills';
