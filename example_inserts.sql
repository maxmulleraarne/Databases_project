INSERT INTO Company
Values(123, "Moonlight avenue 14", "Work bois");

INSERT INTO Employee
Values(445, "Main work man", "Joe Jobs", 123);

INSERT INTO Employee
Values(555, "CEO", "Boris Bronco", 123);

INSERT INTO Qualification
Values("Electical installation", "Worker can safely install wiring and do other electronical installation.");

INSERT INTO Qualification
Values("Excel skills", "Worker can do basic operations in microsoft excel.");

INSERT INTO Qualification
Values("Machine operation", "Worker can operate heavy machinery such as excavator.");

INSERT INTO Has_qualification
Values(555, "Excel skills");

INSERT INTO Has_qualification
Values(445, "Electrical installation");

INSERT INTO Has_qualification
Values(445, "Machine operation");

INSERT INTO Machine
Values("E-001", "Large excavator, useful for moving large amounts of land", "Hitachi", "L", "15", 123);

INSERT INTO Machine
Values("H-001", "Construction site hammer", "Fiskars", "M", "0", 123);

INSERT INTO Machine_number
VALUES(111, "E-001");

INSERT INTO Machine_number
VALUES(112, "E-001");

INSERT INTO Machine_number
VALUES(200, "H-001");

