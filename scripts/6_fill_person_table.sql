CREATE TEMP TABLE temp_person (
    Id INTEGER,
    Nom TEXT,
    Prenom TEXT,
    Date_de_naissance DATE,
    Adresse TEXT,
    Telephone TEXT
);

COPY temp_person (Id, Nom, Prenom, Date_de_naissance, Adresse, Telephone) 
FROM '/private/tmp/patient.csv' 
WITH CSV HEADER;

INSERT INTO person (id, last_name, first_name, phone_number)
SELECT Id, Nom, Prenom, Telephone FROM temp_person
ON CONFLICT (Id) DO NOTHING;

CREATE TEMP TABLE temp_person_update (
    Id INTEGER,
    Assurance TEXT,
    Sexe TEXT,
    Adresse TEXT
);

COPY temp_person_update (Id, Assurance, Sexe, Adresse) 
FROM '/private/tmp/patient_update.csv' 
WITH CSV HEADER;

UPDATE person
SET gender_id = g.id
FROM temp_person_update tp
INNER JOIN gender g ON g.long_descr = tp.Sexe
WHERE person.id = tp.Id;

CREATE TEMP TABLE temp_doctor (
    Id INTEGER,
    Nom TEXT, 
    Prenom TEXT,
    Specialite TEXT,
    Hopital TEXT,
    Telephone TEXT
);

COPY temp_doctor (Id, Nom, Prenom, Specialite, Hopital, Telephone)
FROM '/private/tmp/doctor.csv'
WITH CSV HEADER;

CREATE TEMP TABLE temp_doctor_update (
    Id INTEGER,
    Sexe TEXT,
    Adresse_update TEXT
);

COPY temp_doctor_update (Id, Sexe, Adresse_update)
FROM '/private/tmp/doctor_update.csv'
WITH CSV HEADER;

INSERT INTO person (id, last_name, first_name, phone_number)
SELECT id, Nom, Prenom, Telephone FROM temp_doctor 
ON CONFLICT (Id) DO NOTHING;

UPDATE person
SET gender_id = g.id
FROM temp_doctor_update tp
INNER JOIN gender g ON g.long_descr = tp.Sexe
WHERE person.id = tp.Id;