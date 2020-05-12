SELECT *
FROM Qualification
WHERE type='Machine operation';

SELECT type
FROM has_qualification
WHERE SSID=400;

SELECT project_ID, Project.description
FROM Company, Project
WHERE Company.name='Work bois';

SELECT model
FROM Machine, Company
WHERE Machine.company_ID=Company.company_ID AND Company.name='Work bois';

SELECT Employee.name
FROM Employee, Assignment
WHERE Employee.SSID=Assignment.SSID AND project.id=666;

SELECT Employee.name
FROM Employee
WHERE Employee.SSID NOT IN (SELECT SSID FROM Assignment);

SELECT COUNT(SSID)
FROM  Employee
WHERE company_ID=123;

SELECT DISTINCT Employee.SSID
FROM Assignment, Project, Employee
WHERE Employee.SSID = Assignment.SSID AND Assignment.project_ID = Project.project_ID AND (startdate > '2020-06-21' OR enddate < '2020-06-21');

SELECT SUM(amount)
FROM Project, Required
WHERE Project.project_ID = 700 or Project.main_project = 700;
