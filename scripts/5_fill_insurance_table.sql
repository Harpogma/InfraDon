CREATE TEMP TABLE temp_insurance (
    Id INTEGER,
    Assurance TEXT,
    Sexe TEXT,
    Adresse TEXT
);

COPY temp_insurance (Id, Assurance, Sexe, Adresse)
FROM '/private/tmp/patient_update.csv'
WITH CSV HEADER;

INSERT INTO insurance (long_descr, supplementary)
SELECT DISTINCT
    CASE
        WHEN POSITION('+' IN Assurance) > 0 THEN LEFT(Assurance, POSITION('+' IN Assurance) - 2)
        ELSE Assurance
    END AS long_descr,
    CASE
        WHEN LOWER(Assurance) LIKE '%complémentaire%' THEN TRUE ELSE FALSE 
    END AS supplementary
FROM temp_insurance 
ON CONFLICT DO NOTHING;