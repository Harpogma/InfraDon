CREATE TABLE "gender"(
    id SERIAL PRIMARY KEY,
    short_descr CHAR(3) NOT NULL,
    long_descr VARCHAR(40) NOT NULL
);

CREATE TABLE "speciality"(
    id SERIAL PRIMARY KEY,
    short_descr CHAR(3) NOT NULL,
    long_descr VARCHAR(40) NOT NULL
);

CREATE TABLE "type"(
    id SERIAL PRIMARY KEY,
    short_descr CHAR(3) NOT NULL,
    long_descr VARCHAR(40) NOT NULL
);

CREATE TABLE "person"(
    id SERIAL PRIMARY KEY,
    last_name VARCHAR(40) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    address VARCHAR(200),
    phone_number VARCHAR(40) NOT NULL,
    gender_id integer REFERENCES gender(id)
);

CREATE TABLE "patient"(
    id SERIAL PRIMARY KEY,
    date_of_birth Date NOT NULL,
    person_id integer REFERENCES person(id),
    insurance VARCHAR(30) NOT NULL
);

CREATE TABLE "doctor"(
    id SERIAL PRIMARY KEY,
    speciality_id integer REFERENCES speciality(id),
    hospital VARCHAR(50) NOT NULL,
    person_id integer REFERENCES person(id)
);

CREATE TABLE "appointment"(
    id SERIAL PRIMARY KEY,
    date_of date NOT NULL,
    motive VARCHAR(50) NOT NULL,
    patient_id integer REFERENCES patient(id),
    doctor_id integer REFERENCES doctor(id),
    is_first_appointment boolean NOT NULL
);

CREATE TABLE "drugs"(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    dosage VARCHAR(20) NOT NULL,
    type INTEGER REFERENCES type(id)
);

CREATE TABLE "prescription"(
    id SERIAL PRIMARY KEY,
    appointment_id integer REFERENCES appointment(id),
    drugs_id integer REFERENCES drugs(id),
    start_date date NOT NULL,
    end_date date NOT NULL
);
