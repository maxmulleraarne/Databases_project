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


