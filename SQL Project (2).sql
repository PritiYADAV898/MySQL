create database hospital_management;
use hospital_management;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(10),
    phone_number VARCHAR(20),
    address VARCHAR(255)
);
desc patients;
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(255),
    department VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(255)
);
desc doctors;

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_time TIME,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
   
);
desc appointments;
CREATE TABLE medical_records (
    record_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis VARCHAR(255),
    prescription VARCHAR(255),
    visit_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);


-- Insert sample data into tables

INSERT INTO patients (patient_id, patient_name, date_of_birth, gender, phone_number, address) VALUES
(1, 'John Doe', '1980-01-01', 'Male', '123-456-7890', '123 Main St'),
(2, 'Jane Smith', '1985-05-10', 'Female', '456-789-0123', '456 Oak Ave'),
(3, 'Michael Johnson', '1972-09-15', 'Male', '789-012-3456', '789 Maple Rd'),
(4, 'Emily Williams', '1992-03-20', 'Female', '987-654-3210', '987 Cedar Lane'),
(5, 'William Brown', '1988-11-05', 'Male', '567-890-1234', '567 Pine Street'),
(6, 'Mary Johnson', '1982-07-22', 'Female', '234-567-8901', '234 Elm St'),
(7, 'David Wilson', '1990-09-30', 'Male', '345-678-9012', '345 Birch Rd'),
(8, 'Sarah Davis', '1987-04-14', 'Female', '456-789-0123', '456 Cedar Ln'),
(9, 'Robert Smith', '1975-12-05', 'Male', '567-890-1234', '567 Oak Ave'),
(10, 'Linda Miller', '1983-03-18', 'Female', '678-901-2345', '678 Pine St');


INSERT INTO doctors (doctor_id, doctor_name, department, phone_number, email) VALUES
(1, 'Dr. Patel', 'Cardiology', '111-222-3333', 'drpatel@example.com'),
(2, 'Dr. Garcia', 'Pediatrics', '222-333-4444', 'drgarcia@example.com'),
(3, 'Dr. Nguyen', 'Orthopedics', '333-444-5555', 'drnguyen@example.com'),
(4, 'Dr. Kim', 'Neurology', '444-555-6666', 'drkim@example.com'),
(5, 'Dr. Gupta', 'Oncology', '555-666-7777', 'drgupta@example.com'),
(6, 'Dr. Lewis', 'Dermatology', '666-777-8888', 'drlewis@example.com'),
(7, 'Dr. Turner', 'ENT', '777-888-9999', 'drturner@example.com'),
(8, 'Dr. Carter', 'Psychiatry', '888-999-0000', 'drcarter@example.com'),
(9, 'Dr. Hall', 'Urology', '999-000-1111', 'drhall@example.com'),
(10, 'Dr. Foster', 'Ophthalmology', '111-222-3333', 'drfoster@example.com');

INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, appointment_time) VALUES
(1, 1, 1, '2023-11-01', '10:00:00'),
(2, 2, 2, '2023-11-02', '11:00:00'),
(3, 3, 3, '2023-11-03', '12:00:00'),
(4, 4, 4, '2023-11-04', '13:00:00'),
(5, 5, 5, '2023-11-05', '14:00:00'),
(6, 6, 6, '2023-11-06', '15:00:00'),
(7, 7, 7, '2023-11-07', '16:00:00'),
(8, 8, 8, '2023-11-08', '17:00:00'),
(9, 9, 9, '2023-11-09', '18:00:00'),
(10, 10, 10, '2023-11-10', '19:00:00');

INSERT INTO medical_records (record_id, patient_id, doctor_id, diagnosis, prescription, visit_date) VALUES
(1, 1, 1, 'Hypertension', 'Medication A', '2023-11-01'),
(2, 2, 2, 'Common cold', 'Rest and fluids', '2023-11-02'),
(3, 3, 3, 'Fractured arm', 'Pain medication', '2023-11-03'),
(4, 4, 4, 'Migraine', 'Prescription B', '2023-11-04'),
(5, 5, 5, 'Cancer treatment', 'Chemotherapy', '2023-11-05'),
(6, 6, 6, 'Skin allergy', 'Topical ointment', '2023-11-06'),
(7, 7, 7, 'Ear infection', 'Antibiotics', '2023-11-07'),
(8, 8, 8, 'Anxiety', 'Counseling', '2023-11-08'),
(9, 9, 9, 'UTI', 'Antibiotics', '2023-11-09'),
(10, 10, 10, 'Cataracts', 'Surgery recommended', '2023-11-10');

SELECT doctor_name
FROM doctors
WHERE doctor_id IN (
    SELECT doctor_id
    FROM appointments
    WHERE appointment_date = '2023-11-03'
);


SELECT patient_name, phone_number, address
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM appointments
    WHERE doctor_id IN (
        SELECT doctor_id
        FROM doctors
        WHERE department = 'Pediatrics'
    )
);




SELECT doctor_name
FROM doctors
WHERE doctor_id IN (
    SELECT doctor_id
    FROM appointments
    WHERE appointment_date = '2023-11-03'
);


SELECT patient_name
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM medical_records
    WHERE diagnosis = 'Cancer treatment'
);



SELECT department_name, number_of_staff
FROM departments
WHERE department_head IN (
    SELECT doctor_id
    FROM doctors
    WHERE doctor_name = 'Dr. Smith'
);




SELECT patient_name
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM appointments
    WHERE doctor_id IN (
        SELECT doctor_id
        FROM doctors
        WHERE department = 'Cardiology'
    )
    AND patient_id IN (
        SELECT patient_id
        FROM medical_records
        WHERE diagnosis = 'Hypertension'
    )
);




SELECT patients.patient_name, appointments.appointment_date, appointments.appointment_time, doctors.doctor_name
FROM patients
JOIN appointments ON patients.patient_id = appointments.patient_id
JOIN doctors ON appointments.doctor_id = doctors.doctor_id;



SELECT patients.patient_name, medical_records.diagnosis, medical_records.prescription, doctors.doctor_name
FROM patients
JOIN medical_records ON patients.patient_id = medical_records.patient_id
JOIN doctors ON medical_records.doctor_id = doctors.doctor_id;


SELECT patients.patient_name, appointments.appointment_date, appointments.appointment_time, doctors.department
FROM patients
JOIN appointments ON patients.patient_id = appointments.patient_id
JOIN doctors ON appointments.doctor_id = doctors.doctor_id;



SELECT patients.patient_name, medical_records.diagnosis, medical_records.prescription, doctors.department
FROM patients
JOIN medical_records ON patients.patient_id = medical_records.patient_id
JOIN doctors ON medical_records.doctor_id = doctors.doctor_id;


SELECT patients.patient_name, appointments.appointment_date, appointments.appointment_time, doctors.department
FROM patients
JOIN appointments ON patients.patient_id = appointments.patient_id
JOIN doctors ON appointments.doctor_id = doctors.doctor_id
WHERE appointments.appointment_date >= '2023-11-02';