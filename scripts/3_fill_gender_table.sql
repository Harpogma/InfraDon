CREATE TEMP TABLE  IF NOT EXISTS temp_gender (
    id integer,
    assurance TEXT,
    sexe TEXT,
    adresse_corrigee TEXT
);

COPY temp_gender (id, assurance, sexe, adresse_corrigee) 
FROM '/private/tmp/patient_update.csv' 
WITH CSV HEADER;


INSERT INTO gender (long_descr)
SELECT DISTINCT       
       CASE 
           WHEN TRIM(sexe) IN ('Homme') THEN 'Homme'
           WHEN TRIM(sexe) IN ('Femme') THEN 'Femme'
           WHEN TRIM(sexe) IN ('Non-binaire') THEN 'Non-binaire'
           ELSE 'N/A'
       END AS long_descr
FROM temp_gender;