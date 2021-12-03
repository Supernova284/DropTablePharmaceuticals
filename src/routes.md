# Routes
## Doctor
GET - /doctor/all <br />
GET - /doctor/patient { id: int }<br />
POST - /doctor

## Patient
GET - /patient { id: int }<br />
POST - /patient
{ firstName, lastName, phoneNumber, streetName, streetNumber, city, zip, insurance }

## Auth
GET - /auth/login { username, password }
POST - /auth/signup { username, password, passwordConfirm }