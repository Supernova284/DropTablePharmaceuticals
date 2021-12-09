DROP DATABASE IF EXISTS Doc_Office;
CREATE DATABASE Doc_Office;
USE Doc_Office;
DROP TABLE IF EXISTS DOCTOR;

DROP TABLE IF EXISTS ACCOUNT;
CREATE TABLE ACCOUNT(
	username varchar(45) NOT NULL UNIQUE,
    role varchar(45),
    hash varchar(100)
    );
CREATE TABLE DOCTOR(
	Doctor_ID int NOT NULL UNIQUE AUTO_INCREMENT,
    First_name varchar(45),
    Last_name varchar(45),
    username varchar(45),
    Salary int,
    Phone_number char(10),
    PRIMARY KEY (Doctor_ID),
    FOREIGN KEY (username) REFERENCES ACCOUNT(username)
    );
    
DROP TABLE IF EXISTS APPOINTMENT;
CREATE TABLE APPOINTMENT(
	Appointment_number int AUTO_INCREMENT,
    date datetime,
    doctorid int,
    roomNumber int,
    PRIMARY KEY (Appointment_number),
    FOREIGN KEY(doctorid) REFERENCES DOCTOR(Doctor_ID)
    );
    
DROP TABLE IF EXISTS PATIENT;
CREATE TABLE PATIENT(
	SSN char(9) UNIQUE,
    First_name varchar(45),
    Last_name varchar(45),
    Street_name varchar(50),
    Stree_number varchar(10),
    City varchar(45),
    Zip_code varchar(10),
    Phone_number char(10),
    Appointment_number int,
    username varchar(45),
    PRIMARY KEY(SSN),
    FOREIGN KEY (Appointment_number) REFERENCES APPOINTMENT(Appointment_number),
    FOREIGN KEY (username) REFERENCES ACCOUNT(username)
    );
    
DROP TABLE IF EXISTS PRESCRIPTION;
CREATE TABLE PRESCRIPTION(
	Prescription_ID int AUTO_INCREMENT,
    medicineName varchar(100),
    doctorid int,
    Dosage int,
    Numnber_of_refills int,
    Date_prescribed datetime,
    Most_recent_filling datetime,
    PRIMARY KEY(Prescription_ID),
    FOREIGN KEY(doctorid) REFERENCES DOCTOR(Doctor_ID)
);

DROP TABLE IF EXISTS TEST;
CREATE TABLE TEST(
	Test_ID int AUTO_INCREMENT,
    testname varchar(100),
    result varchar(100),
    Prescription_ID int NOT NULL,
    Date_given datetime,
    PRIMARY KEY (Test_ID),
    FOREIGN KEY(Prescription_ID) REFERENCES PRESCRIPTION(Prescription_ID)
);

DROP TABLE IF EXISTS SPECIALIZATION;
CREATE TABLE SPECIALIZATION(
	specialtyid int,
    specialty varchar(45),
    PRIMARY KEY (specialtyid)
    );
DROP TABLE IF EXISTS AUDIT;
CREATE TABLE AUDIT(
	id int AUTO_INCREMENT,
	Doctor_ID int,
    Action varchar(100),
    Date_modified datetime,
    PRIMARY KEY (id),
    FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID)
    );

DROP TABLE IF EXISTS DOCTORPATIENT;
CREATE TABLE DOCTORPATIENT (
  doctorId INT NOT NULL,
  patientid char(9) NOT NULL,
  PRIMARY KEY (doctorId, patientid),
  CONSTRAINT doctorid
    FOREIGN KEY (doctorId)
    REFERENCES DOCTOR (Doctor_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT patientid
    FOREIGN KEY (patientid)
    REFERENCES PATIENT (SSN)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
DROP TABLE IF EXISTS DOCTORTEST;
CREATE TABLE DOCTORTEST(
	doctorId int NOT NULL,
    testid int NOT NULL,
    PRIMARY KEY (doctorId, testid),
    CONSTRAINT doctor_id
	  FOREIGN KEY (doctorId) REFERENCES DOCTOR(Doctor_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
	CONSTRAINT testid
      FOREIGN KEY (testid) REFERENCES TEST(Test_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
    );

DROP TABLE IF EXISTS DOCTORSPECIALIZATION;
CREATE TABLE  DOCTORSPECIALIZATION(
	doctorId int NOT NULL,
    specialtyid int NOT NULL,
    PRIMARY KEY (doctorId, specialtyid),
    CONSTRAINT doctor
	  FOREIGN KEY (doctorId) REFERENCES DOCTOR(Doctor_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
	CONSTRAINT specialtyid
      FOREIGN KEY (specialtyid) REFERENCES SPECIALIZATION(specialtyid)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
    );
DROP TABLE IF EXISTS TESTAPPOINTMENT;
CREATE TABLE  TESTAPPOINTMENT(
	testid int NOT NULL,
    appointmentid int NOT NULL,
    PRIMARY KEY (testid, appointmentid),
    CONSTRAINT test_id
	  FOREIGN KEY (testid) REFERENCES TEST(Test_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
	CONSTRAINT appointmentid_
      FOREIGN KEY (appointmentid) REFERENCES APPOINTMENT(Appointment_number)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
    );
DROP TABLE IF EXISTS TESTPATIENT;
CREATE TABLE  TESTPATIENT(
	testid int NOT NULL,
	patientid char(9) NOT NULL,
    PRIMARY KEY (testid, patientid),
    CONSTRAINT testid_
	  FOREIGN KEY (testid) REFERENCES TEST(Test_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
	CONSTRAINT patientid_
      FOREIGN KEY (patientid) REFERENCES PATIENT(SSN)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
    );
CREATE TABLE PRESCRIPTIONPATIENT(
	Prescription_ID int NOT NULL,
	patientid char(9) NOT NULL,
    PRIMARY KEY (Prescription_ID, patientid),
    CONSTRAINT Prescription_ID 
	  FOREIGN KEY (Prescription_ID ) REFERENCES PRSESCRIPTION(Prescription_ID )
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
	CONSTRAINT patient
      FOREIGN KEY (patientid) REFERENCES PATIENT(SSN)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
    );
