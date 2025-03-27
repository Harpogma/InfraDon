create table "gender"(
id SERIAL primary key,
short_descr CHAR(3) not null,
long_descr VARCHAR(40) not null
);

create table "speciality"(
id SERIAL primary key,
short_descr CHAR(3) not null,
long_descr VARCHAR(40) not null
);

create table "type"(
id SERIAL primary key,
short_descr CHAR(3) not null,
long_descr VARCHAR(40) not null
);

create table "person"(
id SERIAL primary key,
last_name VARCHAR(50) not null, 
first_name VARCHAR(50) not null,
address text,
phone_number text not null, 
gender_id integer references gender(id)
);

create table "patient"(
id SERIAL primary key,
date_of_birth Date not null,
person_id integer references person(id),
insurance text not null
);

create table "doctor"(
id SERIAL primary key,
speciality integer references speciality(id),
hospital text not null, 
person_id integer references person(id)
);

create table "appointment"(
id SERIAL primary key, 
date_of date not null,
motive text not null,
patient_id integer references patient(id),
doctor_id integer references doctor(id),
is_first_appointment boolean not null
);

create table "drugs"(
id SERIAL primary key, 
name text not null, 
dosage text not null,
type text not null
);

create table "prescription"(
id SERIAL primary key,
appointment_id integer references appointment(id),
drugs_id integer references drugs(id),
start_date date not null,
end_date date not null
);