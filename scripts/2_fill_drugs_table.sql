CREATE TEMP TABLE IF NOT EXISTS "temp_drugs"(
    id INTEGER,
    name text,
    dosage text,
    type text
);

COPY temp_drugs (id, name, dosage, type)
FROM '/private/tmp/drug.csv' --À CHANGER SELON LE CHEMIN D'ACCES
DELIMITER ',' CSV HEADER;

INSERT INTO drugs (id, name, dosage, type)
SELECT tp.id, tp.name, tp.dosage, tp.type
FROM temp_drugs tp
ON CONFLICT (id) DO NOTHING;