CREATE TABLE DOCTOR(
Doctor_ID int,
Last_Name varchar(45),
First_name varchar(45),
Phone_number char(10),
Specialty varchar(45),
Primary Key (Doctor_ID)
);

CREATE TABLE PATIENT(
SSN char(9),
Last_Name varchar(45),
Primary_Phone_number char(10),
Street_name varchar(100),
Street_number varchar(45),
City varchar(45),
Zip_code varchar(10),
First_name varchar(45),
Insurance_ID int,
Primary KEY (SSN)
);

CREATE TABLE PRESCRIPTION(
Prescription_ID int,
Drug_name varchar(45),
Dosage int,
Number_of_refills int,
Date_Prescribed char(10),
Most_recent_filing char(10),
Prescribed_by int,
Patient_SSN char(9),
Primary KEY (Prescription_ID),
FOREIGN KEY (Date_prescribed) REFERENCES APPOINTMENT(Date_of_appointment),
FOREIGN KEY (Prescribed_by) REFERENCES DOCTOR(Doctor_ID),
FOREIGN KEY (Patient_SSN) REFERENCES PATIENT(SSN)
);

CREATE TABLE APPOINTMENT(
Appointment_number int,
Test_given int,
Patient_SSN char(9),
Doctor_name varchar(45),
Doctor_ID int,
Time char(5),
Date_of_appointment char(10),
Room_number int,
PRIMARY KEY (Appointment_number),
FOREIGN KEY (Test_given) REFERENCES MEDICAL_TEST (Test_ID),
FOREIGN KEY (Patient_SSN) REFERENCES PATIENT (SSN),
FOREIGN KEY (Doctor_name) REFERENCES DOCTOR (First_name),
FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID)
);

CREATE TABLE MEDICAL_TEST(
Test_ID int,
Doctor_name varchar(45),
Doctor_ID int,
Test_type varchar(45),
Result varchar(45),
Patient_SSN char(9),
Date_Given char(10),
PRIMARY KEY (Test_ID),
FOREIGN KEY (Doctor_name) REFERENCES DOCTOR(First_name),
FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID),
FOREIGN KEY (Patient_SSN) REFERENCES PATIENT (SSN)
);

CREATE TABLE AUDIT (
Doctor_ID int,
Doctor_name varchar(45),
Task varchar(100),
Specialty varchar(45),
Date_Modified char(10),
FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID)
);
