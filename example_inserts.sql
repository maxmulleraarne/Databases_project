-- Set up company
INSERT INTO Company
Values(123, "Moonlight avenue 14", "Work bois");

-- Add three employees
INSERT INTO Employee
Values(400, "Main work man", "Joe Jobs", 123);

INSERT INTO Employee
Values(401, "CEO", "Boris Bronco", 123);

INSERT INTO Employee
Values(402, "Plumber specialist", "Mark Lumber", 123);

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

-- Add three different machine types
INSERT INTO Machine
Values("E-001", 123, "Large excavator, useful for moving large amounts of land", "Hitachi", "L", 15);

INSERT INTO Machine
Values("H-001", 123, "Construction site hammer", "Fiskars", "M", 0);

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
