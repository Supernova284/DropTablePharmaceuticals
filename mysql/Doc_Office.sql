DROP DATABASE IF EXISTS Doc_Office;
CREATE DATABASE Doc_Office;
DROP TABLE IF EXISTS DOCTOR;
CREATE TABLE DOCTOR(
    Doctor_ID int,
    First_name varchar(45),
    Last_name varchar(45),
    Phone_number char(9),
    Specialty varchar(45),
    Salary int,
    username varchar(45),
    FOREIGN KEY (username) REFERENCES ACCOUNT(username),
    Primary Key (Doctor_ID)
    );
    
DROP TABLE IF EXISTS PATIENT;
CREATE TABLE PATIENT(
    SSN char(9),
    First_name varchar(45),
    Last_name varchar(45),
    Phone_number char(9),
    Street_name varchar(50),
    Street_number char(10),
    City varchar(45),
    Zip_code varchar(10),
    Insurance_ID int,
    username varchar(45),
    FOREIGN KEY (username) REFERENCES ACCOUNT(username),
    Primary Key (SSN)
    );
    
DROP TABLE IF EXISTS PRESCRIPTION;
CREATE TABLE PRESCRIPTION(
     Prescription_ID int,
     Drug_name varchar(45),
     Dosage int,
     Number_of_refills int,
     Date_prescribed char(10),
     Most_recent_filling char(10),
     Prescribed_by int,
     Patient_SSN char(9),
     PRIMARY KEY (Prescription_ID),
     FOREIGN KEY (Date_prescribed) REFERENCES APPOINTMENT(Date),
     FOREIGN KEY (Prescribed_by) REFERENCES DOCTOR(Doctor_ID),
     FOREIGN KEY (Patient_SSN) REFERENCES PATIENT(SSN)
);
CREATE INDEX Name
ON DOCTOR(Doctor_ID,First_name);

DROP TABLE IF EXISTS APPOINTMENT;
CREATE TABLE APPOINTMENT(
    Appointment_number int,
    Test_given int,
    Patient_SSN char(9),
    Doctor_ID int,
    Time char(5),
    Date char(10),
    Room_number int,
    PRIMARY KEY (Appointment_number),
    FOREIGN KEY (Patient_SSN) REFERENCES PATIENT(SSN),
    FOREIGN KEY (Test_given) REFERENCES MEDICAL_TEST(Test_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID)
    );
CREATE INDEX Date_given
ON APPOINTMENT(Date);

DROP TABLE IF EXISTS MEDICAL_TEST;
CREATE TABLE MEDICAL_TEST(
    Test_ID int,
    Doctor_ID int,
    Test_type varchar(45),
    Result varchar(100),
    Patient_SSN char(9),
    Date_given char(10),
    PRIMARY KEY (Test_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID),
    FOREIGN KEY (Patient_SSN) REFERENCES PATIENT(SSN),
    FOREIGN KEY (Date_given) REFERENCES APPOINTMENT(Date)
    );
CREATE INDEX Specialty
ON DOCTOR(Specialty);

DROP TABLE IF EXISTS AUDIT;
CREATE TABLE AUDIT(
    Doctor_ID int,
    Action varchar(100),
    Specialty varchar(45),
    Date_modified char(10),
    FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID),
    FOREIGN KEY (Specialty) REFERENCES DOCTOR(Specialty)
    );
    
DROP TABLE IF EXISTS ACCOUNT;
CREATE TABLE ACCOUNT(
    username varchar(45),
    role varchar(45),
    hash varchar(45),
    salt varchar(45)
    );
    
    
    
