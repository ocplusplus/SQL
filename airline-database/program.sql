----SEQUENCES----
-- Create sequence for customerID
CREATE SEQUENCE customer_seq START WITH 10010 INCREMENT BY 1;
-- Create sequence for employeeNum
CREATE SEQUENCE employee_seq START WITH 110 INCREMENT BY 1;
-- Create sequence for manufacturerID
CREATE SEQUENCE manufacturer_seq START WITH 1 INCREMENT BY 1;
-- Create sequence for pilotLicenseID
CREATE SEQUENCE pilotlicense_seq START WITH 1 INCREMENT BY 1;
-- Create sequence for charterTripID
CREATE SEQUENCE chartertrip_seq START WITH 10001 INCREMENT BY 1;

----TABLE CREATIONS----
CREATE TABLE Customer (
    customerID INT DEFAULT customer_seq.NEXTVAL,
    customerFirstName VARCHAR2(50) NOT NULL,
    customerLastName VARCHAR2(50) NOT NULL,
    customerPhone VARCHAR2(15),
    balance NUMBER(10, 2),
    CONSTRAINT pk_customer PRIMARY KEY (customerID)
);


CREATE TABLE Destination (
destinationID VARCHAR2(10) PRIMARY KEY,
destinationName VARCHAR2(50) NOT NULL
);

CREATE TABLE Employee (
    employeeNum INT,
    employeePrefix VARCHAR(5),
    employeeFirstName VARCHAR2(50) NOT NULL,
    employeeLastName VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_employee PRIMARY KEY (employeeNum)
);


CREATE TABLE CrewJob (
    crewJobID INT,
    crewJobDesc VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_CrewJob PRIMARY KEY (crewJobID)
);

CREATE TABLE MedicalExam (
    medicalTypeID INT,
    medicalExamType VARCHAR2(50) NOT NULL UNIQUE,
    CONSTRAINT pk_medicalExam PRIMARY KEY (medicalTypeID),
    CONSTRAINT ck_medicalTypeID CHECK (medicalTypeID IN (1, 2))
);

CREATE TABLE Rating (
    ratingCode VARCHAR2(5),
    ratingName VARCHAR2(50) NOT NULL,
CONSTRAINT pk_ratingCode PRIMARY KEY (ratingCode)
);

CREATE TABLE Manufacturer (
manufacturerID INT DEFAULT manufacturer_seq.NEXTVAL,
manufacturerName VARCHAR2(50) NOT NULL,
CONSTRAINT pk_manufacturer PRIMARY KEY (manufacturerID)
);

CREATE TABLE Model (
aircraftModelCode VARCHAR2(10),
manufacturerID INT,
modelName VARCHAR2(50) NOT NULL,
numSeats INT,
rentalPerMileage DECIMAL(10, 2),
CONSTRAINT pk_model PRIMARY KEY (aircraftModelCode),
CONSTRAINT fk_model_manufacturer FOREIGN KEY (manufacturerID) REFERENCES Manufacturer(manufacturerID)
);

CREATE TABLE Aircraft (
aircraftNum VARCHAR2(15),
totalAirFrame NUMBER(5,1),
totalLeftEngine NUMBER(5,1),
totalRightEngine NUMBER(5,1),
aircraftModelCode VARCHAR2(10),
CONSTRAINT pk_aircraft PRIMARY KEY (aircraftNum),
CONSTRAINT fk_aircraft_model FOREIGN KEY (aircraftModelCode) REFERENCES Model(aircraftModelCode)
);

CREATE TABLE Pilot (
   employeeNum INT,
   pilotLicenseID VARCHAR2(5),
   pilotLicenseName VARCHAR(50),
   medicalTypeID INT,
   CONSTRAINT pk_pilot PRIMARY KEY (employeeNum),
   CONSTRAINT fk_pilot_medicalExam FOREIGN KEY (medicalTypeID) REFERENCES MedicalExam(medicalTypeID)
);

CREATE TABLE PilotRating (
    employeeNum INT,
    pilotLicenseID VARCHAR2(5),
    ratingCode VARCHAR2(10),
    medicalTypeID INT,
    medicalDate DATE,
    earnedRatingDate DATE,
    CONSTRAINT pk_pilot_rating PRIMARY KEY (employeeNum, ratingCode),
    CONSTRAINT fk_pilot_rating_employee FOREIGN KEY (employeeNum) REFERENCES Pilot(employeeNum),
    CONSTRAINT fk_pilot_rating_rating FOREIGN KEY (ratingCode) REFERENCES Rating(ratingCode),
    CONSTRAINT fk_pilot_rating_medical FOREIGN KEY (medicalTypeID) REFERENCES MedicalExam(medicalTypeID)
);


CREATE TABLE CharterTrip (
charterTripID INT DEFAULT chartertrip_seq.NEXTVAL,
customerID INT,
aircraftNum VARCHAR2(15),
charterDate DATE,
destinationID VARCHAR2(10),
distance DECIMAL(6,2),
hoursFlown DECIMAL(5, 1),
waitingHours DECIMAL(5, 1),
fuelGallons DECIMAL(5, 1),
CONSTRAINT pk_chartertrip PRIMARY KEY (charterTripID),
CONSTRAINT fk_chartertrip_customer FOREIGN KEY (customerID) REFERENCES Customer(customerID),
CONSTRAINT fk_chartertrip_aircraft FOREIGN KEY (aircraftNum) REFERENCES Aircraft(aircraftNum),
CONSTRAINT fk_chartertrip_destination FOREIGN KEY (destinationID) REFERENCES Destination(destinationID)
);

-- CharterEmployee table
CREATE TABLE CharterEmployee (
    employeenum INT NOT NULL,
    crewJobID INT NOT NULL,
    charterTripID INT NOT NULL,
    CONSTRAINT pk_charteremployee PRIMARY KEY (employeenum, crewJobID, charterTripID),  
    CONSTRAINT fk_charteremployee_employeenum FOREIGN KEY (employeenum) REFERENCES Employee(employeenum),
    CONSTRAINT fk_charteremployee_crewjob FOREIGN KEY (crewJobID) REFERENCES CrewJob(crewJobID),
    CONSTRAINT fk_charteremployee_chartertrip FOREIGN KEY (charterTripID) REFERENCES CharterTrip(charterTripID)
);



COMMIT;

-----DROP TABLES IN THIS ORDER----
--DROP TABLE CharterEmployee;
--DROP TABLE CharterTrip;
--DROP TABLE PilotRating;
--DROP TABLE Pilot;
--DROP TABLE Aircraft;
--DROP TABLE Model;
--DROP TABLE Manufacturer;
--DROP TABLE Rating;
--DROP TABLE MedicalExam;
--DROP TABLE CrewJob;
--DROP TABLE Employee;
--DROP TABLE Destination;
--DROP TABLE Customer;

---DROP SEQUENCES STATEMENTS---
--DROP SEQUENCE customer_seq;
--DROP SEQUENCE chartertrip_seq;
--DROP SEQUENCE employee_seq;
--DROP SEQUENCE medicalexam_seq;
--DROP SEQUENCE manufacturer_seq;
--DROP SEQUENCE pilotlicense_seq;

----------

----INSERT STATEMENTS----
-- Insert data into Customer table
INSERT INTO Customer (customerFirstName, customerLastName, customerPhone, balance) VALUES ('Alfred', 'Ramas', '615-844-2573', 0.00);
INSERT INTO Customer (customerFirstName, customerLastName, customerPhone, balance) VALUES ('Leona', 'Dunne', '713-894-1238', 0.00);
INSERT INTO Customer (customerFirstName, customerLastName, customerPhone, balance) VALUES ('Kathy', 'Smith', '615-894-2285', 896.54);
INSERT INTO Customer (customerFirstName, customerLastName, customerPhone, balance) VALUES ('Paul', 'Olowski', '615-894-2180', 0.00);
INSERT INTO Customer (customerFirstName, customerLastName, customerPhone, balance) VALUES ('Myron', 'Orlando', '615-222-1672', 673.21);
INSERT INTO Customer (customerFirstName, customerLastName, customerPhone, balance) VALUES ('Amy', 'O''Brian', '713-442-3381', 0.00);
INSERT INTO Customer (customerFirstName, customerLastName, customerPhone, balance) VALUES ('James', 'Brown', '615-297-1228', 0.00);
INSERT INTO Customer (customerFirstName, customerLastName, customerPhone, balance) VALUES ('George', 'Williams', '615-290-2556', 0.00);
INSERT INTO Customer (customerFirstName, customerLastName, customerPhone, balance) VALUES ('Anne', 'Farriss', '713-382-7185', 0.00);
INSERT INTO Customer (customerFirstName, customerLastName, customerPhone, balance) VALUES ('Olette', 'Smith', '615-297-3809', 453.98);


-- Insert data into Destination table
INSERT INTO Destination (destinationID, destinationName) VALUES ('BNA', 'Nashville');
INSERT INTO Destination (destinationID, destinationName) VALUES ('ATL', 'Atlanta');
INSERT INTO Destination (destinationID, destinationName) VALUES ('MOB', 'Mobile');
INSERT INTO Destination (destinationID, destinationName) VALUES ('GNV', 'Gainesville');
INSERT INTO Destination (destinationID, destinationName) VALUES ('STL', 'St. Louis');
INSERT INTO Destination (destinationID, destinationName) VALUES ('TYS', 'Knoxville');
INSERT INTO Destination (destinationID, destinationName) VALUES ('MQV', 'Mostaganem');

-- Insert data into Employee table
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (100, 'Mr.', 'George', 'Kolmycz');
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (101, 'Ms.', 'Rhonda', 'Lewis');
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (102, 'Mr.', 'Rhett', 'VanDam');
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (103, 'Ms.', 'Anne', 'Jones');
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (104, 'Mr.', 'John', 'Lange');
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (105, 'Mr.', 'Robert', 'Williams');
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (106, 'Mrs.', 'Jeanine', 'Duzak');
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (107, 'Mr.', 'Jorge', 'Diante');
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (108, 'Mr.', 'Paul', 'Wiesenbach');
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (109, 'Ms.', 'Elizabeth', 'Travis');
INSERT INTO Employee (employeeNum, employeePrefix, employeeFirstName, employeeLastName) VALUES (110, 'Mrs.', 'Leighla', 'Genkazi');

-- Insert data into CrewJob table
INSERT INTO CrewJob (crewJobID, crewJobDesc) VALUES (1, 'Pilot');
INSERT INTO CrewJob (crewJobID, crewJobDesc) VALUES (2, 'Copilot');


-- Insert data into MedicalExam table
INSERT INTO MedicalExam (medicalTypeID, medicalExamType) VALUES (1, 'First Class Medical Exam');
INSERT INTO MedicalExam (medicalTypeID, medicalExamType) VALUES (2, 'Second Class Medical Exam');

-- Insert data into Rating table
INSERT INTO Rating (ratingCode, ratingName) VALUES ('CFI', 'Certified Flight Instructor');
INSERT INTO Rating (ratingCode, ratingName) VALUES ('CFII', 'Certified Flight Instructor, Instrument');
INSERT INTO Rating (ratingCode, ratingName) VALUES ('INSTR', 'Instrument');
INSERT INTO Rating (ratingCode, ratingName) VALUES ('MEL', 'Multiengine Land');
INSERT INTO Rating (ratingCode, ratingName) VALUES ('SEL', 'Single Engine, Land');
INSERT INTO Rating (ratingCode, ratingName) VALUES ('SES', 'Single Engine, Sea');


-- Insert data into Manufacturer table
INSERT INTO Manufacturer (manufacturerID, manufacturerName) VALUES (1, 'Beechcraft');
INSERT INTO Manufacturer (manufacturerID, manufacturerName) VALUES (2, 'Piper');

-- Insert data into Model table
INSERT INTO Model (aircraftModelCode, manufacturerID, modelName, numSeats, rentalPerMileage) VALUES ('C-90A', 1, 'KingAir', 8, 2.67);
INSERT INTO Model (aircraftModelCode, manufacturerID, modelName, numSeats, rentalPerMileage) VALUES ('PA23-250', 2, 'Aztec', 6, 1.93);
INSERT INTO Model (aircraftModelCode, manufacturerID, modelName, numSeats, rentalPerMileage) VALUES ('PA31-350', 2, 'Navajo Chieftain', 10, 2.35);


-- Insert data into Aircraft table
INSERT INTO Aircraft (aircraftNum, totalAirFrame, totalLeftEngine, totalRightEngine, aircraftModelCode) VALUES ('2289L', 4243.8, 768.9, 1123.4, 'C-90A');
INSERT INTO Aircraft (aircraftNum, totalAirFrame, totalLeftEngine, totalRightEngine, aircraftModelCode) VALUES ('1484P', 1833.1, 1833.1, 101.8, 'PA23-250');
INSERT INTO Aircraft (aircraftNum, totalAirFrame, totalLeftEngine, totalRightEngine, aircraftModelCode) VALUES ('2778V', 7992.9, 1513.1, 789.5, 'PA31-350');
INSERT INTO Aircraft (aircraftNum, totalAirFrame, totalLeftEngine, totalRightEngine, aircraftModelCode) VALUES ('4278Y', 2147.3, 622.1, 243.2, 'PA31-350');


-- Insert data into Pilot table
INSERT INTO Pilot (employeeNum, pilotLicenseID, pilotLicenseName, medicalTypeID) VALUES (101, 'ATP','Airline Transport Pilot', '1');
INSERT INTO Pilot (employeeNum, pilotLicenseID, pilotLicenseName, medicalTypeID) VALUES (104, 'ATP', 'Airline Transport Pilot', '1');
INSERT INTO Pilot (employeeNum, pilotLicenseID, pilotLicenseName, medicalTypeID) VALUES (105, 'COM', 'Commercial Pilot License','2');
INSERT INTO Pilot (employeeNum, pilotLicenseID, pilotLicenseName, medicalTypeID) VALUES (106, 'COM', 'Commercial Pilot License','2');
INSERT INTO Pilot (employeeNum, pilotLicenseID, pilotLicenseName, medicalTypeID) VALUES (109, 'COM', 'Commercial Pilot License','1');


-- Insert data into PilotRating table
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (101, 'ATP', 'CFI', 1, TO_DATE('20-Jan-04', 'DD-Mon-YY'), TO_DATE('18-Feb-96', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (101, 'ATP', 'CFII', 1, TO_DATE('20-Jan-04', 'DD-Mon-YY'), TO_DATE('15-Dec-98', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (101, 'ATP', 'INSTR', 1, TO_DATE('20-Jan-04', 'DD-Mon-YY'), TO_DATE('08-Nov-93', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (101, 'ATP', 'MEL', 1, TO_DATE('20-Jan-04', 'DD-Mon-YY'), TO_DATE('23-Jun-94', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (101, 'ATP', 'SEL', 1, TO_DATE('20-Jan-04', 'DD-Mon-YY'), TO_DATE('21-Apr-93', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (104, 'ATP', 'INSTR', 1, TO_DATE('18-Dec-03', 'DD-Mon-YY'), TO_DATE('15-Jul-96', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (104, 'ATP', 'MEL', 1, TO_DATE('18-Dec-03', 'DD-Mon-YY'), TO_DATE('29-Jan-97', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (104, 'ATP', 'SEL', 1, TO_DATE('18-Dec-03', 'DD-Mon-YY'), TO_DATE('12-Mar-95', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (105, 'COM', 'CFI', 2, TO_DATE('05-Jan-04', 'DD-Mon-YY'), TO_DATE('18-Nov-97', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (105, 'COM', 'INSTR', 2, TO_DATE('05-Jan-04', 'DD-Mon-YY'), TO_DATE('17-Apr-95', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (105, 'COM', 'MEL', 2, TO_DATE('05-Jan-04', 'DD-Mon-YY'), TO_DATE('12-Aug-95', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (105, 'COM', 'SEL', 2, TO_DATE('05-Jan-04', 'DD-Mon-YY'), TO_DATE('23-Sep-94', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (106, 'COM', 'INSTR', 2, TO_DATE('10-Dec-03', 'DD-Mon-YY'), TO_DATE('20-Dec-95', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (106, 'COM', 'MEL', 2, TO_DATE('10-Dec-03', 'DD-Mon-YY'), TO_DATE('02-Apr-96', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (106, 'COM', 'SEL', 2, TO_DATE('10-Dec-03', 'DD-Mon-YY'), TO_DATE('10-Mar-94', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (109, 'COM', 'CFI', 1, TO_DATE('22-Jan-04', 'DD-Mon-YY'), TO_DATE('05-Nov-98', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (109, 'COM', 'CFII', 1, TO_DATE('22-Jan-04', 'DD-Mon-YY'), TO_DATE('21-Jun-03', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (109, 'COM', 'INSTR', 1, TO_DATE('22-Jan-04', 'DD-Mon-YY'), TO_DATE('23-Jul-96', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (109, 'COM', 'MEL', 1, TO_DATE('22-Jan-04', 'DD-Mon-YY'), TO_DATE('15-Mar-97', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (109, 'COM', 'SEL', 1, TO_DATE('22-Jan-04', 'DD-Mon-YY'), TO_DATE('05-Feb-96', 'DD-Mon-YY'));
INSERT INTO PilotRating (employeeNum, pilotLicenseID, ratingCode, medicalTypeID, medicalDate, earnedRatingDate) VALUES (109, 'COM', 'SES', 1, TO_DATE('22-Jan-04', 'DD-Mon-YY'), TO_DATE('12-May-96', 'DD-Mon-YY'));

-- Insert data into CharterTrip table
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10001, 10011, '2289L', TO_DATE('05-Feb-04', 'DD-Mon-YY'), 'ATL', 936.00, 5.1, 2.2, 354.1);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10002, 10016, '2778V', TO_DATE('05-Feb-04', 'DD-Mon-YY'), 'BNA', 936.00, 5.1, 2.2, 354.1);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10003, 10014, '4278Y', TO_DATE('05-Feb-04', 'DD-Mon-YY'), 'GNV', 936.00, 5.1, 2.2, 354.1);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10004, 10019, '1484P', TO_DATE('06-Feb-04', 'DD-Mon-YY'), 'STL', 472.00, 2.9, 4.9, 97.2);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10005, 10011, '2289L', TO_DATE('06-Feb-04', 'DD-Mon-YY'), 'ATL', 1023.00, 5.7, 3.5, 397.7);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10006, 10017, '4278Y', TO_DATE('06-Feb-04', 'DD-Mon-YY'), 'STL', 1023.00, 5.7, 3.5, 397.7);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10007, 10012, '2778V', TO_DATE('06-Feb-04', 'DD-Mon-YY'), 'GNV', 1023.00, 5.7, 3.5, 397.7);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10008, 10014, '1484P', TO_DATE('07-Feb-04', 'DD-Mon-YY'), 'TYS', 644.00, 4.1, 0, 140.6);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10009, 10017, '2289L', TO_DATE('07-Feb-04', 'DD-Mon-YY'), 'GNV', 1574.00, 6.6, 23.4, 459.9);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10010, 10016, '4278Y', TO_DATE('07-Feb-04', 'DD-Mon-YY'), 'ATL', 352.00, 1.9, 5.3, 66.4);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10011, 10012, '1484P', TO_DATE('07-Feb-04', 'DD-Mon-YY'), 'BNA', 352.00, 1.9, 5.3, 66.4);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10012, 10010, '2778V', TO_DATE('08-Feb-04', 'DD-Mon-YY'), 'MOB', 644.00, 3.9, 4.5, 174.3);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10013, 10011, '4278Y', TO_DATE('08-Feb-04', 'DD-Mon-YY'), 'TYS', 884.00, 4.8, 4.2, 215.1);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10014, 10017, '4278Y', TO_DATE('09-Feb-04', 'DD-Mon-YY'), 'ATL', 508.00, 3.1, 0, 105.5);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10015, 10016, '2289L', TO_DATE('09-Feb-04', 'DD-Mon-YY'), 'GNV', 1645.00, 6.7, 0, 459.5);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10016, 10011, '2778V', TO_DATE('07-Feb-04', 'DD-Mon-YY'), 'MQV', 352.00, 1.9, 5.3, 66.4);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10017, 10014, '1484P', TO_DATE('10-Feb-04', 'DD-Mon-YY'), 'STL', 508.00, 3.1, 0, 105.5);
INSERT INTO CharterTrip (charterTripID, customerID, aircraftNum, charterDate, destinationID, distance, hoursFlown, waitingHours, fuelGallons)
VALUES (10018, 10017, '4278Y', TO_DATE('10-Feb-04', 'DD-Mon-YY'), 'TYS', 508.00, 3.1, 0, 105.5);



-- CharterEmployee Table
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (101, 10002, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (101, 10005, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (101, 10011, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (101, 10012, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (101, 10015, 2);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (101, 10017, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (104, 10001, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (104, 10007, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (104, 10011, 2);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (104, 10015, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (104, 10018, 2);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (105, 10003, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (105, 10007, 2);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (105, 10009, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (105, 10013, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (105, 10016, 2);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (105, 10018, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (106, 10004, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (106, 10008, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (106, 10014, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (108, 10010, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (109, 10003, 2);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (109, 10006, 1);
INSERT INTO CharterEmployee (employeeNum, charterTripID, crewJobID) VALUES (109, 10016, 1);

COMMIT;

----NO INDEX STATEMENTS REQUIRED----
----ALL NECESSARY INDEXES ARE COVERED BY PRIMARY & FOREIGN KEYS DEFINED IN THE TABLES----

-------SQL QUERIES------

----USER VIEWS----
----USER VIEW 1----
SELECT
    c.customerID AS "Customer ID", 
    '$' || TO_CHAR(c.balance, '9990.99') AS "Balance",
    c.customerFirstName || ' ' || c.customerLastName AS "Customer name",
    c.customerPhone AS "Customer Phone",
    ct.charterTripID AS "Charter Trip",
    TO_CHAR(ct.charterDate, 'DD-Mon-YY') AS "Charter Date",
    ct.destinationID AS "Destination",
    ct.distance AS "Disatance",
    ct.hoursFlown AS "Hours Flown",
    ct.waitingHours AS "Waiting Hours",
    ct.fuelGallons AS "Fuel Gallons"
    FROM charterTrip ct
    JOIN Customer c ON c.customerID = ct.customerID
    WHERE
        ct.customerID = 10011;


----USER VIEW 2----
SELECT
    ce.employeeNum AS "Employee Number",
    e.employeePrefix || ' ' || e.employeeFirstName || ' ' || e.employeeLastName AS "Employee Name", 
    ct.charterTripID AS "Charter Trip",
    TO_CHAR(ct.charterDate, 'DD-Mon-YY') AS "Charter Date",
    dt.destinationID AS "Destination", 
    cj.crewJobDesc AS "CREW_JOB"
    FROM CharterEmployee ce
    JOIN Employee e ON e.employeeNum = ce.employeeNum
JOIN CharterTrip ct ON ce.charterTripID = ct.charterTripID
JOIN Destination dt ON ct.destinationID = dt.destinationID
JOIN CrewJob cj ON ce.crewJobID = cj.crewJobID
    WHERE ce.employeeNum = 104
ORDER BY ct.charterTripID;

----USER VIEW 3---
SELECT 
    e.employeeNum AS "Employee Number",
    e.employeePrefix || ' ' || e.employeeFirstName || ' ' || e.employeeLastName AS "Employee Name",
    pr.pilotLicenseID AS "Pilot License",
    pr.medicalTypeID AS "Medical Type",
    TO_CHAR(pr.medicalDate, 'DD-Mon-YY') AS "Medical Date",
    pr.ratingCode AS "Rating Code", 
    r.ratingName AS "Rating Name", 
    TO_CHAR(pr.earnedRatingDate, 'DD-Mon-YY') AS "Earned Rating Date"
    FROM PilotRating pr
JOIN Rating r ON pr.ratingCode = r.ratingCode
JOIN Employee e ON e.employeeNum = pr.employeeNum
    WHERE pr.employeeNum = 101
ORDER BY pr.ratingCode;


----USER VIEW 4---
SELECT
    a.totalAirFrame AS "Total Air Frame",
    a.totalLeftEngine AS "Total Left Engine",
    a.totalRightEngine AS "Total Right Engine",
    a.aircraftNum AS "Aircraft Model Code",
    ma.manufacturerName,
    mo.modelName,
    mo.numSeats,
    mo.rentalPerMileage
FROM
    Aircraft a
JOIN
    Model mo ON a.aircraftModelCode = mo.aircraftModelCode
JOIN
    Manufacturer ma ON mo.manufacturerID = ma.manufacturerID
WHERE
    a.aircraftNum = '2289L';


----USER VIEW 5---
SELECT 
    a.aircraftNum AS "Aircraft Number",
    a.totalAirFrame AS "Total time on airframe", 
    a.totalLeftEngine AS "Total time on left engine",
    a.totalRightEngine AS "Total time on right engine", 
    ct.charterTripID AS "Charter Trip",
	TO_CHAR(ct.charterDate, 'DD-Mon-YY') AS "Charter Date",
	ct.destinationID AS "Destination" 
FROM 
    Aircraft a
JOIN 
    charterTrip ct ON ct.aircraftNum = a.aircraftNum
WHERE 
    a.aircraftNum = '2289L'
ORDER BY 
    charterTripID;

----APPENDIX A VIEWS---
----CUSTOMER FLIGHTS FORM----
SELECT
    c.customerID AS "Customer ID",
    c.customerFirstName || ' ' || c.customerLastName AS "Customer Name",
    c.customerPhone AS "Customer Phone",
    '$' || TO_CHAR(c.balance, '9990.99') AS "Balance",
    ct.charterTripID AS "Charter Trip",
    TO_CHAR(ct.charterDate, 'DD-Mon-YY') AS "Charter Date",
    d.destinationID AS "Destination",
    d.destinationName AS "Destination",
    ct.distance AS "Distance",
    ct.hoursFlown AS "Hours Flown",
    ct.waitingHours AS "Waiting Hours",
    ct.fuelGallons AS "Fuel Gallons"
FROM
    Customer c
LEFT JOIN CharterTrip ct ON c.customerID = ct.customerID
LEFT JOIN Destination d ON ct.destinationID = d.destinationID
ORDER BY
    c.customerID, ct.charterTripID;

---CHARTER CREW FORM----
SELECT
    e.employeeNum AS "Employee Number",
    e.employeePrefix || ' ' || e.employeeFirstName || ' ' || e.employeeLastName AS "Employee Name",
    ce.charterTripID AS "Charter Trip",
    TO_CHAR(ct.charterDate, 'DD-Mon-YY') AS "Charter Date",
    d.destinationID AS "Destination ID",
    d.destinationName AS "Destination",
    cj.crewJobDesc AS "CREW_JOB"
FROM
    Employee e
LEFT JOIN CharterEmployee ce ON e.employeeNum = ce.employeeNum
LEFT JOIN CharterTrip ct ON ce.charterTripID = ct.charterTripID
LEFT JOIN Destination d ON ct.destinationID = d.destinationID
LEFT JOIN CrewJob cj ON ce.crewJobID = cj.crewJobID
ORDER BY
    e.employeeNum, ct.charterTripID;

----EMPLOYEE EARNED RATINGS FORM----
SELECT
    pr.employeeNum AS "Employee Number",
    e.employeePrefix || ' ' || e.employeeFirstName || ' ' || e.employeeLastName AS "Employee Name",
    pr.pilotLicenseID AS "PILOT LICENSE",
    p.pilotLicenseName AS "Pilot License",
    me.medicalTypeID AS "Med Type",
    me.medicalExamType AS "Medical Type",
    TO_CHAR(pr.medicalDate, 'DD-Mon-YY') AS "Medical Examination Date",
    pr.ratingCode AS "RTG CODE",
    r.ratingName AS "Rating Name",
    TO_CHAR(pr.earnedRatingDate, 'DD-Mon-YY') AS "Earned Rating Date"

FROM
    PilotRating pr
LEFT JOIN Employee e ON pr.employeeNum = e.employeeNum
LEFT JOIN MedicalExam me ON pr.medicalTypeID = me.medicalTypeID
LEFT JOIN Pilot p ON p.pilotLicenseID = pr.pilotLicenseID
LEFT JOIN Rating r ON pr.ratingCode = r.ratingCode
ORDER BY
    pr.employeeNum, pr.pilotLicenseID, pr.ratingCode;

----AIRCRAFTS MODEL FORM----
SELECT
    a.aircraftNum AS "Aircraft Number",
    TO_CHAR(a.totalAirFrame, '9999.99') AS "Total time on the air frame",
    TO_CHAR(a.totalLeftEngine, '9999.99') AS "Total time on the left engine",
    TO_CHAR(a.totalRightEngine, '9999.99') AS "Total time on the right engine",
    m.aircraftModelCode AS "Aircraft model code",
    ma.manufacturerName AS "Manufacturer",
    m.modelName AS "Model name",
    m.numSeats AS "Number of seats",
    TO_CHAR(m.rentalPerMileage, '$999.99') AS "Rental charge per milege"
FROM
    Aircraft a
LEFT JOIN Model m ON a.aircraftModelCode = m.aircraftModelCode
LEFT JOIN Manufacturer ma ON m.manufacturerID = ma.manufacturerID
ORDER BY
    a.aircraftModelCode;

----AIRCRAFTS CHARTER FORM----
SELECT
    a.aircraftNum AS "Aircraft Number",
    TO_CHAR(a.totalAirFrame, '9999.99') AS "Total time on the air frame",
    TO_CHAR(a.totalLeftEngine, '9999.99') AS "Total time on the left engine",
    TO_CHAR(a.totalRightEngine, '9999.99') AS "Total time on the right engine",
    ct.charterTripID AS "Charter Trip",
    TO_CHAR(ct.charterDate, 'DD-Mon-YY') AS "Charter Date",
    d.destinationID AS "Destination ID"
FROM
    Aircraft a
INNER JOIN CharterTrip ct ON a.aircraftNum = ct.aircraftNum
LEFT JOIN Destination d ON ct.destinationID = d.destinationID
ORDER BY
    a.aircraftNum, ct.charterTripID;

---SELECT STATEMENT TO RETRIEVE ALL CUSTOMERS WHO DO NOT HAVE A CHARTER TRIP---
SELECT
    c.customerID AS "Customer ID",  
    c.customerFirstName || ' ' || c.customerLastName AS "Customer Name",  
    c.customerPhone AS "Customer Phone",  
    '$' || TO_CHAR(c.balance, '999,999,999.00') AS "Balance"
FROM
    Customer c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM CharterTrip ct
        WHERE ct.customerID = c.customerID  
    );

----SELECT STATEMENT TO RETRIEVE ALL EMPLOYEES WHO ARE NOT CHARTER CREW MEMBERS----
SELECT
    e.employeeNum AS "Employee Number",
    e.employeeFirstName || ' ' || e.employeeLastName AS "Employee Name" 
FROM
    Employee e
WHERE
    e.employeeNum NOT IN (
        SELECT DISTINCT employeeNum
        FROM CharterEmployee
    );

