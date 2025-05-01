CREATE TEMP TABLE "temp_prescription"(
    id INTEGER,
    appointment_id INTEGER,
    drugs_id INTEGER,
    duration INTEGER
);

COPY temp_prescription (id, appointment_id, drugs_id, duration)
FROM 'C:\Users\marc.bridy\InfraDon\InfraDon\data\csv\prescription.csv' --À CHANGER SELON LE CHEMIN D'ACCES
DELIMITER ',' CSV HEADER;

INSERT INTO appointment (id, appointment_id, drugs_id, start_date, end_date)
SELECT tp.id, tp.appointment_id, tp.drugs_id, tp.duration
FROM temp_prescription tp
ON CONFLICT (id) DO NOTHING;