CREATE TEMP TABLE "temp_prescription"(
    id INTEGER,
    appointment_id INTEGER,
    drugs_id INTEGER,
    duration INTEGER
);

COPY temp_prescription (id, appointment_id, drugs_id, duration)
FROM '/private/tmp/prescription.csv' --À CHANGER SELON LE CHEMIN D'ACCES
DELIMITER ',' CSV HEADER;

INSERT INTO prescription (id, appointment_id, drugs_id, start_date, end_date)
SELECT 
    tp.id,
    tp.appointment_id,
    tp.drugs_id,
    a.date_of AS start_date,
    a.date_of + INTERVAL '1 day' * tp.duration AS end_date
FROM temp_prescription tp
JOIN appointment a ON tp.appointment_id = a.id
ON CONFLICT (id) DO NOTHING;