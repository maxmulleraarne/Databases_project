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
WHERE Company.name='Work bois';

--Query to search all the company's machines
SELECT model
FROM Machine, Company
WHERE Machine.company_ID=Company.company_ID AND Company.name='Work bois';

--Query to find all the employees assigned to project 666
SELECT Employee.name
FROM Employee, Assignment
WHERE Employee.SSID=Assignment.SSID AND project.id=666;

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
