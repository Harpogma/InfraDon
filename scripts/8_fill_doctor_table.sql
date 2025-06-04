CREATE TEMP TABLE IF NOT EXISTS temp_doctor (
    id INTEGER,
    nom TEXT, 
    prenom TEXT,
    specialite TEXT,
    hopital TEXT,
    telephone TEXT
);

COPY temp_doctor (id, nom, prenom, specialite, hopital, telephone)
FROM '/private/tmp/doctor.csv'
WITH CSV HEADER;

CREATE TEMP TABLE IF NOT EXISTS temp_doctor_update (
    id INTEGER,
    sexe TEXT,
    adresse_update TEXT
);

COPY temp_doctor_update (id, sexe, adresse_update)
FROM '/private/tmp/doctor_update.csv'
WITH CSV HEADER;

INSERT INTO doctor (hospital, person_id)
SELECT hopital, id
FROM temp_doctor
ON CONFLICT (id) DO NOTHING;


UPDATE doctor d
SET hospital_address = tp.adresse_update
FROM temp_doctor_update tp
WHERE d.person_id = tp.id;

UPDATE doctor d
SET speciality_id = s.id
FROM temp_doctor td
INNER JOIN speciality s ON s.long_descr = td.specialite
WHERE d.person_id = td.id;