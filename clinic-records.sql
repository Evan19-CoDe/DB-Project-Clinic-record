CREATE DATABASE clinic_records;

USE clinic_records;

-- Specializations table
CREATE TABLE Specialization (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Doctors table
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    specialization_id INT,
    FOREIGN KEY (specialization_id) REFERENCES Specialization(specialization_id)
);

-- Patients table
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Appointments table
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Treatments table
CREATE TABLE Treatment (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Many-to-Many: Appointments and Treatments
CREATE TABLE Appointment_Treatment (
    appointment_id INT,
    treatment_id INT,
    PRIMARY KEY (appointment_id, treatment_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (treatment_id) REFERENCES Treatment(treatment_id)
);

-- Billing table (1-to-1 with Appointment)
CREATE TABLE Billing (
    billing_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    total_amount DECIMAL(10,2) NOT NULL,
    paid BOOLEAN DEFAULT FALSE,
    payment_date DATETIME,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- Insert data into the respective tables

-- Insert data into the Doctor Table
INSERT INTO Doctor (full_name, phone, email, specialization_id) VALUES
('Dr. Abubakar Asad', '0700111222', 'asad@clinic.com', 1),
('Dr. Amir Muktar', '0700222333', 'muktar@clinic.com', 2),
('Dr. Hussein Abdi', '0700333444', 'abdi@clinic.com', 3),
('Dr. Hamza Mohammed', '0700444555', 'mohammed@clinic.com', 4),
('Dr. Abdishakur Omar', '0700555666', 'omar@clinic.com', 5); 

-- Insert data into Patient Table 
INSERT INTO Patient (full_name, date_of_birth, gender, phone, email) VALUES
('Aisha Mohamed', '2005-03-12', 'Female', '0712345678', 'aisha@example.com'),
('Bashir Abdi', '2000-07-25', 'Male', '0722345678', 'bashir@example.com'),
('Cate Mugo', '2001-11-05', 'Female', '0733345678', 'cate@example.com'),
('Denise Cheris', '1988-01-18', 'Male', '0744345678', 'denise@example.com'),
('Elizabeth Bett', '1995-09-29', 'Female', '0755345678', 'elizabeth@example.com');

-- Insert data into Appointment Table.
INSERT INTO Appointment (doctor_id, patient_id, appointment_date, reason, status) VALUES
(1, 1, '2025-05-01 10:00:00', 'Chest pain and shortness of breath', 'Completed'),
(2, 2, '2025-05-02 11:30:00', 'Child vaccination', 'Completed'),
(3, 3, '2025-05-03 14:00:00', 'Rash and itching', 'Scheduled'),
(4, 4, '2025-05-04 09:15:00', 'Routine check-up', 'Completed'),
(5, 5, '2025-05-05 16:00:00', 'Knee pain', 'Scheduled');

-- Insert data into the appointment_treatment table.
INSERT INTO Appointment_Treatment (appointment_id, treatment_id) VALUES
(1, 1), -- Paracetamol for chest pain
(1, 4), -- Ibuprofen also
(2, 2), -- Amoxicillin for vaccination precaution
(3, 3), -- Hydrocortisone Cream for rash
(4, 5), -- Vitamin D for general wellness
(5, 4); -- Ibuprofen for knee pain

-- Insert data into Specialization Table.
INSERT INTO Specialization (name) VALUES
('Cardiology'),
('Pediatrics'),
('Dermatology'),
('General Medicine'),
('Orthopedics');

-- Insert data into Treatment Table.
INSERT INTO Treatment (name, description) VALUES
('Paracetamol', 'Used to treat fever and mild pain'),
('Amoxicillin', 'Antibiotic for bacterial infections'),
('Hydrocortisone Cream', 'Used for skin irritation and inflammation'),
('Ibuprofen', 'Pain reliever and anti-inflammatory'),
('Vitamin D Supplements', 'Supports bone health and immune function');

-- Insert data into Billing Table.
INSERT INTO Billing (appointment_id, total_amount, paid, payment_date) VALUES
(1, 1500.00, TRUE, '2025-05-01 12:00:00'),
(2, 1000.00, TRUE, '2025-05-02 12:30:00'),
(3, 750.00, FALSE, NULL),
(4, 500.00, TRUE, '2025-05-04 10:00:00'),
(5, 2000.00, FALSE, NULL);