INSERT INTO doctor (id, hospital, hospital_address, speciality_id, person_id)
VALUES (31, 'City Hospital', '123 Main St, Springfield', 2, 2144);

SELECT p.first_name, p.last_name, COUNT(DISTINCT s.long_descr) AS speciality_count
FROM doctor d
JOIN person p ON d.person_id = p.id
JOIN speciality s ON d.speciality_id = s.id
GROUP BY p.first_name, p.last_name
HAVING COUNT(DISTINCT s.long_descr) > 1;


INSERT INTO appointment (id, date_of, motive, patient_id, doctor_id, is_first_appointment)
VALUES (6000, '2025-01-02', 'Consultation', 46, 28, false);

SELECT a1.id AS appointment_1,
       a2.id AS appointment_2,
       a1.patient_id,
       a1.date_of AS date
FROM appointment a1
JOIN appointment a2
  ON a1.patient_id = a2.patient_id
  AND a1.id < a2.id
  AND a1.date_of = a2.date_of
ORDER BY a1.patient_id, a1.date_of;

SELECT 
    p_patient.first_name AS patient_first_name,
    p_patient.last_name AS patient_last_name,
    p_doctor.first_name AS doctor_first_name,
    p_doctor.last_name AS doctor_last_name,
    s.long_descr AS doctor_speciality
FROM patient pa
JOIN person p_patient ON pa.person_id = p_patient.id
JOIN appointment a ON a.patient_id = pa.id
JOIN doctor d ON a.doctor_id = d.id
JOIN person p_doctor ON d.person_id = p_doctor.id
JOIN speciality s ON d.speciality_id = s.id
ORDER BY patient_last_name, patient_first_name;

SELECT 
    p.first_name AS doctor_first_name,
    p.last_name AS doctor_last_name,
    COUNT(a.id) AS number_of_appointments
FROM doctor d
JOIN person p ON d.person_id = p.id
LEFT JOIN appointment a ON a.doctor_id = d.id
GROUP BY p.first_name, p.last_name
ORDER BY number_of_appointments DESC;

SELECT 
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    pa.id AS patient_id
FROM patient pa
JOIN person p ON pa.person_id = p.id
WHERE pa.insurance_id IS NULL;