create table "gender"(
id SERIAL primary key,
long_descr VARCHAR(40) not null
);

create table "speciality"(
id SERIAL primary key,
long_descr VARCHAR(40) not null
);

create table "person"(
id SERIAL primary key,
last_name VARCHAR(50) not null, 
first_name VARCHAR(50) not null,
phone_number VARCHAR(40) not null, 
gender_id integer references gender(id) UNIQUE
);

create table "insurance"(
id SERIAL primary key,
long_descr VARCHAR(40) not null,
supplementary BOOLEAN not null
);

create table "patient"(
id SERIAL primary key,
date_of_birth Date not null,
address VARCHAR(80),
person_id integer references person(id),
insurance_id integer references insurance(id)
);

create table "doctor"(
id SERIAL primary key,
hospital VARCHAR (80) not null,
hospital_address VARCHAR(80),
speciality_id integer references speciality(id), 
person_id integer references person(id)
);

create table "appointment"(
id SERIAL primary key, 
date_of date not null,
motive VARCHAR(30) not null,
patient_id integer references patient(id),
doctor_id integer references doctor(id),
is_first_appointment boolean not null
);

create table "drugs"(
id SERIAL primary key, 
name VARCHAR(50) not null, 
dosage VARCHAR(20) not null,
type VARCHAR(30) not null
);

create table "prescription"(
id SERIAL primary key,
appointment_id integer references appointment(id),
drugs_id integer references drugs(id),
start_date date not null,
end_date date not null
);