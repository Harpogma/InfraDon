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