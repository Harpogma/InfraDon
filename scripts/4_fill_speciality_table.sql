CREATE TEMP TABLE  IF NOT EXISTS temp_speciality (
    id INTEGER,
    nom TEXT, 
    prenom TEXT,
    specialite TEXT,
    hopital TEXT,
    telephone TEXT
);

COPY temp_speciality (id, nom, prenom, specialite, hopital, telephone)
FROM '/private/tmp/doctor.csv'
WITH CSV HEADER;

INSERT INTO speciality (long_descr)
SELECT DISTINCT specialite FROM temp_speciality
ON CONFLICT (id) DO NOTHING;
