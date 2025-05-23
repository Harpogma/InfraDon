CREATE TABLE IF NOT EXISTS temp_patient (
    Id INTEGER,
    Nom TEXT,
    Prenom TEXT,
    Date_de_naissance DATE,
    Adresse TEXT,
    Telephone TEXT
);

COPY temp_patient (Id, Nom, Prenom, Date_de_naissance, Adresse, Telephone)
FROM '/private/tmp/patient.csv'
WITH CSV HEADER;

CREATE TABLE IF NOT EXISTS temp_patient_update (
    Id INTEGER,
    Assurance TEXT,
    Sexe TEXT,
    Adresse TEXT
);

COPY temp_patient_update (Id, Assurance, Sexe, Adresse)
FROM '/private/tmp/patient_update.csv'
WITH CSV HEADER;

INSERT INTO patient (date_of_birth, address, person_id)
SELECT Date_de_naissance, Adresse, Id
FROM temp_patient tp
ON CONFLICT (Id) DO NOTHING;

UPDATE patient
SET insurance_id = i.id
FROM temp_patient_update tp
INNER JOIN insurance i ON i.long_descr = split_part(tp.Assurance, ' +', 1)
INNER JOIN person p ON p.id = tp.Id 
WHERE patient.person_id = p.id;