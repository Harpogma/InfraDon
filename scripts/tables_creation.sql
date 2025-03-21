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
    last_name integer NOT NULL,
    first_name integer NOT NULL,
    address text,
    phone_number text NOT NULL,
    gender_id integer REFERENCES gender(id)
);

CREATE TABLE "patient"(
    id SERIAL PRIMARY KEY,
    date_of_birth Date NOT NULL,
    person_id integer REFERENCES person(id),
    insurance text NOT NULL
);

CREATE TABLE "doctor"(
    id SERIAL PRIMARY KEY,
    speciality integer REFERENCES speciality(id),
    hospital text NOT NULL,
    person_id integer REFERENCES person(id)
);

CREATE TABLE "appointment"(
    id SERIAL PRIMARY KEY,
    date_of date NOT NULL,
    motive text NOT NULL,
    patient_id integer REFERENCES patient(id),
    doctor_id integer REFERENCES doctor(id),
    is_first_appointment boolean NOT NULL
);

CREATE TABLE "drugs"(
    id SERIAL PRIMARY KEY,
    name text NOT NULL,
    dosage text NOT NULL,
    TYPE text NOT NULL
);

CREATE TABLE "prescription"(
    id SERIAL PRIMARY KEY,
    appointment_id integer REFERENCES appointment(id),
    drugs_id integer REFERENCES drugs(id),
    start_date date NOT NULL,
    end_date date NOT NULL
);