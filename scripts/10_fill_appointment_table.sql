CREATE TEMP TABLE  IF NOT EXISTS "temp_appointment"(
    id INTEGER,
    patient_id INTEGER,
    doctor_id INTEGER,
    date_of DATE,
    motive VARCHAR(50)
);

COPY temp_appointment (id, patient_id, doctor_id, date_of, motive)
FROM '/private/tmp/appointment.csv' 
DELIMITER ',' CSV HEADER;

INSERT INTO appointment (id, date_of, motive, patient_id, doctor_id, is_first_appointment)
SELECT ta.id, ta.date_of, ta.motive, p.id, d.id, false
FROM temp_appointment ta
INNER JOIN doctor d ON d.person_id = ta.doctor_id
INNER JOIN patient p ON p.person_id = ta.patient_id
WHERE ta.patient_id IS NOT NULL
ON CONFLICT (id) DO NOTHING;