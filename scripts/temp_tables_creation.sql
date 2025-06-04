CREATE TEMP TABLE temp_gender (
id INTEGER,
short_descr VARCHAR(3),
long_descr VARCHAR(40)
);

CREATE TEMP TABLE patient_update (
    id INTEGER,
    assurance VARCHAR(30),
    sexe VARCHAR(30),
    adresse_corrigee VARCHAR(200)
);

CREATE TEMP TABLE doctor_up_to_date (
    id_medecin INTEGER,
    sexe VARCHAR(200),
    adresse_hopital VARCHAR(200)
);

COPY patient_update (id, assurance, sexe, adresse_corrigee)
FROM 'C:\Users\thier\Documents\InfraDon1\InfraDon\data\csv\patient_update.csv'
WITH (FORMAT csv, HEADER true);

COPY doctor_up_to_date (id_medecin, sexe, adresse_hopital)
FROM 'C:\Users\thier\Documents\InfraDon1\InfraDon\data\csv\doctor_update.csv'
WITH (FORMAT csv, HEADER true);

INSERT INTO temp_gender (short_descr, long_descr)
SELECT DISTINCT LEFT(sexe, 3), sexe FROM patient_update
WHERE sexe IS NOT NULL AND sexe <> ''
UNION
SELECT DISTINCT LEFT(sexe, 3), sexe FROM doctor_up_to_date
WHERE sexe IS NOT NULL AND sexe <> '';

INSERT INTO gender (short_descr, long_descr)
SELECT short_descr, long_descr FROM temp_gender
WHERE NOT EXISTS (
    SELECT 1 FROM gender 
    WHERE gender.short_descr = temp_gender.short_descr 
    AND gender.long_descr = temp_gender.long_descr
);

SELECT *
FROM gender;